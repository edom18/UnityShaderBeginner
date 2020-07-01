Shader "Unlit/WaveShader"
{
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            #define PI 3.14159

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float3 normal : NORMAL;
            };

            v2f vert (appdata v)
            {
                v2f o;

                float strength = sin((v.vertex.y + _Time.x * 3.0) * PI * 6.0) * 0.05;
                v.vertex.xz += v.normal.xz * strength;

                o.vertex = UnityObjectToClipPos(v.vertex);
                o.normal = UnityObjectToWorldNormal(v.normal);

                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                // Simple lighting.
                float d = dot(_WorldSpaceLightPos0.xyz, i.normal.xyz);

                return float4(float3(d, d, d), 1);
            }
            ENDCG
        }
    }
}

