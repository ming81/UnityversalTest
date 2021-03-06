#version 300 es
uniform highp mat4 ViewProjVS;
uniform highp vec4 CameraPosVS;
uniform highp vec4 FogInfo;
uniform highp mat4 World;
in highp vec4 POSITION;
in highp vec4 NORMAL;
in highp vec2 TEXCOORD0;
out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = POSITION.xyz;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = (tmpvar_4 * World).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[uint(0)] = World[uint(0)].xyz;
  tmpvar_6[1u] = World[1u].xyz;
  tmpvar_6[2u] = World[2u].xyz;
  tmpvar_2.xyz = normalize(((
    (NORMAL.xyz * 2.0)
   - 1.0) * tmpvar_6));
  tmpvar_3.xyz = (tmpvar_5.xyz - CameraPosVS.xyz);
  highp float fHeightCoef_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp (((tmpvar_5.y * FogInfo.z) + FogInfo.w), 0.0, 1.0);
  fHeightCoef_7 = (tmpvar_8 * tmpvar_8);
  fHeightCoef_7 = (fHeightCoef_7 * fHeightCoef_7);
  highp float tmpvar_9;
  tmpvar_9 = (1.0 - exp((
    -(max (0.0, (sqrt(
      dot (tmpvar_3.xyz, tmpvar_3.xyz)
    ) - FogInfo.x)))
   * 
    max ((FogInfo.y * fHeightCoef_7), (0.1 * FogInfo.y))
  )));
  tmpvar_3.w = (tmpvar_9 * tmpvar_9);
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_11.xyz = tmpvar_5.xyz;
  tmpvar_12.xyz = tmpvar_2.xyz;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_5.xyz;
  tmpvar_10 = (tmpvar_13 * ViewProjVS);
  tmpvar_11.w = tmpvar_10.z;
  tmpvar_12.w = tmpvar_10.w;
  tmpvar_2 = tmpvar_12;
  gl_Position.xyw = tmpvar_10.xyw;
  xlv_TEXCOORD0 = TEXCOORD0.xyxy;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_12;
  xlv_TEXCOORD3 = tmpvar_3;
  gl_Position.z = ((tmpvar_10.z * 2.0) - tmpvar_10.w);
}

 