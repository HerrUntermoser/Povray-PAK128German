// PoVRay 3.7
// author: daniel_martin@gmx.at
#version 3.7; // 3.6
#declare Radiosity_ON = 1; 
#if (Radiosity_ON = 1 )
global_settings{
  ambient_light 1
  assumed_gamma 1.0
  radiosity {
         // pretrace_start 1
         // pretrace_end 1
          adc_bailout 2
          error_bound 0.6
          count 30
          brightness 0.55
          gray_threshold 0.25
         media on
         normal on
          recursion_limit 2
       } // --------------
 }// end global_settings
#else
global_settings{ assumed_gamma 1.1 }
#default{ finish{ ambient 0.2 diffuse 0.9 }}
#end
#include "colors.inc"
#include "textures.inc"
#include "glass.inc"
#include "metals.inc"
#include "stones.inc"
#include "woods.inc"
#include "basis.inc"
#include "kleinkram.inc"
#include "Lampe02_geom.inc"
//=============Render Kamera=========
  #declare Camera_0 = camera{
  orthographic
  location<100, 81.4, -100>  
look_at<0, 0, 0>
}
//=========Rückseite============
#declare Camera_1 = camera {perspective angle 90
                            location  <40 ,30 ,40.0>
                            look_at   <40 ,30,0>}
//=============rechts==============
#declare Camera_2 = camera {perspective angle 90
                            location  <120 , 40 ,-60>
                            right x*image_width/image_height
							look_at <0,30,-60>
							}
//==============links============
#declare Camera_3 = camera { perspective angle 90
                            location  <-40 , 40 ,-80>
                            right x*image_width/image_height
							look_at <0,30,-80>
							}
//=========Oben=======
#declare Camera_4 = camera {perspective angle 90
                            location  <50 , 100 ,-70>
                            right     x*image_width/image_height
                            look_at   <50 , 0.0 ,-71>}
//===============Vorderseite===============
#declare Camera_5 = camera {perspective angle 90
                            location  <40 ,40 ,-160>
                            right x*image_width/image_height
							look_at <40,30,0>}
camera {Camera_0}

//===========Sonne=========================
light_source{<0,2500,-2500> color rgb < 0.9921569,  0.9137255,  0.827451 >}  // sunlight
#if (Radiosity_ON = 1)
background {color rgbt 1}
#else
light_source{<0 , 20.0 ,400.0>color White*0.2 shadowless} // flash
light_source{ <25, 35 ,15>color White*0.9 shadowless} // flash 2
sky_sphere{
 pigment{ gradient <0,1,0>
          color_map{
          [0.0 color rgb<1,1,1>        ]
          [0.8 color rgb<0.1,0.25,0.75>]
          [1.0 color rgb<0.1,0.25,0.75>]}
        } 
 }
//============Standardebene=======================
plane { <0,1,0>, 0  pigment{ color DarkSlateGrey } translate<0,-50,0> }
#end
//============OBJEKTE===============================
#declare OGVRGiebelWand = difference{union{prism{0,0.5,6,<0,0>,<16.5,0>,<16.5,13.5>,<8.25,17>,<0,13.5>,<0,0> rotate x*-90}
box{<0,0,0>,<0.5,13.5,12>}
box{<0,0,0>,<0.5,13.5,12> translate<16,0,0>}
}
object{Fenster_AS_6x6 translate <5,5,-0.6>}
}
#declare OGLRGiebelWand = prism{0,0.5,5,<0,0>,<14.5,15>,<14.5,21.5>,<0,36.5>,<0,0>}
//=======================================================
#declare Haus = difference {
union{
object{Rohbau(110,25,36)}
//Strassenseite
object{OGVRGiebelWand  translate<22.5,25,.5>}
object{OGVRGiebelWand  translate<74.5,25,.5>}
//Hofseite
object{OGVRGiebelWand  rotate y*180 translate<38.5,25,35.4>}
object{OGVRGiebelWand  rotate y*180 translate<90.5,25,35.4>}
object{OGLRGiebelWand rotate z*90 translate<0.5,25,0>}
object{OGLRGiebelWand rotate z*90 translate<110,25,0>}
}
//Fensterloch Vorderseite
object{Fenster_AS_6x6 translate <5,9,-0.1>}
object{Fenster_AS_6x6 translate <15,9,-0.1>}
object{Fenster_AS_6x6 translate <35,9,-0.1>}
object{Fenster_AS_6x6 translate <45,9,-0.1>}
object{Fenster_AS_6x6 translate <99,9,-0.1>}
object{Fenster_AS_6x6 translate <88,9,-0.1>}
object{Fenster_AS_6x6 translate <67,9,-0.1>}
object{Fenster_AS_6x6 translate <56,9,-0.1>}
//Fensterloch und Haustüren Rückseite
object{Fenster_AS_6x6 translate <5,9,35.4>}
object{Fenster_AS_6x6 translate <15,9,35.4>}
object{Fenster_AS_6x6 translate <35,9,35.4>}
object{Fenster_AS_6x6 translate <45,9,35.4>}
object{Fenster_AS_6x6 translate <99,9,35.4>}
object{Fenster_AS_6x6 translate <88,9,35.4>}
object{Fenster_AS_6x6 translate <67,9,35.4>}
object{Fenster_AS_6x6 translate <56,9,35.4>}
object{Haust_AS_7k5_11 translate<24,1,35.4>}
object{Haust_AS_7k5_11 translate<77,1,35.4>}
//Fenster links aussen
object{Fenster_AS_5x6 rotate y*90 translate <-.4,9,16>}
object{Fenster_AS_5x6 rotate y*90 translate <-.4,9,26>}
//Fenster rechts aussen
object{Fenster_AS_5x6 rotate y*90 translate <109.4,9,16>}
object{Fenster_AS_5x6 rotate y*90 translate <109.4,9,26>}
}
//Szene=============================================================================================================

union{
object {Haus translate<-15,0,-130> pigment{color rgb <1,0,0>}}
object {Haus rotate y*180 translate<95,0,-16> pigment{color rgb <0,1,0>}}

//Bodenplatte

object {bodenplatte texture { pigment{ image_map { png "grass.png" map_type 0 interpolate 2} rotate <90,0,0> scale 30} finish {ambient 0}}}
//Ende Bodenplatte

#declare Richtung = 0;
#switch ( Richtung )
#case (0)
//sued
#break
#case (3)//west
rotate <0,90,0>
translate <112,0,-28>
#break
#case (2)//nord
rotate <0,180,0>
translate <80,0,-145>
#break
#case (1)//ost
rotate <0,270,0>
translate <-35,0,-115>
#break
#end
//Ende der Szene
}