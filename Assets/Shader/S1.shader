/*Shader "Custom/S1" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;

		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_BUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_BUFFER_END(Props)

		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}*/

Shader "My/01 Shader"{
	Properties{
		_Color("Color",Color)=(1,1,1,1)
		_Vector("Vector",Vector)=(1,2,3,4)
		_Int("Int",Int)=123
		_Float("Float",Float)=3.5
		_Range("Range",Range(1,10))=7
		_Texture("Texture",2D)="white"{}
		_Cube("Cube",Cube) = "white"{}
		_3D("3D",3D) = "white"{}
	}

		SubShader{
			Pass{
				CGPROGRAM
				fixed4 _Color;
	            fixed4 _Vector;
	            float _Int;
	            float _Float;
	            float _Range;
	            sampler2D _Texture;
	            samplerCube _Cube;
	            sampler3D _3D;

			ENDCG
            }
	    }
	FallBack"Diffuse"
}
