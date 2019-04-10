// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "Book/7.1" {
	Properties{
		_Color("Color",Color)=(1,1,1,1)
		_MainTex("MainTex",2D) = "white"{}
		_BumpMap("BumpMap",2D) = "bump"{}
		_BumpScale("BumpScale",Range(0,1)) = 1.0
		_Specular("Specular",Color) = (1,1,1,1)
		_Diffuse("Diffuse",Color) = (1,1,1,1)
		_Gloss("Gloss",Range(8,200)) = 10
	}
	SubShader{
			Tags{"Queue"="Transparent" "IngnoreProjector"="True" "RenderType"="Transparents"}
		Pass {
		Tags{"LightMode" = "ForwardBase"}
		ZWrite Off
			Blend SrcAlpha OneMinusSrcAlpha

		CGPROGRAM
#include"Lighting.cginc"
#pragma vertex vert
#pragma fragment frag
		half4 _Color;
		sampler2D _MainTex;
		float4 _MainTex_ST;
		sampler2D _BumpMap;
		float4 _BumpMap_ST;
		float _BumpScale;
		half4 _Diffuse;
	    half4 _Specular;
		half _Gloss;

		struct a2v {
			float4 vertex:POSITION;
			float3 normal:NORMAL;
			float4 tangent:TANGENT;
			float4 texcoord:TEXCOORD0;
		};

		struct v2f {
			float4 uv:TEXCOORD0;
			float3 lightDir:TEXCOORD1;
			float3 worldVertex:TEXCOORD2;
			float4 position:SV_POSITION;
		};
		v2f vert(a2v v) {
			v2f o;
			o.position = UnityObjectToClipPos(v.vertex);
			o.worldVertex = mul(v.vertex, unity_WorldToObject);
			o.uv.xy = v.texcoord.xy*_MainTex_ST.xy + _MainTex_ST.zw;
			o.uv.zw = v.texcoord.xy*_BumpMap_ST.xy + _MainTex_ST.zw;

			TANGENT_SPACE_ROTATION;
			
			o.lightDir = mul(rotation,ObjSpaceLightDir(v.vertex));


			return o;
		}

		fixed4 frag(v2f o) : SV_Target{
			fixed4 texColor = tex2D(_MainTex, o.uv.xy)*_Color;
			fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.rgb*texColor;

		    fixed4 normalColor = tex2D(_BumpMap, o.uv.zw) ;
			fixed3 tangentNormal = UnpackNormal(normalColor);
			tangentNormal.xy = tangentNormal.xy* -_BumpScale;
			tangentNormal = normalize(tangentNormal);
		    fixed3 lightDir = normalize(o.lightDir);
			
			
			float halfLambert = dot(tangentNormal, lightDir)*0.5 + 0.5;
			fixed3 diffuse = _LightColor0.rgb * halfLambert *texColor.rgb;

			fixed3 tempColor = diffuse + ambient ;
			return fixed4(tempColor,texColor.a);
		}


		ENDCG
		}
	}
		FallBack"Specular"
}
