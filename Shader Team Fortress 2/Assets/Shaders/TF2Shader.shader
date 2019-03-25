Shader "Custom/TF2Shader"
{
    //Aqui se inicia shabos
    properties
    {
        _Albedo("Albedo", Color) = (1, 1, 1, 1)
        _MainTex("Textura", 2D) = "white"{}
        _RimColor("Rim Color", Color) = (1, 1, 1, 1)
        _RimPower("Rim Power", Float) = 1.0
        _BumpMap("Normal", 2D) = "bump" {}
        _RampTex("Ramp", 2D) = "white" {}
    }
    SubShader
    {
        CGPROGRAM
            #pragma surface surf TF2
        ENDCG

    }

    
}