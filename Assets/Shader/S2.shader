// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "My/02 Shader"{
	Properties{

	}
	SubShader{
		Pass {

		CGPROGRAM
#pragma vertex vert
#pragma fragment frag

		struct a2v {
		    float4 vertex:POSITION;
		    float3 normal:NORMAL;
		    float4 texcoord:TEXCOORD0;
        };

	    struct v2f {
		    float4 position:SV_POSITION;
			fixed3 temp : COLOR0;
	    };
		//float4 vert(float4 v: POSITION) :SV_POSITION{
		v2f vert(a2v v) {
			v2f f;
			f.position = UnityObjectToClipPos(v.vertex);
			f.temp = v.normal;
			return f;
		}

		fixed4 frag(v2f f) : SV_Target{
			return fixed4(f.temp,1);
        }


		ENDCG
        }
	}
		FallBack"VertexLit"
}