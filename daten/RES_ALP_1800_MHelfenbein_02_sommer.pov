// PoVRay 3.7
// author: daniel_martin@gmx.at
#version 3.7; // 3.6
#declare Radiosity_ON = 0; 
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
                            location  <120 , 40 ,-90>
                            right x*image_width/image_height
							look_at <0,30,-90>
							}
//==============links============
#declare Camera_3 = camera { perspective angle 90
                            location  <-40 , 40 ,-90>
                            right x*image_width/image_height
							look_at <0,30,-90>
							}
//=========Oben=======
#declare Camera_4 = camera {perspective angle 90
                            location  <30 , 100 ,-110>
                            right     x*image_width/image_height
                            look_at   <30 , 0.0 ,-110>}
//===============Vorderseite===============
#declare Camera_5 = camera {perspective angle 90
                            location  <42 ,45 ,-160>
                            right x*image_width/image_height
							look_at <42,40,0>}
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
box{<0,0,0>,<0.5,13.5,14>}
box{<0,0,0>,<0.5,13.5,14> translate<16,0,0>}
}
object{Fenster_AS_6x6 translate <5,5,-0.6>}
}
#declare OGLRGiebelWand = difference{prism{0,0.5,4,<0,0>,<14.5,18>,<0,36>,<0,0>}object{Fenster_AS_5x6 rotate y*90 rotate z*-90 translate <4,0.6,21>}}
#declare DachSegment_1 = difference{prism{0,27,4,<0,0>,<17,21>,<0,42>,<0,0>}prism{0,28,4,<0,0>,<17,21>,<0,42>,<0,0> translate<-.2,-.5,0>}}
#declare DachSegment_2 = difference{prism{0,42,4,<0,0>,<17,21>,<0,42>,<0,0>}prism{0,43,4,<0,0>,<17,21>,<0,42>,<0,0> translate<-.2,-.5,0>}}
#declare DachSegment_3 = difference{prism{0,38,4,<0,0>,<18,0>,<9,4>,<0,0>}prism{0,39,4,<0,0>,<18,0>,<9,4>,<0,0> translate<0,-.5,-.2>}}
//=======================================================
#declare Haus = difference {
union{
object{Rohbau(110,25,36)}
//Strassenseite
object{OGVRGiebelWand  translate<22.5,24,.5>}
object{OGVRGiebelWand  translate<74.5,24,.5>}
//Hofseite
object{OGVRGiebelWand  rotate y*180 translate<39,24,35.4>}
object{OGVRGiebelWand  rotate y*180 translate<91,24,35.4>}
object{OGLRGiebelWand rotate z*90 translate<0.5,25,0>}
object{OGLRGiebelWand rotate z*90 translate<110,25,0>}
//Dach
object{DachSegment_1 rotate z*90 translate<26,22.7,-3> pigment{color MediumSeaGreen}}
object{DachSegment_1 rotate z*90 translate<113,22.7,-3> pigment{color Orange}}
object{DachSegment_2 rotate z*90 translate<78,22.7,-3> pigment{color rgb <.36,.54,.66>}}
object{DachSegment_3 rotate x*-90 translate<21.75,37.25,36> pigment{color rgb <.51,.41,.33>}}
object{DachSegment_3 rotate x*-90 translate<73.75,37.25,36> pigment{color rgb <.23,.48,.34>}}
//Kamine
object{Kamin_2 translate<24,35,17>}
object{Kamin_2 translate<34,35,17>}
object{Kamin_2 translate<50,35,17>}
object{Kamin_2 translate<60,35,17>}
object{Kamin_2 translate<76,35,17>}
object{Kamin_2 translate<86,35,17>}
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