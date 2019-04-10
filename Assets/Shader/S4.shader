// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "My/lambert fragment" {
	Properties{
		_Diffuse("Diffuse Color",Color) = (1,1,1,1)
	}
		SubShader{
			Pass {
			Tags{"LightMode" = "ForwardBase"}

			CGPROGRAM
	#include"Lighting.cginc"
	#pragma vertex vert
	#pragma fragment frag
			fixed4 _Diffuse;

		struct a2v {
			float4 vertex:POSITION;
			float3 normal:NORMAL;
			float4 texcoord:TEXCOORD0;			
		};

		struct v2f {
			float4 position:SV_POSITION;
			float3 worldNormalDir:COLOR0;
		};
		v2f vert(a2v v) {
			v2f f;
			f.position = UnityObjectToClipPos(v.vertex);
			f.worldNormalDir=mul(v.normal, (float3x3)unity_WorldToObject);
			return f;
		}

		fixed4 frag(v2f f) : SV_Target{
			fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.rgb;
		    fixed3 normalDir = normalize(f.worldNormalDir);
		    fixed lightDir = normalize(_WorldSpaceLightPos0.xyz);
			fixed3 diffuse = _LightColor0.rgb * max(dot(normalDir, lightDir), 0) * _Diffuse.rgb;
			fixed3 tempColor = diffuse + ambient;
			return fixed4(tempColor,1);
		}


		ENDCG
		}
	}
		FallBack"VertexLit"
}
