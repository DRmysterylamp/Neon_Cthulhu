// Copyright Elliot Bentine, 2018-
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering.Universal;

namespace ProPixelizer
{
    /// <summary>
    /// Abstract base for ProPixelizer passes
    /// </summary>
    public abstract class ProPixelizerPass : ScriptableRenderPass
    {
        #region Materials
        private Dictionary<string, Material> Materials = new Dictionary<string, Material>();
        public Material GetMaterial(string shaderName)
        {
            Material material;
            if (Materials.TryGetValue(shaderName, out material))
            {
                return material;
            }
            else
            {
                Shader shader = Shader.Find(shaderName);

                if (shader == null)
                {
                    Debug.LogError("Shader not found (" + shaderName + "), check if missed shader is in Shaders folder if not reimport this package. If this problem occurs only in build try to add all shaders in Shaders folder to Always Included Shaders (Project Settings -> Graphics -> Always Included Shaders)");
                }

                Material NewMaterial = new Material(shader);
                NewMaterial.hideFlags = HideFlags.HideAndDontSave;
                Materials.Add(shaderName, NewMaterial);
                return NewMaterial;
            }
        }
        #endregion
    }
}