#version 300 es
uniform highp mat4 ViewProjVS;
uniform highp vec4 CameraPosVS;
uniform highp vec4 FogInfo;
uniform highp vec4 EnvInfoVS;
uniform highp mat4 World;
uniform highp vec4 cLightMapUVTransform;
uniform highp float cWindDirectionX;
uniform highp float cWindDirectionZ;
uniform highp float cGlobalMoveFrequency;
uniform highp float cGlobalMoveFactor;
in highp vec4 POSITION;
in highp vec4 COLOR;
in highp vec4 NORMAL;
in highp vec2 TEXCOORD0;
in highp vec2 TEXCOORD1;
in highp vec4 TANGENT;
in highp vec4 BINORMAL;
out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
out highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = POSITION.xyz;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (tmpvar_6 * World).xyz;
  tmpvar_3.w = tmpvar_7.w;
  tmpvar_2.xy = TEXCOORD0;
  tmpvar_2.zw = ((TEXCOORD1 * cLightMapUVTransform.xy) + cLightMapUVTransform.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[uint(0)] = World[uint(0)].xyz;
  tmpvar_8[1u] = World[1u].xyz;
  tmpvar_8[2u] = World[2u].xyz;
  tmpvar_4.xyz = normalize(((
    (NORMAL.xyz * 2.0)
   - 1.0) * tmpvar_8));
  highp vec3 modelPos_9;
  modelPos_9 = (vec4(0.0, 0.0, 0.0, 1.0) * World).xyz;
  highp vec3 worldPos_10;
  highp float treeWoldPosWave_11;
  worldPos_10 = (abs(modelPos_9) * sign(modelPos_9));
  highp float tmpvar_12;
  tmpvar_12 = (EnvInfoVS.y * 2.0);
  highp vec3 tmpvar_13;
  tmpvar_13.y = 0.0;
  tmpvar_13.x = cWindDirectionX;
  tmpvar_13.z = cWindDirectionZ;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(tmpvar_13);
  highp float tmpvar_15;
  tmpvar_15 = ((0.01 * cGlobalMoveFactor) * tmpvar_12);
  highp vec3 tmpvar_16;
  tmpvar_16 = (worldPos_10 * 0.25);
  highp float tmpvar_17;
  tmpvar_17 = ((tmpvar_16.x + (tmpvar_16.z * 0.5)) + ((CameraPosVS.w * cGlobalMoveFrequency) * 6.5));
  treeWoldPosWave_11 = ((pow (
    (sin(tmpvar_17) + 1.0)
  , 1.5) + 2.0) + tmpvar_12);
  tmpvar_3.xyz = (tmpvar_7.xyz + ((
    ((tmpvar_14 * tmpvar_15) * (treeWoldPosWave_11 * COLOR.z))
   + 
    ((vec3(0.0, -0.1, 0.0) * tmpvar_15) * (treeWoldPosWave_11 * COLOR.z))
  ) + (
    ((vec3(0.0, -0.1, 0.0) * tmpvar_15) * sin(((
      (tmpvar_17 + (1.0 - dot (tmpvar_14, normalize(
        (tmpvar_7.xyz - worldPos_10)
      ))))
     * 5.0) + COLOR.y)))
   * COLOR.x)));
  tmpvar_5.xyz = (tmpvar_3.xyz - CameraPosVS.xyz);
  highp float fHeightCoef_18;
  highp float tmpvar_19;
  tmpvar_19 = clamp (((tmpvar_3.y * FogInfo.z) + FogInfo.w), 0.0, 1.0);
  fHeightCoef_18 = (tmpvar_19 * tmpvar_19);
  fHeightCoef_18 = (fHeightCoef_18 * fHeightCoef_18);
  highp float tmpvar_20;
  tmpvar_20 = (1.0 - exp((
    -(max (0.0, (sqrt(
      dot (tmpvar_5.xyz, tmpvar_5.xyz)
    ) - FogInfo.x)))
   * 
    max ((FogInfo.y * fHeightCoef_18), (0.1 * FogInfo.y))
  )));
  tmpvar_5.w = (tmpvar_20 * tmpvar_20);
  highp vec4 tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = tmpvar_3.xyz;
  tmpvar_21 = (tmpvar_22 * ViewProjVS);
  gl_Position.xyw = tmpvar_21.xyw;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_5;
  xlv_COLOR = COLOR.zyxw;
  gl_Position.z = ((tmpvar_21.z * 2.0) - tmpvar_21.w);
}

 