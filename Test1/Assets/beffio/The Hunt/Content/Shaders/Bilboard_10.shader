// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "beffio/The Hunt/Bilboard_10"
{
	Properties
	{
		_Metallic("Metallic", 2D) = "white" {}
		_Mask("Mask", 2D) = "white" {}
		_Emission("Emission", 2D) = "white" {}
		_Albedo("Albedo", 2D) = "white" {}
		_EmissionColor("Emission Color", Color) = (0,0.462069,1,0)
		_ColorGreenchannelDefault("Color  Green channel (Default)", Color) = (1,0.8068966,0,0)
		_Normal("Normal", 2D) = "bump" {}
		_Emissionintensity("Emission intensity", Range( 0 , 200)) = 0
		_ColorBluechannel("Color Blue channel", Color) = (0,0.2965517,1,0)
		_Global_Multiply("Global_Multiply", Color) = (1,1,1,0)
		_ColorRedchannel("Color Red channel", Color) = (1,0,0,0)
		_Metallicshift("Metallic shift", Range( 0 , 2)) = 1
		_Smoothnesshift("Smoothnes shift", Range( 0 , 2)) = 1
		_DiffuseContrast("Diffuse Contrast", Range( 0 , 2)) = 0
		_GreenChannelMultiplyBlend("Green Channel Multiply/Blend", Range( 0 , 1)) = 0
		_BlueChannelMultiplyBlend("Blue Channel Multiply/Blend", Range( 0 , 1)) = 0
		_RedChannelMultiplyBlend("Red Channel Multiply/Blend", Range( 0 , 1)) = 0
		_RedBlending("Red Blending", Range( 0 , 10)) = 1
		_Letters_Mask("Letters_Mask", 2D) = "white" {}
		_A_Switch("A_Switch", Int) = 0
		_H_Switch("H_Switch", Int) = 0
		_D_Switch("D_Switch", Int) = 0
		_E_Switch("E_Switch", Int) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Normal;
		uniform float4 _Normal_ST;
		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform float4 _Global_Multiply;
		uniform float4 _ColorBluechannel;
		uniform float _BlueChannelMultiplyBlend;
		uniform sampler2D _Mask;
		uniform float4 _Mask_ST;
		uniform float4 _ColorRedchannel;
		uniform float _RedChannelMultiplyBlend;
		uniform float _RedBlending;
		uniform float4 _ColorGreenchannelDefault;
		uniform float _GreenChannelMultiplyBlend;
		uniform float _DiffuseContrast;
		uniform float4 _EmissionColor;
		uniform sampler2D _Emission;
		uniform float4 _Emission_ST;
		uniform float _Emissionintensity;
		uniform int _D_Switch;
		uniform sampler2D _Letters_Mask;
		uniform int _E_Switch;
		uniform int _A_Switch;
		uniform int _H_Switch;
		uniform sampler2D _Metallic;
		uniform float4 _Metallic_ST;
		uniform float _Metallicshift;
		uniform float _Smoothnesshift;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			o.Normal = UnpackNormal( tex2D( _Normal, uv_Normal ) );
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			float4 blendOpSrc38 = tex2D( _Albedo, uv_Albedo );
			float4 blendOpDest38 = _Global_Multiply;
			float4 temp_output_38_0 = ( saturate( ( blendOpSrc38 * blendOpDest38 ) ));
			float4 blendOpSrc22 = _ColorBluechannel;
			float4 blendOpDest22 = temp_output_38_0;
			float4 lerpResult54 = lerp( ( saturate( (( blendOpDest22 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpDest22 - 0.5 ) ) * ( 1.0 - blendOpSrc22 ) ) : ( 2.0 * blendOpDest22 * blendOpSrc22 ) ) )) , _ColorBluechannel , _BlueChannelMultiplyBlend);
			float2 uv_Mask = i.uv_texcoord * _Mask_ST.xy + _Mask_ST.zw;
			float4 tex2DNode7 = tex2D( _Mask, uv_Mask );
			float4 lerpResult24 = lerp( temp_output_38_0 , lerpResult54 , tex2DNode7.b);
			float4 blendOpSrc26 = _ColorRedchannel;
			float4 blendOpDest26 = lerpResult24;
			float4 lerpResult47 = lerp( ( saturate( ( blendOpSrc26 * blendOpDest26 ) )) , _ColorRedchannel , _RedChannelMultiplyBlend);
			float clampResult59 = clamp( ( tex2DNode7.r * _RedBlending ) , 0.0 , 1.0 );
			float4 lerpResult27 = lerp( lerpResult24 , lerpResult47 , clampResult59);
			float4 blendOpSrc35 = lerpResult27;
			float4 blendOpDest35 = _ColorGreenchannelDefault;
			float4 lerpResult56 = lerp( ( saturate( (( blendOpDest35 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpDest35 - 0.5 ) ) * ( 1.0 - blendOpSrc35 ) ) : ( 2.0 * blendOpDest35 * blendOpSrc35 ) ) )) , _ColorGreenchannelDefault , _GreenChannelMultiplyBlend);
			float4 lerpResult11 = lerp( lerpResult27 , lerpResult56 , tex2DNode7.g);
			float4 blendOpSrc46 = lerpResult11;
			float4 blendOpDest46 = lerpResult11;
			float4 lerpResult45 = lerp( lerpResult11 , ( saturate( (( blendOpDest46 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpDest46 - 0.5 ) ) * ( 1.0 - blendOpSrc46 ) ) : ( 2.0 * blendOpDest46 * blendOpSrc46 ) ) )) , _DiffuseContrast);
			o.Albedo = lerpResult45.rgb;
			float2 uv_Emission = i.uv_texcoord * _Emission_ST.xy + _Emission_ST.zw;
			float4 tex2DNode5 = tex2D( _Emission, uv_Emission );
			float4 lerpResult107 = lerp( _EmissionColor , float4( 0,0,0,0 ) , tex2DNode5.r);
			float4 _Color2 = float4(1,1,1,0);
			float4 _Color1 = float4(0,0,0,0);
			float4 lerpResult109 = lerp( _Color2 , _Color1 , (float)_D_Switch);
			float2 uv_TexCoord61 = i.uv_texcoord * float2( 1,1 ) + float2( 0,0 );
			float4 lerpResult96 = lerp( lerpResult109 , float4( 0,0,0,0 ) , tex2D( _Letters_Mask, uv_TexCoord61 ));
			float4 lerpResult112 = lerp( _Color2 , _Color1 , (float)_E_Switch);
			float2 uv_TexCoord84 = i.uv_texcoord * float2( 1,1 ) + float2( -0.25,0 );
			float4 lerpResult101 = lerp( lerpResult112 , float4( 0,0,0,0 ) , tex2D( _Letters_Mask, uv_TexCoord84 ));
			float4 lerpResult114 = lerp( _Color2 , _Color1 , (float)_A_Switch);
			float2 uv_TexCoord85 = i.uv_texcoord * float2( 1,1 ) + float2( -0.5,0 );
			float4 lerpResult104 = lerp( lerpResult114 , float4( 0,0,0,0 ) , tex2D( _Letters_Mask, uv_TexCoord85 ));
			float4 lerpResult116 = lerp( _Color2 , _Color1 , (float)_H_Switch);
			float2 uv_TexCoord86 = i.uv_texcoord * float2( 1,1 ) + float2( -0.75,0 );
			float4 lerpResult105 = lerp( lerpResult116 , float4( 0,0,0,0 ) , tex2D( _Letters_Mask, uv_TexCoord86 ));
			float4 lerpResult108 = lerp( float4( 0,0,0,0 ) , ( lerpResult96 + lerpResult101 + lerpResult104 + lerpResult105 ) , tex2DNode5.r);
			float4 lerpResult77 = lerp( float4( 0,0,0,0 ) , ( lerpResult107 * _Emissionintensity ) , lerpResult108.r);
			o.Emission = lerpResult77.rgb;
			float2 uv_Metallic = i.uv_texcoord * _Metallic_ST.xy + _Metallic_ST.zw;
			float4 tex2DNode6 = tex2D( _Metallic, uv_Metallic );
			o.Metallic = ( tex2DNode6 * _Metallicshift ).r;
			o.Smoothness = ( tex2DNode6.a * _Smoothnesshift );
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=14201
0;90;3440;1286;1771.317;3109.358;1.784122;True;False
Node;AmplifyShaderEditor.SamplerNode;3;-1868.731,-673.4716;Float;True;Property;_Albedo;Albedo;3;0;Create;None;e649369af1695134a9512a9913ec40f4;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;37;-1766.851,-1024.291;Float;False;Property;_Global_Multiply;Global_Multiply;9;0;Create;1,1,1,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendOpsNode;38;-1335.853,-706.4761;Float;False;Multiply;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;23;-1297.441,-1236.147;Float;False;Property;_ColorBluechannel;Color Blue channel;8;0;Create;0,0.2965517,1,0;0,0.2965517,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendOpsNode;22;-812.7372,-1005.207;Float;False;Overlay;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;53;-1838.79,-323.9924;Float;False;Property;_BlueChannelMultiplyBlend;Blue Channel Multiply/Blend;15;0;Create;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;7;-1642.892,302.5895;Float;True;Property;_Mask;Mask;1;0;Create;None;6b0ba72b14d187c458ec8867828295a1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;54;-761.8105,-844.2001;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;24;-395.2352,-657.0308;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;25;-1033.259,-1462.248;Float;False;Property;_ColorRedchannel;Color Red channel;10;0;Create;1,0,0,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;58;-1578.637,546.7034;Float;False;Property;_RedBlending;Red Blending;17;0;Create;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;57;-1240.749,393.3768;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-1826.463,-418.3873;Float;False;Property;_RedChannelMultiplyBlend;Red Channel Multiply/Blend;16;0;Create;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;26;-234.4426,-1209.49;Float;False;Multiply;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;59;-498.5813,-249.3509;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;47;-160.417,-830.3444;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.IntNode;115;1726.926,-2698.313;Float;False;Property;_H_Switch;H_Switch;24;0;Create;0;0;0;1;INT;0
Node;AmplifyShaderEditor.ColorNode;100;776.5663,-3093.12;Float;False;Constant;_Color2;Color 2;25;0;Create;1,1,1,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;99;749.1533,-2913.464;Float;False;Constant;_Color1;Color 1;25;0;Create;0,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.IntNode;113;1745.196,-2856.091;Float;False;Property;_A_Switch;A_Switch;23;0;Create;0;0;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;111;1748.517,-3033.798;Float;False;Property;_E_Switch;E_Switch;26;0;Create;0;0;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;110;1771.123,-3253.349;Float;False;Property;_D_Switch;D_Switch;25;0;Create;0;0;0;1;INT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;85;906.8344,-1531.096;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;-0.5,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;27;25.17012,-650.1014;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;86;913.8344,-1308.096;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;-0.75,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;84;896.8344,-1733.096;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;-0.25,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;61;871.9807,-1965.144;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;9;-820.4963,-538.9298;Float;False;Property;_ColorGreenchannelDefault;Color  Green channel (Default);5;0;Create;1,0.8068966,0,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;112;2055.476,-2856.777;Float;False;3;0;COLOR;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;114;2052.156,-2679.07;Float;False;3;0;COLOR;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;116;2033.886,-2521.292;Float;False;3;0;COLOR;0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;109;2078.083,-3076.328;Float;False;3;0;COLOR;0.0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;83;1259.834,-1302.096;Float;True;Property;_TextureSample2;Texture Sample 2;18;1;[HideInInspector];Create;4804b8ac8aa309c468f857e11c9bcb2a;4804b8ac8aa309c468f857e11c9bcb2a;True;0;False;white;Auto;False;Instance;60;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;55;-1822.371,-235.8938;Float;False;Property;_GreenChannelMultiplyBlend;Green Channel Multiply/Blend;14;0;Create;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;60;1264.895,-1906.698;Float;True;Property;_Letters_Mask;Letters_Mask;18;0;Create;4804b8ac8aa309c468f857e11c9bcb2a;4804b8ac8aa309c468f857e11c9bcb2a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;81;1274.287,-1720.739;Float;True;Property;_TextureSample1;Texture Sample 1;18;1;[HideInInspector];Create;4804b8ac8aa309c468f857e11c9bcb2a;4804b8ac8aa309c468f857e11c9bcb2a;True;0;False;white;Auto;False;Instance;60;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;82;1262.834,-1513.096;Float;True;Property;_TextureSample0;Texture Sample 0;18;1;[HideInInspector];Create;4804b8ac8aa309c468f857e11c9bcb2a;4804b8ac8aa309c468f857e11c9bcb2a;True;0;False;white;Auto;False;Instance;60;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendOpsNode;35;4.506126,-515.4468;Float;False;Overlay;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;15;-1402.828,-156.5329;Float;False;Property;_EmissionColor;Emission Color;4;0;Create;0,0.462069,1,0;0,0.4206896,1,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;96;2048.54,-1924.969;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;101;2045.776,-1685.637;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;104;2053.516,-1461.128;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;105;2063.423,-1231.276;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;5;-1537.216,71.84898;Float;True;Property;_Emission;Emission;2;0;Create;None;f66506a34764ec74da54de1ead36807e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;56;234.3597,-420.1845;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;89;2505.176,-1527.3;Float;True;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;11;514.2861,-420.8474;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;107;-802.0452,-169.5754;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-728.1695,163.643;Float;False;Property;_Emissionintensity;Emission intensity;7;0;Create;0;68;0;200;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-344.811,-157.5833;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;6;-1228.697,152.6628;Float;True;Property;_Metallic;Metallic;0;0;Create;None;c7d99f784538cfd40a0fb49d966aea4a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;40;705.4797,-640.3873;Float;False;Property;_DiffuseContrast;Diffuse Contrast;13;0;Create;0;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;29;258.3463,-742.1841;Float;False;Property;_Metallicshift;Metallic shift;11;0;Create;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;108;2163.905,-779.7381;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;46;875.6191,-818.4446;Float;False;Overlay;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;28;259.4688,-817.9962;Float;False;Property;_Smoothnesshift;Smoothnes shift;12;0;Create;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;16;-1183.142,-390.8418;Float;True;Property;_Normal;Normal;6;0;Create;None;7f842c8830e4d28458f575018c703b3f;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;79;1191.064,-3148.907;Float;True;Property;_E;E;20;0;Create;0;False;False;True;;Toggle;2;0;COLOR;0.0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;498.3059,88.57674;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;499.6075,-93.97874;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;77;2584.11,-542.9188;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;103;1205.703,-2702.6;Float;True;Property;_H;H;22;0;Create;0;False;False;True;;Toggle;2;0;COLOR;0.0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;90;1190.908,-3375.025;Float;True;Property;_D;D;19;0;Create;0;False;True;True;;Toggle;2;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;45;1144.619,-595.4446;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;102;1198.72,-2922.348;Float;True;Property;_A;A;21;0;Create;0;False;True;True;;Toggle;2;0;COLOR;0.0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2793.051,-172.7215;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;beffio/The Hunt/Bilboard_10;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;38;0;3;0
WireConnection;38;1;37;0
WireConnection;22;0;23;0
WireConnection;22;1;38;0
WireConnection;54;0;22;0
WireConnection;54;1;23;0
WireConnection;54;2;53;0
WireConnection;24;0;38;0
WireConnection;24;1;54;0
WireConnection;24;2;7;3
WireConnection;57;0;7;1
WireConnection;57;1;58;0
WireConnection;26;0;25;0
WireConnection;26;1;24;0
WireConnection;59;0;57;0
WireConnection;47;0;26;0
WireConnection;47;1;25;0
WireConnection;47;2;48;0
WireConnection;27;0;24;0
WireConnection;27;1;47;0
WireConnection;27;2;59;0
WireConnection;112;0;100;0
WireConnection;112;1;99;0
WireConnection;112;2;111;0
WireConnection;114;0;100;0
WireConnection;114;1;99;0
WireConnection;114;2;113;0
WireConnection;116;0;100;0
WireConnection;116;1;99;0
WireConnection;116;2;115;0
WireConnection;109;0;100;0
WireConnection;109;1;99;0
WireConnection;109;2;110;0
WireConnection;83;1;86;0
WireConnection;60;1;61;0
WireConnection;81;1;84;0
WireConnection;82;1;85;0
WireConnection;35;0;27;0
WireConnection;35;1;9;0
WireConnection;96;0;109;0
WireConnection;96;2;60;0
WireConnection;101;0;112;0
WireConnection;101;2;81;0
WireConnection;104;0;114;0
WireConnection;104;2;82;0
WireConnection;105;0;116;0
WireConnection;105;2;83;0
WireConnection;56;0;35;0
WireConnection;56;1;9;0
WireConnection;56;2;55;0
WireConnection;89;0;96;0
WireConnection;89;1;101;0
WireConnection;89;2;104;0
WireConnection;89;3;105;0
WireConnection;11;0;27;0
WireConnection;11;1;56;0
WireConnection;11;2;7;2
WireConnection;107;0;15;0
WireConnection;107;2;5;0
WireConnection;12;0;107;0
WireConnection;12;1;13;0
WireConnection;108;1;89;0
WireConnection;108;2;5;0
WireConnection;46;0;11;0
WireConnection;46;1;11;0
WireConnection;79;0;100;0
WireConnection;79;1;99;0
WireConnection;30;0;6;4
WireConnection;30;1;28;0
WireConnection;31;0;6;0
WireConnection;31;1;29;0
WireConnection;77;1;12;0
WireConnection;77;2;108;0
WireConnection;103;0;100;0
WireConnection;103;1;99;0
WireConnection;90;0;100;0
WireConnection;90;1;99;0
WireConnection;45;0;11;0
WireConnection;45;1;46;0
WireConnection;45;2;40;0
WireConnection;102;0;100;0
WireConnection;102;1;99;0
WireConnection;0;0;45;0
WireConnection;0;1;16;0
WireConnection;0;2;77;0
WireConnection;0;3;31;0
WireConnection;0;4;30;0
ASEEND*/
//CHKSM=BE98C4F4E92DCEB0B9D38E59DAA5AE879A221694