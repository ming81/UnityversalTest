#version 300 es
uniform highp vec4 EnvInfo;
uniform highp vec4 SunColor;
uniform highp vec4 SunDirection;
uniform highp vec4 AmbientColor;
uniform highp vec4 FogColor;
uniform highp vec4 ScreenInfoPS;
uniform highp vec4 FogColor2;
uniform highp vec4 FogColor3;
uniform highp vec4 UserData[3];
uniform highp vec4 cTintColor1;
uniform highp vec4 cLightMapScale;
uniform highp vec4 cBlockScale;
uniform highp vec4 cBlockShrinkage;
uniform mediump sampler2D sIndexMapSampler;
uniform mediump sampler2D sBlendMapSampler;
uniform mediump sampler2D sBlockMapSampler;
uniform mediump sampler2D sLightMapSampler;
uniform highp sampler2D sSecondShadowSampler;
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
out highp vec4 SV_Target;
void main ()
{
  mediump vec3 DiffuseColor_1;
  mediump vec2 shadow_and_ao_2;
  mediump float shadow_3;
  highp vec4 OUT_4;
  highp vec3 N_5;
  mediump vec4 diff_6;
  mediump float depth_7;
  highp vec4 tc_8;
  highp vec2 ib_9;
  mediump float blend_10;
  N_5 = normalize(xlv_TEXCOORD2.xyz);
  mediump vec2 tmpvar_11;
  tmpvar_11 = texture (sIndexMapSampler, xlv_TEXCOORD0.xy).xw;
  ib_9 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = floor((ib_9.x * 255.5));
  blend_10 = texture (sBlendMapSampler, xlv_TEXCOORD0.xy).w;
  highp vec2 tmpvar_13;
  tmpvar_13.x = ((float(mod (tmpvar_12, 16.0))) / 4.0);
  tmpvar_13.y = (tmpvar_12 / 64.0);
  highp ivec2 tmpvar_14;
  tmpvar_14 = ivec2(floor(tmpvar_13));
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_12;
  tmpvar_15.y = floor((tmpvar_12 / 16.0));
  highp ivec2 tmpvar_16;
  tmpvar_16 = ivec2((vec2(mod (tmpvar_15, 4.0))));
  tc_8.xy = ((fract(
    (xlv_TEXCOORD1.xz * cBlockScale.x)
  ) * cBlockShrinkage.yy) + cBlockShrinkage.xx);
  tc_8.zw = tc_8.xy;
  highp float tmpvar_17;
  tmpvar_17 = (xlv_TEXCOORD1.w * 0.1);
  depth_7 = tmpvar_17;
  mediump float tmpvar_18;
  tmpvar_18 = min (depth_7, 3.0);
  highp vec4 tmpvar_19;
  tmpvar_19.x = float(tmpvar_16.x);
  tmpvar_19.y = float(tmpvar_14.x);
  tmpvar_19.z = float(tmpvar_16.y);
  tmpvar_19.w = float(tmpvar_14.y);
  highp vec4 tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * cBlockShrinkage.z) + tc_8);
  mediump vec4 color_21;
  color_21 = textureLod (sBlockMapSampler, tmpvar_20.xy, tmpvar_18);
  mediump vec4 color_22;
  color_22 = textureLod (sBlockMapSampler, tmpvar_20.zw, tmpvar_18);
  diff_6 = (((color_22 * color_22) * (1.0 - blend_10)) + ((color_21 * color_21) * blend_10));
  OUT_4.w = 1.0;
  highp vec2 tmpvar_23;
  tmpvar_23 = texture (sSecondShadowSampler, (gl_FragCoord.xy * ScreenInfoPS.zw)).xy;
  shadow_and_ao_2 = tmpvar_23;
  shadow_3 = (1.0 - shadow_and_ao_2.x);
  DiffuseColor_1 = (diff_6.xyz / 3.141593);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(-(xlv_TEXCOORD3.xyz));
  highp vec3 I_25;
  I_25 = -(tmpvar_24);
  mediump float color_26;
  color_26 = clamp (dot (N_5, tmpvar_24), 0.0, 1.0);
  mediump float color_27;
  color_27 = dot (SunDirection.xyz, N_5);
  mediump vec3 tmpvar_28;
  mediump vec4 GILighting_29;
  GILighting_29.xyz = vec3(0.0, 0.0, 0.0);
  mediump float shadow_30;
  mediump vec3 bakeLighting_31;
  mediump vec4 color_32;
  color_32 = texture (sLightMapSampler, xlv_TEXCOORD0.zw);
  highp vec3 tmpvar_33;
  tmpvar_33 = ((color_32.xyz * cLightMapScale.xyz) + cTintColor1.xyz);
  bakeLighting_31 = tmpvar_33;
  mediump float tmpvar_34;
  tmpvar_34 = (dot (bakeLighting_31, vec3(0.0955, 0.1878, 0.035)) + 7.5e-05);
  mediump float tmpvar_35;
  tmpvar_35 = exp2(((tmpvar_34 * 50.27) - 8.737));
  shadow_30 = (shadow_3 * (color_32.w * color_32.w));
  GILighting_29.w = clamp (tmpvar_35, 0.0, 1.0);
  bakeLighting_31 = (bakeLighting_31 * (tmpvar_35 / tmpvar_34));
  tmpvar_28 = ((SunColor.xyz * clamp (
    (color_27 * shadow_30)
  , 0.0, 1.0)) + bakeLighting_31);
  shadow_3 = shadow_30;
  mediump vec3 tmpvar_36;
  highp vec4 GILighting_37;
  GILighting_37 = GILighting_29;
  highp float shadow_38;
  shadow_38 = shadow_30;
  mediump vec3 spec_39;
  highp float a2_40;
  mediump float tmpvar_41;
  tmpvar_41 = (1.0 - (1.0 - diff_6.w));
  a2_40 = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = (AmbientColor * ((
    ((a2_40 * 5.0) * GILighting_37.w)
   * 
    (1.0 - color_26)
  ) * (1.0 - color_26))).xyz;
  spec_39 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = clamp (exp2((
    (11.9383 * vec3(clamp (dot ((I_25 - 
      (2.0 * (dot (N_5, I_25) * N_5))
    ), SunDirection.xyz), 0.0, 1.0)))
   - 11.9383)), 0.0, 1.0);
  tmpvar_36 = (spec_39 + ((SunColor.xyz * 5.093) * (
    (tmpvar_43 * a2_40)
   * shadow_38)));
  OUT_4.xyz = tmpvar_36;
  OUT_4.xyz = OUT_4.xyz;
  OUT_4.xyz = (OUT_4.xyz + (tmpvar_28 * DiffuseColor_1));
  mediump float tmpvar_44;
  tmpvar_44 = clamp ((shadow_and_ao_2.y + (shadow_30 * 0.5)), 0.0, 1.0);
  OUT_4.xyz = (OUT_4.xyz * tmpvar_44);
  highp float tmpvar_45;
  tmpvar_45 = clamp (dot (-(tmpvar_24), SunDirection.xyz), 0.0, 1.0);
  highp float tmpvar_46;
  tmpvar_46 = (1.0 - xlv_TEXCOORD3.w);
  OUT_4.xyz = ((OUT_4.xyz * tmpvar_46) + ((
    (OUT_4.xyz * tmpvar_46)
   + 
    (((FogColor2.xyz * clamp (
      ((tmpvar_24.y * 5.0) + 1.0)
    , 0.0, 1.0)) + FogColor.xyz) + (FogColor3.xyz * (tmpvar_45 * tmpvar_45)))
  ) * xlv_TEXCOORD3.w));
  OUT_4.xyz = (OUT_4.xyz * EnvInfo.z);
  OUT_4.xyz = clamp (OUT_4.xyz, vec3(0.0, 0.0, 0.0), vec3(4.0, 4.0, 4.0));
  highp vec3 tmpvar_47;
  tmpvar_47.x = FogColor.w;
  tmpvar_47.y = FogColor2.w;
  tmpvar_47.z = FogColor3.w;
  OUT_4.xyz = (OUT_4.xyz * tmpvar_47);
  OUT_4.xyz = (OUT_4.xyz / ((OUT_4.xyz * 0.9661836) + 0.180676));
  highp float tmpvar_48;
  tmpvar_48 = float((UserData[2].x >= 1.0));
  OUT_4.xyz = ((OUT_4.xyz * (1.0 - tmpvar_48)) + (tmpvar_48 * dot (OUT_4.xyz, vec3(0.3, 0.59, 0.11))));
  OUT_4.w = 1.0;
  SV_Target = OUT_4;
}

 