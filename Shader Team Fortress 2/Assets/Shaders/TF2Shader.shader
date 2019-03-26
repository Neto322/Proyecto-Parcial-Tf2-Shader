Shader "Custom/TF2Shader"
{
    //Aqui se inicia shabos
    properties
    {
        _Albedo("Albedo", Color) = (1, 1, 1, 1)
        _MainTex("Textura", 2D) = "white"{}
        
		_RimColor ("Rim Color", Color) = (1, 1, 1, 1)
		_RimPower ("Rim Power", Float) = 1.0

		_BumpMap ("Normal", 2D) = "bump" {}

		_RampTex ("Ramp", 2D) = "white" {}

    }
    SubShader
    {
        CGPROGRAM
            #pragma surface surf TF2
            

            float4 _Albedo;
            sampler2D _MainTex;
            sampler2D _RampTex;

            sampler2D _BumpMap;
            float _NormalStrenght;

            float4 _RimColor;
            float _RimPower;

            struct Input
            {
                float2 uv_MainTex;
                float2 uv_BumpMap;
                float2 uv_Specular;
                float3 viewDir;
            };

            float4 LightingTF2(SurfaceOutput s, fixed3 lightDir, fixed atten)
            {
                half diff = dot(s.Normal, lightDir);

                float uv = (diff * 0.5) + 0.5;
                
                float3 ramp = tex2D(_RampTex, uv).rgb;

                float4 c;
                c.rgb = s.Albedo * _LightColor0.rgb * ramp;
                c.a = s.Alpha;
                return c;
            }

            

            void surf(Input IN, inout SurfaceOutput o)
            {
                o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb * _Albedo.rgb;
               
                float3 normal = UnpackNormal (tex2D (_BumpMap, IN.uv_BumpMap));
                normal.z = normal.z / _NormalStrenght;
                o.Normal = normal;

                /*float3 normal = UnpackNormal (tex2D (_BumpMap, IN.uv_BumpMap));
                normal.z = normal.z / _NormalStrenght;
                o.Normal = normal;*/
                
                half rim = 1.0 - saturate(dot (normalize(IN.viewDir), o.Normal));
                o.Emission = _RimColor.rgb * pow (rim, _RimPower);

            }

        ENDCG
        

    }

    
}