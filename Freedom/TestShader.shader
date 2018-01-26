// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/FreedomShader" {
	Properties {
		_FirstColor ("First Color", Color) = (1,1,1,1)
		_SecondColor ("SecondColor", Color) = (1, 1, 1, 1)
		_MainTex ("Main Tex", 2D) = "white" {}
		_NormalMap ("Normal map", 2D) = "white" {}
	}
	SubShader {
		pass{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			fixed4 _FirstColor;
			fixed4 _SecondColor;
			sampler2D _MainTex;
			sampler2D _NormalMap;

			struct a2v{
				float4 vertex : POSITION;
				float4 normal : NORMAL;
				float2 texcoord: TEXCOORD0; 
			};


			struct v2f{
				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD1;
			};

			v2f vert (a2v v){
				v2f o;
				o.pos = v.vertex;
				o.uv = v.texcoord.xy;
				return o;
			}
			fixed4 frag(v2f i):SV_Target
			{
				fixed4 packedNormal = tex2D(_NormalMap, i.uv);
				fixed4 tangentNormal;
				tangentNormal.xy = packedNormal.xy * 2 - 1;
				tangentNormal.z = sqrt(1.0 - saturate(dot(tangentNormal.xy, tangentNormal.xy)));
				fixed4 color = fixed4(packedNormal.rgb, packedNormal.a);
				return color;
			}

			ENDCG
		}
	} 
}

