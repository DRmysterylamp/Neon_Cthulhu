// Copyright Elliot Bentine, 2018-
using UnityEngine;
using UnityEngine.Rendering.Universal;
using UnityEngine.Serialization;
using ProPixelizer;

public class PixelisationFeature : ScriptableRendererFeature
{
    [FormerlySerializedAs("DepthTestOutlines")]
    [Tooltip("Perform depth testing for outlines where object IDs differ. This prevents outlines appearing when one object intersects another, but requires an extra depth sample.")]
    public bool UseDepthTestingForIDOutlines = true;

    [Tooltip("The threshold value used when depth comparing outlines.")]
    public float DepthTestThreshold = 0.001f;

    [Tooltip("Use normals for edge detection. This will analyse pixelated screen normals to determine where edges occur within an objects silhouette.")]
    public bool UseNormalsForEdgeDetection = true;

    public float NormalEdgeDetectionSensitivity = 1f;

    [Tooltip("Which buffer to use for pixelization. ProPixelizer always used SceneColor before v1.6. Use ProPixelizerMetadata if you wish to use HDR.")]
    public PixelizationPass.PixelizationSource SourceBufferForPixelization;

    PixelizationPass _PixelisationPass;
    OutlineDetectionPass _OutlinePass;

    public override void Create()
    {
        _PixelisationPass = new PixelizationPass();
        _PixelisationPass.SourceBuffer = SourceBufferForPixelization;
        _OutlinePass = new ProPixelizer.OutlineDetectionPass();
        _OutlinePass.DepthTestOutlines = UseDepthTestingForIDOutlines;
        _OutlinePass.DepthTestThreshold = DepthTestThreshold;
        _OutlinePass.UseNormalsForEdgeDetection = UseNormalsForEdgeDetection;
        _OutlinePass.NormalEdgeDetectionSensitivity = NormalEdgeDetectionSensitivity;
    }

    public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
    {
        renderer.EnqueuePass(_PixelisationPass);
        renderer.EnqueuePass(_OutlinePass);
    }
}