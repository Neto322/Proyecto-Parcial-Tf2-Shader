Shader "Custom/TF2Shader"
{
    //Aqui se inicia shabos
    properties
    {
        _Albedo("Albedo", Color) = (1, 1, 1, 1)
        _MainTex("Textura", 2D) = "white"{}
        
		_RimColor ("Rim Color", Color) = (1, 1, 1, 1)
		_RimPower ("Rim Power", Range(-10, 10 )) = 6.5

		_BumpMap ("Normal", 2D) = "bump" {}
        _NormalStrenght("Normal Strenght", Range(-3, 3)) = 1

		_RampTex ("Ramp", 2D) = "white" {}

    }
    SubShader
    {
        CGPROGRAM
            #pragma surface surf TF2
            

            float4 _Albedo;
            sampler2D _MainTex;
             float4 _RimColor;
            float _RimPower;
            sampler2D _BumpMap;
            float _NormalStrenght;
            sampler2D _RampTex;
           

            

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

            struct Input
            {
                float2 uv_MainTex;
                float2 uv_BumpMap;
                float3 viewDir;
            };

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