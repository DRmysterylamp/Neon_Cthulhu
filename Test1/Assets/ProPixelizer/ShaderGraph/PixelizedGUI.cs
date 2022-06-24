#if UNITY_EDITOR
using UnityEditor;
using UnityEditor.AnimatedValues;
using UnityEngine;
using UnityEngine.Rendering.Universal;


public class PixelizedGUI : ShaderGUI
{
    bool showColor, showAlpha, showPixelize, showLighting;
    bool useColorGrading, useNormalMap, useEmission, useObjectPosition, useAlpha, useShadows;

    Material Material;

    public const string COLOR_GRADING_ON = "COLOR_GRADING_ON";
    public const string NORMAL_MAP_ON = "NORMAL_MAP_ON";
    public const string USE_EMISSION_ON = "USE_EMISSION_ON";
    public const string USE_OBJECT_POSITION_ON = "USE_OBJECT_POSITION_ON";
    public const string ALPHA_ON = "USE_ALPHA_ON";
    public const string RECEIVE_SHADOWS_ON = "RECEIVE_SHADOWS_ON";

    public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
    {
        materialEditor.serializedObject.Update();
        Material = materialEditor.target as Material;
        useColorGrading = Material.IsKeywordEnabled(COLOR_GRADING_ON);
        useEmission = Material.IsKeywordEnabled(USE_EMISSION_ON);
        useNormalMap = Material.IsKeywordEnabled(NORMAL_MAP_ON);
        useObjectPosition = Material.IsKeywordEnabled(USE_OBJECT_POSITION_ON);
        useAlpha = Material.IsKeywordEnabled(ALPHA_ON);
        useShadows = Material.IsKeywordEnabled(RECEIVE_SHADOWS_ON);

        EditorGUILayout.LabelField("ProPixelizer | Appearance Material", EditorStyles.boldLabel);
        if (GUILayout.Button("User Guide")) Application.OpenURL("https://sites.google.com/view/propixelizer/user-guide");
        EditorGUILayout.Space();
        EditorGUILayout.HelpBox("Please use the ProPixelizer Appearance+Outline material instead. The Appearance+Outline material enhances this shader to add additional passes. Otherwise, you must add a second material using ProPixelizer/SRP/Object Outline to your object.", MessageType.Error);

        DrawAppearanceGroup(materialEditor, properties);
        DrawLightingGroup(materialEditor, properties);
        DrawPixelizeGroup(materialEditor, properties);
        DrawAlphaGroup(materialEditor, properties);

        EditorGUILayout.Space();

        //var enableInstancing = EditorGUILayout.ToggleLeft("Enable GPU Instancing", Material.enableInstancing);
        //Material.enableInstancing = enableInstancing;
        Material.enableInstancing = false;
        var renderQueue = EditorGUILayout.IntField("Render Queue", Material.renderQueue);
        Material.renderQueue = renderQueue;
        var dsgi = EditorGUILayout.ToggleLeft("Double Sided Global Illumination", Material.doubleSidedGI);
        Material.doubleSidedGI = dsgi;

        //EditorUtility.SetDirty(Material);
        materialEditor.serializedObject.ApplyModifiedProperties();
    }

    public void DrawAppearanceGroup(MaterialEditor editor, MaterialProperty[] properties)
    {
        showColor = EditorGUILayout.BeginFoldoutHeaderGroup(showColor, "Appearance");
        if (showColor)
        {
            var albedo = FindProperty("Texture2D_FBC26130", properties);
            editor.TextureProperty(albedo, "Albedo", true);

            var baseColor = FindProperty("_BaseColor", properties);
            editor.ColorProperty(baseColor, "Color");

            var colorGrading = FindProperty("COLOR_GRADING", properties);
            editor.ShaderProperty(colorGrading, "Use Color Grading");
            if (colorGrading.floatValue > 0f)
            {
                var lut = FindProperty("Texture2D_A4CD04C4", properties);
                editor.ShaderProperty(lut, "Palette");
            }

            var normalMap = FindProperty("NORMAL_MAP", properties);
            editor.ShaderProperty(normalMap, "Use Normal Map");
            if (normalMap.floatValue > 0f)
            {
                var normal = FindProperty("Texture2D_4084966E", properties);
                editor.TextureProperty(normal, "Normal Map", true);
            }

            var useEmission = FindProperty("USE_EMISSION", properties);
            editor.ShaderProperty(useEmission, "Use Emission");
            if (useEmission.floatValue > 0f)
            {
                var normal = FindProperty("Texture2D_9A2EA9A0", properties);
                editor.TextureProperty(normal, "Emission", true);
            }

        }
        EditorGUILayout.EndFoldoutHeaderGroup();
    }

    public void DrawLightingGroup(MaterialEditor editor, MaterialProperty[] properties)
    {
        showLighting = EditorGUILayout.BeginFoldoutHeaderGroup(showLighting, "Lighting");
        if (showLighting)
        {
            var ramp = FindProperty("Texture2D_F406AA7C", properties);
            editor.ShaderProperty(ramp, "Lighting Ramp");

            var ambient = FindProperty("Vector3_C98FB62A", properties);
            editor.ShaderProperty(ambient, "Ambient Light");

            var receiveShadows = FindProperty("RECEIVE_SHADOWS", properties);
            editor.ShaderProperty(receiveShadows, "Receive shadows");
        }
        EditorGUILayout.EndFoldoutHeaderGroup();
    }

    public void DrawPixelizeGroup(MaterialEditor editor, MaterialProperty[] properties)
    {
        showPixelize = EditorGUILayout.BeginFoldoutHeaderGroup(showPixelize, "Pixelize");
        if (showPixelize)
        {
            var pixelSize = FindProperty("_PixelSize", properties);
            editor.ShaderProperty(pixelSize, "Pixel Size");

            var useObjectPosition = FindProperty("USE_OBJECT_POSITION", properties);
            editor.ShaderProperty(useObjectPosition, "Object Position");
            EditorGUILayout.HelpBox("Whether to use the object position as the zero coordinate for the pixel grid. For more information, see the 'Aligning Pixel Grids' section in the user guide.", MessageType.Info);
            if (useObjectPosition.floatValue < 0.5f)
            {
                var gridPosition = FindProperty("_PixelGridOrigin", properties);
                editor.ShaderProperty(gridPosition, "Origin (world space)");
            }
        }
        EditorGUILayout.EndFoldoutHeaderGroup();
    }

    public void DrawAlphaGroup(MaterialEditor editor, MaterialProperty[] properties)
    {
        showAlpha = EditorGUILayout.BeginFoldoutHeaderGroup(showAlpha, "Alpha Cutout");
        if (showAlpha)
        {
            useAlpha = EditorGUILayout.ToggleLeft("Alpha Cutout", useAlpha);
            if (useAlpha)
            {
                var threshold = FindProperty("_AlphaClipThreshold", properties);
                editor.ShaderProperty(threshold, "Threshold");
                Material.EnableKeyword(ALPHA_ON);
            }
            else
                Material.DisableKeyword(ALPHA_ON);
        }
        EditorGUILayout.EndFoldoutHeaderGroup();
    }
}
#endif