Shader "Effect/Edge"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
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

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            fixed _Size;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float dx = 1.0 / _ScreenParams.x;
                float dy = 1.0 / _ScreenParams.y;

                fixed4 col2 = tex2D(_MainTex, i.uv + float2(-dx,  dy));
                fixed4 col3 = tex2D(_MainTex, i.uv + float2(  0,  dy));
                fixed4 col4 = tex2D(_MainTex, i.uv + float2( dx,  dy));
                fixed4 col5 = tex2D(_MainTex, i.uv + float2(-dx,   0));
                fixed4 col1 = tex2D(_MainTex, i.uv + float2(  0,   0)) * -8.0;
                fixed4 col6 = tex2D(_MainTex, i.uv + float2( dx,   0));
                fixed4 col7 = tex2D(_MainTex, i.uv + float2(-dx, -dy));
                fixed4 col8 = tex2D(_MainTex, i.uv + float2(  0, -dy));
                fixed4 col9 = tex2D(_MainTex, i.uv + float2( dx, -dy));

                float4 col = (col1 + col2 + col3 + col4 + col5 + col6 + col7 + col8 + col9);

                return col;
            }
            ENDCG
        }
    }
}
