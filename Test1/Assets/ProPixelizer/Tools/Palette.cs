﻿// Copyright Elliot Bentine, 2018-
#if (UNITY_EDITOR) 

using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using UnityEditor;
using UnityEngine;

namespace ProPixelizer.Tools
{
    [CreateAssetMenu(fileName = "palette", menuName = "ProPixelizer/Palette")]
    public class Palette : ScriptableObject
    {
        [SerializeField]
        [Tooltip("The source texture for the palette.")]
        public Texture2D Source;

        [SerializeField]
        public ColorMethod Method;

        [SerializeField]
        public Vector3 Weights;

        [SerializeField]
        public AnimationCurve VConversionCurve;

        [SerializeField]
        [Tooltip("Should this palette use a dither pattern?")]
        public bool UseDitherPattern;

        [SerializeField]
        [Tooltip("The dither pattern used by this palette.")]
        public DitherPattern DitherPattern;

        public string DescribeColorMethod()
        {
            switch (Method)
            {
                case ColorMethod.HSV_Nearest: return "Match colors to nearest palette color in HSV-space.";
                case ColorMethod.HSV_Weighted: return "Match colors to nearest palette color in HSV-space, using given weights.";
                case ColorMethod.RGB_Nearest: return "Match colors to nearest palette color in RGB-space.";
                case ColorMethod.V_Nearest: return "Match colors to palette color of most similar Value. Input color values are first mapped using the curve.";
                default: return "No description.";
            }
        }

        [SerializeField]
        [Tooltip("Output file name")]
        public string GeneratedFileName;

        [SerializeField]
        [Tooltip("Use an automatic file name or a manually specified path?")]
        public bool AutoGenerateFileName = true;

        public string AutoGeneratedFileName => name + "_LUT";

        #region Palette LUT Generation

        public const int RESOLUTION = 16;
        public const int DITHER_PATTERN_SIZE = 16;

        public bool Generate()
        {
            if (!Source.isReadable)
            {
                Debug.LogError("Palette generation failed: Source texture must be marked as readable.");
                return false;
            }
            palette = new IndexedColorPalette(Source);
            palette.VConversionCurve = VConversionCurve;

            Texture2D generated = new Texture2D(RESOLUTION * RESOLUTION, RESOLUTION * DITHER_PATTERN_SIZE);
            Color[] gPixels = generated.GetPixels(); //pixel array to generate
            Debug.Log("Generating palette texture.");

            var pattern = UseDitherPattern ? DitherPattern : null;

            for (int ditherOrder = 0; ditherOrder < DITHER_PATTERN_SIZE; ditherOrder++)
            {
                for (int b = 0; b < RESOLUTION; b++)
                {
                    Debug.Log(string.Format("Generating dither order {0}, band {1}...", ditherOrder, b));
                    int offset = b * RESOLUTION;
                    for (int r = 0; r < RESOLUTION; r++)
                        for (int g = 0; g < RESOLUTION; g++)
                        {
                            int u = r + offset;
                            int v = g;
                            int index = u + v * RESOLUTION * RESOLUTION + ditherOrder * RESOLUTION * RESOLUTION * RESOLUTION;
                            var originalColor = new Color((float)r / RESOLUTION, (float)g / RESOLUTION, (float)b / RESOLUTION, 1.0f);

                            // Get palette color. 
                            gPixels[index] = palette.Match(originalColor, Method, Weights, pattern, ditherOrder);
                        }
                }
            }
            generated.SetPixels(gPixels);

            SaveGeneratedTexture(generated);
            return true;
        }

        public void SaveGeneratedTexture(Texture2D generated)
        {
            var thisPath = AssetDatabase.GetAssetPath(this);
            var thisDir = thisPath.Substring(0, thisPath.LastIndexOf('/')); // All unity paths use '/'
            var outputName = AutoGenerateFileName ? AutoGeneratedFileName : GeneratedFileName;
            string path = thisDir + "/" + outputName + ".png";
            File.WriteAllBytes(path, generated.EncodeToPNG());

            //Create assets for these textures
            AssetDatabase.ImportAsset(path, ImportAssetOptions.ForceUpdate);

            //Configure generated texture asset
            TextureImporter ti = AssetImporter.GetAtPath(path) as TextureImporter;
            ti.mipmapEnabled = false;
            ti.filterMode = FilterMode.Point;
            ti.wrapMode = TextureWrapMode.Clamp;
            ti.textureCompression = TextureImporterCompression.Uncompressed;
            AssetDatabase.SetLabels(ti, new string[] { "Palette" });
            EditorUtility.SetDirty(ti);
            ti.SaveAndReimport();
        }

        #endregion

        #region Palette Logic

        public enum ColorMethod
        {
            RGB_Nearest,
            HSV_Nearest,
            HSV_Weighted,
            V_Nearest
        }

        private IndexedColorPalette palette;

        /// <summary>
        /// Represents an indexed color palette
        /// </summary>
        public class IndexedColorPalette
        {
            public IndexedColorPalette(Texture2D paletteTexture)
            {
                if (paletteTexture == null)
                    throw new ArgumentException("paletteTexture is null");
                _Colors = new List<Color>();
                _Colors.AddRange(paletteTexture.GetPixels());
                _Colors = new List<Color>(_Colors.Distinct());
            }

            public AnimationCurve VConversionCurve;

            private List<Color> _Colors;

            public int UniqueColorCount => _Colors.Count;

            /// <summary>
            /// Gets the color in the palette that most closely resembles the input color.
            /// </summary>
            public Color GetMostSimilar(Color input, ColorMethod method, Vector3 weights)
            {
                //Find color in palette that is nearest
                return _Colors.Distinct().OrderBy(c => Dissimilarity(input, c, method, weights)).First();
            }

            /// <summary>
            /// Gets the color in the palette that second-most closely resembles the input color.
            /// </summary>
            public Color GetSecondMostSimilar(Color input, ColorMethod method, Vector3 weights)
            {
                return _Colors.Distinct().OrderBy(c => Dissimilarity(input, c, method, weights)).Skip(1).First();
            }

            public Color Match(Color input, ColorMethod method, Vector3 weights, DitherPattern ditherPattern, int ditherOrder)
            {
                var closest = GetMostSimilar(input, method, weights);
                var secondClosest = GetSecondMostSimilar(input, method, weights);

                // Given two colors, find a way to consistently label them 'A' and 'B'.
                var closestAsA = (closest.r + closest.g + closest.b) < (secondClosest.r + secondClosest.g + secondClosest.b);
                var cA = closestAsA ? closest : secondClosest;
                var cB = closestAsA ? secondClosest : closest;

                if (ditherPattern == null)
                    return closest;

                // Find which dither fraction works best.
                float bestScore = float.PositiveInfinity;
                float bestFraction = 0.0f;
                for (int i = 0; i < 16; i++)
                {
                    float fraction = i / 15.0f;
                    var newColor = Color.Lerp(cA, cB, fraction);
                    float score = Mathf.Abs(Dissimilarity(input, newColor, method, weights));
                    if (score < bestScore)
                    {
                        bestFraction = fraction;
                        bestScore = score;
                    }
                }

                
                return Dithered(ditherPattern, cA, cB, ditherOrder, bestFraction);
            }

            public Color Dithered(DitherPattern pattern, Color A, Color B, int order, float fraction)
            {
                return pattern.PickColor(fraction, order) ? A : B;
            }

            /// <summary>
            /// Gets the dissimilarity between two colors, given the specified methods and weights.
            /// </summary>
            public float Dissimilarity(Color a, Color b, ColorMethod method, Vector3 weights)
            {
                // Dissimilarity calculation should be performed in gamma space (more evenly spaced wrt human perception)
                // (source should be an sRGB texture.)

                float hue_a, sat_a, val_a, hue_b, sat_b, val_b;
                Color.RGBToHSV(a, out hue_a, out sat_a, out val_a);
                Color.RGBToHSV(b, out hue_b, out sat_b, out val_b);

                float hueDiff = Math.Abs(hue_a - hue_b);
                //hue wraps in range [0,1], therefore difference in range [0,0.5]
                hueDiff = hueDiff > 0.5 ? 1 - hueDiff : hueDiff;

                float bright_a = (float)(a.r * 0.3 + a.g * 0.59 + a.b * 0.11);
                float bright_b = (float)(b.r * 0.3 + b.g * 0.59 + b.b * 0.11);

                // Weight hue, sat, brightness
                switch (method)
                {
                    case ColorMethod.HSV_Nearest:
                        return (Mathf.Pow(hueDiff, 2f) + Mathf.Pow(bright_a - bright_b, 2f) + Mathf.Pow(sat_a - sat_b, 2f));
                    case ColorMethod.HSV_Weighted:
                        return weights.x * hueDiff + weights.y * Mathf.Abs(bright_a - bright_b) + weights.z * Mathf.Abs(sat_a - sat_b);
                    case ColorMethod.RGB_Nearest:
                        return (new Vector3(a.r, a.g, a.b) - new Vector3(b.r, b.g, b.b)).sqrMagnitude;
                    case ColorMethod.V_Nearest:
                        bright_a = VConversionCurve.Evaluate(bright_a);
                        return Mathf.Abs(bright_a - bright_b);
                    default:
                        return 0f;
                }
            }
        }

        //Useful article:
        // https://stackoverflow.com/questions/27374550/how-to-compare-color-object-and-get-closest-color-in-an-color

        #endregion Palette
    }
}

 #endif