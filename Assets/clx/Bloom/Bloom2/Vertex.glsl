#version 300 es
uniform highp vec4 vsOffsets[16];
in highp vec4 POSITION;
in highp vec2 TEXCOORD0;
out highp vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
void main ()
{
highp vec3 vPos_1;
highp vec4 tmpvar_2;
highp vec4 tmpvar_3;
highp vec4 tmpvar_4;
highp vec4 tmpvar_5;
highp vec4 tmpvar_6;
vPos_1.xz = POSITION.xz;
vPos_1.y = (1.0 - POSITION.y);
highp vec4 tmpvar_7;
tmpvar_7.w = 1.0;
tmpvar_7.xy = ((vPos_1.xy * 2.0) - 1.0);
tmpvar_7.z = vPos_1.z;
tmpvar_2.xy = (TEXCOORD0 + vsOffsets[0].xy);
tmpvar_2.zw = (TEXCOORD0 + vsOffsets[1].xy);
tmpvar_3.xy = (TEXCOORD0 + vsOffsets[2].xy);
tmpvar_3.zw = (TEXCOORD0 + vsOffsets[3].xy);
tmpvar_4.xy = (TEXCOORD0 + vsOffsets[4].xy);
tmpvar_4.zw = (TEXCOORD0 + vsOffsets[5].xy);
tmpvar_5.xy = (TEXCOORD0 + vsOffsets[6].xy);
tmpvar_5.zw = (TEXCOORD0 + vsOffsets[7].xy);
tmpvar_6.xy = TEXCOORD0;
tmpvar_6.zw = vec2(0.0, 0.0);
gl_Position.xyw = tmpvar_7.xyw;
xlv_TEXCOORD0 = tmpvar_2;
xlv_TEXCOORD1 = tmpvar_3;
xlv_TEXCOORD2 = tmpvar_4;
xlv_TEXCOORD3 = tmpvar_5;
xlv_TEXCOORD4 = tmpvar_6;
gl_Position.z = ((POSITION.z * 2.0) - 1.0);
}
 
 