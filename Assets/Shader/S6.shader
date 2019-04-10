Shader "My/Specular vertex" {
	Properties{
		_Diffuse("Diffuse Color",Color) = (1,1,1,1)
		_Gloss("Gloss",Range(8,200)) = 10
		_Specular("Specular",Color) = (1,1,1,1)
	}
		SubShader{
			Pass {
			Tags{"LightMode" = "ForwardBase"}

			CGPROGRAM
	#include"Lighting.cginc"
	#pragma vertex vert
	#pragma fragment frag
			fixed4 _Diffuse;
	        half _Gloss;
			half4 _Specular;

		struct a2v {
			float4 vertex:POSITION;
			float3 normal:NORMAL;
			float4 texcoord:TEXCOORD0;
		};

		struct v2f {
			float4 position:SV_POSITION;
			float3 color:COLOR;
		};
		v2f vert(a2v v) {
			v2f f;
			fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.rgb;
			f.position = UnityObjectToClipPos(v.vertex);
			fixed3 normalDir = normalize(mul(v.normal, (float3x3)unity_WorldToObject));
			fixed3 lightDir = normalize(_WorldSpaceLightPos0.xyz);		
			float halfLambert = dot(normalDir, lightDir)*0.5 + 0.5;
			fixed3 diffuse = _LightColor0.rgb * halfLambert *_Diffuse.rgb;
			
			fixed3 reflectDir=normalize( reflect(-lightDir,normalDir));
			fixed3 viewDir= normalize(_WorldSpaceCameraPos.xyz - mul(v.vertex, (float3x3)unity_WorldToObject).xyz);
			
			fixed3 specular = _LightColor0.rgb* _Specular.rgb*pow(max(dot(reflectDir, viewDir), 0), _Gloss);
			
			f.color = diffuse + ambient + specular;
			return f;
		}

		fixed4 frag(v2f f) : SV_Target{
			return fixed4(f.color,1);
		}


		ENDCG
		}
	}
		FallBack"VertexLit"
}
