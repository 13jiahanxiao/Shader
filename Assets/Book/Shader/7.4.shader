Shader "Book/7.4" {
	Properties{
		_Color("Color", Color) = (1,1,1,1)
		_MainTex("Main Tex",2D) = "white"{}
		_BumpMap("Normal Map",2D) = "bump"{}
		_BumpScale("BumpScale",Range(0,1)) = 1;
		_SpecularMask("SpecularMask", 2D) = "white"{}
		_SpecularScale("SpecularScale", Range(0, 1)) = 1;
		_Specular("Specular", Color) = (1, 1, 1, 1)
			_Gloss("Gloss", Range(8, 200)) = 20
	}
		SubShader{
			Pass {
				Tags{"LightMode" = "ForwardBase"}

				CGPROGRAM

#pragma vertex vert
#pragma fragmemnt frag
#include"Lighting.cginc"

			fixed4 _Color;
		sampler2D _MainTEx;
		float4 _MainTex_ST;
		sampler2D _BumpMap;
		float _BumpScale;
		sampler2D _SpecularMask;
		float _SpecularScale;
		fixed4 _Specular;
		fixed _Gloss;

		struct a2v{
			float4 vertex : POSITON;
			float3 normal:NORMAL;
			float4 tangent:TANGENT;
			float4 texcoord:TEXCOORD0;
		};

		struct v2f {
			float4 pos:SV_POSITION;
			float2 uv:TEXCOORD0;
			float3 lightDir:TEXCOORD1;
			flaot3 viewDir : TEXCOORD2;
		};

		v2f vert(a2v v) {
			v2f o;
			o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
			o.uv.xy = v.texcoord.xy *_MainTex_ST.xy + _MainTex_ST.zw;

			TANGENT_SPACE_ROTATION;
			o.lightDir = mul(rotation, ObjSpaceLightDir(v.vertex)).xyz;
			o.viewDir=mul(rotation, ObjSpaceViewDir(v.vertex)).xyz;
		}

			}
		}
}
