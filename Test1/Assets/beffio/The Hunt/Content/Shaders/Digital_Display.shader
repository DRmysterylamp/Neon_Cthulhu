// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "beffio/The Hunt/Digital Display"
{
	Properties
	{
		_Emission("Emission", 2D) = "white" {}
		_Halobarswidth("Halo bars width", Range( 0 , 40)) = 2
		_Normal("Normal", 2D) = "bump" {}
		_Albedo("Albedo", 2D) = "white" {}
		_Metallic("Metallic", 2D) = "white" {}
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		_Texture0("Texture 0", 2D) = "white" {}
		_EmissionIntensity("Emission Intensity", Range( 0 , 10)) = 0
		_Speed("Speed", Range( 0 , 10)) = 1
		_HoloColor("Holo Color", Color) = (0,0.8344827,1,0)
		_HoloIntensity("Holo Intensity", Range( 0 , 0.1)) = 0
		_Tiling("Tiling", Vector) = (1,1,0,0)
		_Offset("Offset", Vector) = (0,0,0,0)
		_Rotation("Rotation", Float) = 180
		_GlithIntensity("Glith Intensity", Range( 0 , 5)) = 1
		_Glitchinterval("Glitch interval", Range( 0 , 1)) = 1
		_ImagepanY("Image pan Y", Range( 0 , 5)) = 0
		_ImagepanX("Image pan X", Range( 0 , 5)) = 0
		[Toggle]_BarsVerticalHorizontal("Bars Vertical/Horizontal", Float) = 0
		_Posterize("Posterize", Range( 1 , 256)) = 1
		_Glitchpixels("Glitch pixels", 2D) = "white" {}
		_PixelGlitchColor("Pixel Glitch Color", Color) = (0.06617647,0.06617647,0.06617647,0)
		_PixelGlitchTiling("Pixel Glitch Tiling", Range( 0 , 10)) = 3
		_Pixelationintensity("Pixelation intensity", Range( 0 , 1)) = 0
		_Pixelsamount("Pixels amount", Range( 0 , 2)) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
		};

		uniform sampler2D _Normal;
		uniform float4 _Normal_ST;
		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform float _Posterize;
		uniform sampler2D _Texture0;
		uniform float _ImagepanX;
		uniform float _ImagepanY;
		uniform float2 _Tiling;
		uniform float _GlithIntensity;
		uniform float _Glitchinterval;
		uniform float2 _Offset;
		uniform float _Rotation;
		uniform sampler2D _TextureSample1;
		uniform float4 _TextureSample1_ST;
		uniform sampler2D _Emission;
		uniform float4 _Emission_ST;
		uniform float4 _PixelGlitchColor;
		uniform sampler2D _Glitchpixels;
		uniform float _PixelGlitchTiling;
		uniform float _Pixelsamount;
		uniform float _Pixelationintensity;
		uniform float _Halobarswidth;
		uniform float _BarsVerticalHorizontal;
		uniform float _Speed;
		uniform float4 _HoloColor;
		uniform float _HoloIntensity;
		uniform float _EmissionIntensity;
		uniform sampler2D _Metallic;
		uniform float4 _Metallic_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			o.Normal = UnpackNormal( tex2D( _Normal, uv_Normal ) );
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			float4 tex2DNode1 = tex2D( _Albedo, uv_Albedo );
			float2 appendResult138 = (float2(_ImagepanX , _ImagepanY));
			float temp_output_30_0 = ( sin( ( _Time.w * 20.0 ) ) * ( 0.005 * _GlithIntensity ) * pow( step( ( tan( _Time.y ) * _Glitchinterval ) , 1E-05 ) , 2.0 ) );
			float2 appendResult41 = (float2(temp_output_30_0 , ( temp_output_30_0 * 0.1 )));
			float2 uv_TexCoord26 = i.uv_texcoord * _Tiling + ( appendResult41 + _Offset );
			float2 panner136 = ( uv_TexCoord26 + 1.0 * _Time.y * appendResult138);
			float temp_output_109_0 = radians( _Rotation );
			float cos108 = cos( temp_output_109_0 );
			float sin108 = sin( temp_output_109_0 );
			float2 rotator108 = mul( panner136 - float2( 0,0 ) , float2x2( cos108 , -sin108 , sin108 , cos108 )) + float2( 0,0 );
			float2 uv_TexCoord97 = i.uv_texcoord * _Tiling + _Offset;
			float2 panner135 = ( uv_TexCoord97 + 1.0 * _Time.y * appendResult138);
			float cos113 = cos( temp_output_109_0 );
			float sin113 = sin( temp_output_109_0 );
			float2 rotator113 = mul( panner135 - float2( 0,0 ) , float2x2( cos113 , -sin113 , sin113 , cos113 )) + float2( 0,0 );
			float2 uv_TextureSample1 = i.uv_texcoord * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
			float4 lerpResult40 = lerp( ( tex2D( _Texture0, rotator108 ) * pow( ( temp_output_30_0 + 1.0 ) , 5.0 ) ) , tex2D( _Texture0, rotator113 ) , tex2D( _TextureSample1, uv_TextureSample1 ).r);
			float2 uv_Emission = i.uv_texcoord * _Emission_ST.xy + _Emission_ST.zw;
			float4 tex2DNode4 = tex2D( _Emission, uv_Emission );
			float4 lerpResult7 = lerp( tex2DNode1 , lerpResult40 , tex2DNode4.r);
			float div146=256.0/float((int)_Posterize);
			float4 posterize146 = ( floor( lerpResult7 * div146 ) / div146 );
			float4 blendOpSrc178 = posterize146;
			float4 blendOpDest178 = _PixelGlitchColor;
			float2 appendResult168 = (float2(_PixelGlitchTiling , _PixelGlitchTiling));
			float2 uv_TexCoord150 = i.uv_texcoord * appendResult168 + float2( 0,0 );
			float2 uv_TexCoord162 = i.uv_texcoord * float2( 0.05,0.05 ) + float2( 0,0 );
			float2 panner161 = ( uv_TexCoord162 + 1.0 * _Time.y * float2( 1,0.02 ));
			float4 temp_output_152_0 = step( tex2D( _Glitchpixels, uv_TexCoord150 ) , ( tex2D( _TextureSample1, panner161 ) * _Pixelsamount ) );
			float4 lerpResult166 = lerp( posterize146 , ( saturate( (( blendOpDest178 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpDest178 - 0.5 ) ) * ( 1.0 - blendOpSrc178 ) ) : ( 2.0 * blendOpDest178 * blendOpSrc178 ) ) )) , temp_output_152_0.r);
			float4 lerpResult173 = lerp( posterize146 , lerpResult166 , _Pixelationintensity);
			float4 lerpResult180 = lerp( tex2DNode1 , lerpResult173 , tex2DNode4.r);
			o.Albedo = lerpResult180.rgb;
			float3 ase_worldPos = i.worldPos;
			float temp_output_63_0 = sin( ( ( ( _Halobarswidth * lerp(ase_worldPos.y,ase_worldPos.x,_BarsVerticalHorizontal) ) + ( 1.0 - ( _Speed * _Time.y ) ) ) * UNITY_PI ) );
			float clampResult69 = clamp( (0.0 + (temp_output_63_0 - -1.0) * (1.0 - 0.0) / (1.0 - -1.0)) , 0.0 , 1.0 );
			float4 lerpResult75 = lerp( float4(1,1,1,0) , float4(0,0,0,0) , clampResult69);
			float temp_output_64_0 = ( ( ase_worldPos.z / 100.0 ) * _Time.x );
			float myVarName367 = ( temp_output_64_0 * temp_output_63_0 );
			float4 temp_cast_7 = (myVarName367).xxxx;
			float4 ScanLines71 = ( lerpResult75 - temp_cast_7 );
			float4 blendOpSrc8 = tex2DNode4;
			float4 blendOpDest8 = ( lerpResult40 + ( ScanLines71 * ( _HoloColor * ( _HoloIntensity * 0.5 ) ) ) );
			float4 lerpResult9 = lerp( tex2DNode4 , ( saturate( (( blendOpDest8 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpDest8 - 0.5 ) ) * ( 1.0 - blendOpSrc8 ) ) : ( 2.0 * blendOpDest8 * blendOpSrc8 ) ) )) , tex2DNode4.r);
			float div147=256.0/float((int)_Posterize);
			float4 posterize147 = ( floor( ( lerpResult9 * _EmissionIntensity ) * div147 ) / div147 );
			float4 blendOpSrc177 = posterize147;
			float4 blendOpDest177 = _PixelGlitchColor;
			float4 lerpResult158 = lerp( posterize147 , ( saturate( (( blendOpDest177 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpDest177 - 0.5 ) ) * ( 1.0 - blendOpSrc177 ) ) : ( 2.0 * blendOpDest177 * blendOpSrc177 ) ) )) , temp_output_152_0.r);
			float4 lerpResult172 = lerp( posterize147 , lerpResult158 , _Pixelationintensity);
			float4 lerpResult181 = lerp( tex2DNode4 , lerpResult172 , tex2DNode4.r);
			o.Emission = lerpResult181.rgb;
			float2 uv_Metallic = i.uv_texcoord * _Metallic_ST.xy + _Metallic_ST.zw;
			float4 tex2DNode2 = tex2D( _Metallic, uv_Metallic );
			o.Metallic = tex2DNode2.r;
			o.Smoothness = tex2DNode2.a;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=14201
8;100;1035;937;7373.887;4480.347;5.668355;True;False
Node;AmplifyShaderEditor.SimpleTimeNode;46;-4082.615,-135.8001;Float;False;1;0;FLOAT;1.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;132;-3950.929,89.62006;Float;False;Property;_Glitchinterval;Glitch interval;16;0;Create;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TanOpNode;118;-3797.755,-139.7068;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;84;-3091.382,2759.987;Float;False;Property;_Speed;Speed;9;0;Create;1;6.33;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;131;-3592.929,-48.37994;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;83;-3052.21,2988.376;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TimeNode;106;-3230.883,-293.8665;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;31;-3358.555,208.8753;Float;False;Constant;_Shakeintensity;Shake intensity;6;0;Create;0.005;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;120;-3396.582,339.0298;Float;False;Property;_GlithIntensity;Glith Intensity;15;0;Create;1;0.41;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;101;-3357.341,5.27297;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;1E-05;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;55;-3216.752,2239.621;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;-2755.367,2881.375;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;140;-3222.504,2432.93;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;107;-3019.685,-197.7763;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;20.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;142;-2929.504,2232.93;Float;False;Property;_BarsVerticalHorizontal;Bars Vertical/Horizontal;19;0;Create;0;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;115;-3080.142,94.71143;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;2.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;119;-3048.582,258.0298;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;54;-2769.705,2602.274;Float;False;Property;_Halobarswidth;Halo bars width;2;0;Create;2;20;0;40;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;53;-2597.27,2851.889;Float;False;1;0;FLOAT;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;28;-2843.703,-206.64;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-2811.416,185.5665;Float;False;3;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;-2386.83,2738.966;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;6.06;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;42;-2811.913,500.4358;Float;False;Constant;_Float1;Float 1;6;0;Create;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;57;-2420.587,2855.345;Float;False;True;False;False;False;1;0;FLOAT;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;126;-2651.506,413.2682;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;59;-2194.169,2720.188;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PiNode;58;-2179.336,2850.956;Float;False;1;0;FLOAT;1.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;61;-1988.158,2723.639;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;96;-2556.539,-211.8657;Float;False;Property;_Offset;Offset;13;0;Create;0,0;2.8,0.04;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.WorldPosInputsNode;72;-2595.822,2250.662;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;41;-2470.909,332.0389;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;137;-3272.783,621.9896;Float;False;Property;_ImagepanX;Image pan X;18;0;Create;0;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;60;-2348.258,2302.81;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;100.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;62;-2683.311,2395.497;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;122;-2582.053,-66.66715;Float;False;Property;_Tiling;Tiling;12;0;Create;1,1;0.41,0.53;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;139;-3278.341,700.4678;Float;False;Property;_ImagepanY;Image pan Y;17;0;Create;0;0.03;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;63;-1833.645,2807.89;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;95;-2330.703,39.59704;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;110;-2801.164,-495.9701;Float;False;Property;_Rotation;Rotation;14;0;Create;180;180;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;70;-1624.979,2768.308;Float;False;5;0;FLOAT;0.0;False;1;FLOAT;-1.0;False;2;FLOAT;1.0;False;3;FLOAT;0.0;False;4;FLOAT;1.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;64;-2253.742,2448.716;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;26;-2295.533,160.6649;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;138;-2911.134,650.5278;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ClampOpNode;69;-1431.032,2758.266;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;-1796.714,2522.509;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RadiansOpNode;109;-2638.545,-443.0243;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;136;-2038.85,169.0403;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;73;-1618.381,2399.895;Float;False;Constant;_Color0;Color 0;2;0;Create;1,1,1,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;97;-2354.928,336.8468;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;74;-1619.28,2574.622;Float;False;Constant;_Color1;Color 1;2;0;Create;0,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;75;-1238.865,2586.187;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.PannerNode;135;-2065.233,361.9651;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;67;-1642.089,2305.893;Float;False;myVarName3;-1;True;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;35;-2010.021,-82.79662;Float;True;Property;_Texture0;Texture 0;7;0;Create;None;513a1c102f9e8fa4685ff249ab816616;False;white;Auto;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SimpleAddOpNode;129;-2678.418,76.25542;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;1.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;108;-1879.998,179.5207;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;88;-2809.267,929.381;Float;False;Property;_HoloIntensity;Holo Intensity;11;0;Create;0;0.058;0;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;130;-2545.459,88.38504;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;5.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;68;-1053.661,2519.595;Float;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;82;-2638.759,600.6326;Float;False;Property;_HoloColor;Holo Color;10;0;Create;0,0.8344827,1,0;0.2411762,0.05147055,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;5;-1607.384,123.9334;Float;True;Property;_DisplayImage;Display Image;2;0;Create;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RotatorNode;113;-1865.274,353.2685;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;134;-2466.719,854.1173;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;87;-2224.267,756.381;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;79;-2287.419,575.2673;Float;False;71;0;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;127;-1233.153,171.4493;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;71;-270.644,2379.859;Float;False;ScanLines;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;36;-1608.698,329.8411;Float;True;Property;_TextureSample0;Texture Sample 0;2;0;Create;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;39;-1643.603,886.2126;Float;True;Property;_TextureSample1;Texture Sample 1;6;0;Create;None;74082dda369008f42a9492dcd339e85f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;40;-1061.934,421.8693;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;81;-1824.352,628.6442;Float;False;2;2;0;COLOR;0.0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;4;-1530.167,-96.77501;Float;True;Property;_Emission;Emission;1;0;Create;None;26cd54d0b2680064a945f6a91547fffe;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;93;-1048.018,212.2153;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;8;-777.4863,113.2481;Float;False;Overlay;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;167;-775.4373,-1075.632;Float;False;Property;_PixelGlitchTiling;Pixel Glitch Tiling;23;0;Create;3;0.29;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;162;-691.7682,-807.4735;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;0.05,0.05;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;9;-344.1068,110.3694;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;49;-570.2719,298.8134;Float;False;Property;_EmissionIntensity;Emission Intensity;8;0;Create;0;4.27;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;161;-331.3011,-832.7875;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,0.02;False;1;FLOAT;1.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1;-1530.807,-660.0817;Float;True;Property;_Albedo;Albedo;4;0;Create;None;ae72a918a376cbb47a51a550309f5994;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;168;-420.4373,-1036.632;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;176;208.9496,-542.5364;Float;False;Property;_Pixelsamount;Pixels amount;25;0;Create;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;150;-89.69241,-1016.24;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;3,3;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;-153.0474,235.1152;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;160;144.7086,-748.4352;Float;True;Property;_TextureSample2;Texture Sample 2;6;0;Create;None;None;True;0;False;white;Auto;False;Instance;39;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;7;-297.0509,-374.9702;Float;False;3;0;COLOR;0.0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;148;31.29239,445.1498;Float;False;Property;_Posterize;Posterize;20;0;Create;1;256;1;256;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;149;298.3991,-973.4632;Float;True;Property;_Glitchpixels;Glitch pixels;21;0;Create;None;faab624b561959d4890b8b54dd043989;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PosterizeNode;147;417.3525,338.7091;Float;False;1;2;1;COLOR;0,0,0,0;False;0;INT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;175;562.9496,-597.5364;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.PosterizeNode;146;388.9899,-102.2243;Float;False;1;2;1;COLOR;0,0,0,0;False;0;INT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;164;318.0592,-446.8225;Float;False;Property;_PixelGlitchColor;Pixel Glitch Color;22;0;Create;0.06617647,0.06617647,0.06617647,0;0.06617645,0.06617645,0.06617645,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendOpsNode;177;665.8227,-376.1899;Float;False;Overlay;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;178;678.1129,-235.9247;Float;False;Overlay;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;152;696.6321,-1048.371;Float;False;2;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;158;1005.596,-245.0467;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;166;999.1564,19.97586;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;174;1022.192,-541.5224;Float;False;Property;_Pixelationintensity;Pixelation intensity;24;0;Create;0;0.88;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;172;1261.598,-230.5511;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;173;1260.192,39.4776;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;94;-1470.488,639.9043;Float;False;Constant;_Float4;Float 4;12;0;Create;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TriplanarNode;27;-1974.152,-272.9733;Float;True;Spherical;World;False;Top Texture 0;_TopTexture0;white;0;None;Mid Texture 0;_MidTexture0;white;-1;None;Bot Texture 0;_BotTexture0;white;-1;None;Triplanar Sampler;False;8;0;SAMPLER2D;;False;5;FLOAT;1.0;False;1;SAMPLER2D;;False;6;FLOAT;0.0;False;2;SAMPLER2D;;False;7;FLOAT;0.0;False;3;FLOAT;1.0;False;4;FLOAT;1.0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;181;1690.443,413.3139;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;180;1785.015,-219.095;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RotatorNode;123;-1940.154,835.5792;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;2;-1526.622,-470.2291;Float;True;Property;_Metallic;Metallic;5;0;Create;None;78767956b496e3049a31b5103e5eb3a2;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RadiansOpNode;124;-2185.46,942.9565;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;125;-2523.911,1070.909;Float;False;Constant;_Float2;Float 2;13;0;Create;10;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;65;-2086.819,2312.361;Float;False;Simplex2D;1;0;FLOAT2;100,100;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;3;-1527.805,-282.3203;Float;True;Property;_Normal;Normal;3;0;Create;None;a5ffc216b63f2614b835794508164df2;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;89;-1143.364,673.6353;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;179;1009.726,-820.7243;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2154.409,242.287;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;beffio/The Hunt/Digital Display;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;118;0;46;0
WireConnection;131;0;118;0
WireConnection;131;1;132;0
WireConnection;101;0;131;0
WireConnection;52;0;84;0
WireConnection;52;1;83;2
WireConnection;107;0;106;4
WireConnection;142;0;55;2
WireConnection;142;1;140;1
WireConnection;115;0;101;0
WireConnection;119;0;31;0
WireConnection;119;1;120;0
WireConnection;53;0;52;0
WireConnection;28;0;107;0
WireConnection;30;0;28;0
WireConnection;30;1;119;0
WireConnection;30;2;115;0
WireConnection;56;0;54;0
WireConnection;56;1;142;0
WireConnection;57;0;53;0
WireConnection;126;0;30;0
WireConnection;126;1;42;0
WireConnection;59;0;56;0
WireConnection;59;1;57;0
WireConnection;61;0;59;0
WireConnection;61;1;58;0
WireConnection;41;0;30;0
WireConnection;41;1;126;0
WireConnection;60;0;72;3
WireConnection;63;0;61;0
WireConnection;95;0;41;0
WireConnection;95;1;96;0
WireConnection;70;0;63;0
WireConnection;64;0;60;0
WireConnection;64;1;62;1
WireConnection;26;0;122;0
WireConnection;26;1;95;0
WireConnection;138;0;137;0
WireConnection;138;1;139;0
WireConnection;69;0;70;0
WireConnection;66;0;64;0
WireConnection;66;1;63;0
WireConnection;109;0;110;0
WireConnection;136;0;26;0
WireConnection;136;2;138;0
WireConnection;97;0;122;0
WireConnection;97;1;96;0
WireConnection;75;0;73;0
WireConnection;75;1;74;0
WireConnection;75;2;69;0
WireConnection;135;0;97;0
WireConnection;135;2;138;0
WireConnection;67;0;66;0
WireConnection;129;0;30;0
WireConnection;108;0;136;0
WireConnection;108;2;109;0
WireConnection;130;0;129;0
WireConnection;68;0;75;0
WireConnection;68;1;67;0
WireConnection;5;0;35;0
WireConnection;5;1;108;0
WireConnection;113;0;135;0
WireConnection;113;2;109;0
WireConnection;134;0;88;0
WireConnection;87;0;82;0
WireConnection;87;1;134;0
WireConnection;127;0;5;0
WireConnection;127;1;130;0
WireConnection;71;0;68;0
WireConnection;36;0;35;0
WireConnection;36;1;113;0
WireConnection;40;0;127;0
WireConnection;40;1;36;0
WireConnection;40;2;39;0
WireConnection;81;0;79;0
WireConnection;81;1;87;0
WireConnection;93;0;40;0
WireConnection;93;1;81;0
WireConnection;8;0;4;0
WireConnection;8;1;93;0
WireConnection;9;0;4;0
WireConnection;9;1;8;0
WireConnection;9;2;4;0
WireConnection;161;0;162;0
WireConnection;168;0;167;0
WireConnection;168;1;167;0
WireConnection;150;0;168;0
WireConnection;48;0;9;0
WireConnection;48;1;49;0
WireConnection;160;1;161;0
WireConnection;7;0;1;0
WireConnection;7;1;40;0
WireConnection;7;2;4;0
WireConnection;149;1;150;0
WireConnection;147;1;48;0
WireConnection;147;0;148;0
WireConnection;175;0;160;0
WireConnection;175;1;176;0
WireConnection;146;1;7;0
WireConnection;146;0;148;0
WireConnection;177;0;147;0
WireConnection;177;1;164;0
WireConnection;178;0;146;0
WireConnection;178;1;164;0
WireConnection;152;0;149;0
WireConnection;152;1;175;0
WireConnection;158;0;147;0
WireConnection;158;1;177;0
WireConnection;158;2;152;0
WireConnection;166;0;146;0
WireConnection;166;1;178;0
WireConnection;166;2;152;0
WireConnection;172;0;147;0
WireConnection;172;1;158;0
WireConnection;172;2;174;0
WireConnection;173;0;146;0
WireConnection;173;1;166;0
WireConnection;173;2;174;0
WireConnection;181;0;4;0
WireConnection;181;1;172;0
WireConnection;181;2;4;0
WireConnection;180;0;1;0
WireConnection;180;1;173;0
WireConnection;180;2;4;0
WireConnection;123;2;124;0
WireConnection;124;0;125;0
WireConnection;65;0;64;0
WireConnection;89;1;94;0
WireConnection;0;0;180;0
WireConnection;0;1;3;0
WireConnection;0;2;181;0
WireConnection;0;3;2;0
WireConnection;0;4;2;4
ASEEND*/
//CHKSM=6D26F134E8BDC23993C5430B5C6F50F67A737B4B