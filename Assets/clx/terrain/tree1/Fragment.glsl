#version 300 es
uniform highp vec4 EnvInfo;
uniform highp vec4 SunColor;
uniform highp vec4 SunDirection;
uniform highp vec4 FogColor;
uniform highp vec4 ScreenColor;
uniform highp vec4 ScreenInfoPS;
uniform highp vec4 FogColor2;
uniform highp vec4 FogColor3;
uniform highp vec4 UserData[3];
uniform highp vec3 cBaseColor;
uniform highp vec4 cLightMapScale;
uniform highp float cBaseMapBias;
uniform mediump sampler2D sBaseSampler;
uniform mediump sampler2D sLightMapSampler;
uniform highp sampler2D sSecondShadowSampler;
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
in highp vec4 xlv_COLOR;
out highp vec4 SV_Target;
void main ()
{
  mediump vec3 DiffuseColor_1;
  mediump vec2 shadow_and_ao_2;
  mediump float shadow_3;
  highp vec4 OUT_4;
  OUT_4.xyz = vec3(0.0, 0.0, 0.0);
  mediump vec3 BaseColor_5;
  mediump float Alpha_6;
  mediump float AO_7;
  mediump vec4 color_8;
  color_8 = texture (sBaseSampler, xlv_TEXCOORD0.xy, cBaseMapBias);
  BaseColor_5 = ((color_8.xyz * color_8.xyz) * (2.0 * cBaseColor));
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize(xlv_TEXCOORD2.xyz);
  Alpha_6 = color_8.w;
  AO_7 = xlv_COLOR.w;
  OUT_4.w = Alpha_6;
  highp vec2 tmpvar_10;
  tmpvar_10 = texture (sSecondShadowSampler, (gl_FragCoord.xy * ScreenInfoPS.zw)).xy;
  shadow_and_ao_2 = tmpvar_10;
  shadow_3 = (1.0 - shadow_and_ao_2.x);
  DiffuseColor_1 = (BaseColor_5 / 3.141593);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize(-(xlv_TEXCOORD3.xyz));
  mediump float color_12;
  color_12 = dot (SunDirection.xyz, tmpvar_9);
  mediump float shadow_13;
  mediump vec3 bakeLighting_14;
  mediump vec4 lightMapRaw_15;
  mediump vec4 lightMapScale_16;
  lightMapScale_16 = cLightMapScale;
  mediump vec4 tmpvar_17;
  tmpvar_17 = texture (sLightMapSampler, xlv_TEXCOORD0.zw);
  lightMapRaw_15.w = tmpvar_17.w;
  lightMapRaw_15.xyz = ((tmpvar_17.xyz * lightMapScale_16.xxx) + lightMapScale_16.yyy);
  mediump float tmpvar_18;
  tmpvar_18 = (dot (lightMapRaw_15.xyz, vec3(0.0955, 0.1878, 0.035)) + 7.5e-05);
  shadow_13 = (shadow_3 * (tmpvar_17.w * tmpvar_17.w));
  bakeLighting_14 = ((lightMapRaw_15.xyz * (
    (AO_7 * exp2(((tmpvar_18 * 50.27) - 9.237)))
   / tmpvar_18)) + (SunColor.xyz * clamp (
    (((color_12 * 0.4) + 0.1) * shadow_13)
  , 0.0, 1.0)));
  shadow_3 = shadow_13;
  OUT_4.xyz = OUT_4.xyz;
  OUT_4.xyz = (OUT_4.xyz + (bakeLighting_14 * DiffuseColor_1));
  highp float tmpvar_19;
  tmpvar_19 = clamp (dot (-(tmpvar_11), SunDirection.xyz), 0.0, 1.0);
  highp float tmpvar_20;
  tmpvar_20 = (1.0 - xlv_TEXCOORD3.w);
  OUT_4.xyz = ((OUT_4.xyz * tmpvar_20) + ((
    (OUT_4.xyz * tmpvar_20)
   + 
    (((FogColor2.xyz * clamp (
      ((tmpvar_11.y * 5.0) + 1.0)
    , 0.0, 1.0)) + FogColor.xyz) + (FogColor3.xyz * (tmpvar_19 * tmpvar_19)))
  ) * xlv_TEXCOORD3.w));
  OUT_4.xyz = (OUT_4.xyz * EnvInfo.z);
  OUT_4.xyz = clamp (OUT_4.xyz, vec3(0.0, 0.0, 0.0), vec3(4.0, 4.0, 4.0));
  OUT_4.xyz = ((OUT_4.xyz * (1.0 - ScreenColor.w)) + (ScreenColor.xyz * ScreenColor.w));
  highp vec3 tmpvar_21;
  tmpvar_21.x = FogColor.w;
  tmpvar_21.y = FogColor2.w;
  tmpvar_21.z = FogColor3.w;
  OUT_4.xyz = (OUT_4.xyz * tmpvar_21);
  OUT_4.xyz = (OUT_4.xyz / ((OUT_4.xyz * 0.9661836) + 0.180676));
  highp float tmpvar_22;
  tmpvar_22 = float((UserData[2].x >= 1.0));
  OUT_4.xyz = ((OUT_4.xyz * (1.0 - tmpvar_22)) + (tmpvar_22 * dot (OUT_4.xyz, vec3(0.3, 0.59, 0.11))));
  OUT_4.w = 1.0;
  SV_Target = OUT_4;
}

 