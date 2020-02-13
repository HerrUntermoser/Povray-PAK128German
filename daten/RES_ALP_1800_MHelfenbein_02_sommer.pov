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
                            location  <120 , 40 ,-30>
                            right x*image_width/image_height
							look_at <0,30,-30>
							}
//==============links============
#declare Camera_3 = camera { perspective angle 90
                            location  <-40 , 40 ,-30>
                            right x*image_width/image_height
							look_at <0,30,-30>
							}
//=========Oben=======
#declare Camera_4 = camera {perspective angle 90
                            location  <30 , 70 ,-90>
                            right     x*image_width/image_height
                            look_at   <20 , 0.0 ,-70>}
//===============Vorderseite===============
#declare Camera_5 = camera {perspective angle 90
                            location  <30 ,45 ,-90>
                            right x*image_width/image_height
							look_at <30,40,0>}
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
#declare Holzpanel = texture{DMFWood3 scale <2,1,2> finish{ambient .1 diffuse .9}}
#declare WandPutz = texture{pigment{bozo color_map {[0 color rgb <1,.74,.38>*1.1][.5  color rgb <1,.74,.38>*.8][1  color rgb <1,.74,.38>]}} normal { agate .2 agate_turb 2 scale .4 } finish{ambient .1 diffuse .9}}
#declare Holzlatten = texture {gradient y texture_map{[0 Holzpanel][.5 Holzpanel][.5 pigment {color rgb 0}][.6 pigment{color rgb 0}][.6 Holzpanel][1 Holzpanel]}}
#declare OGVRGiebelWand = difference{union{prism{0,0.5,6,<0,0>,<16.5,0>,<16.5,13.5>,<8.25,17>,<0,13.5>,<0,0> rotate x*-90}
box{<0,0,0>,<0.5,13.5,14>}
box{<0,0,0>,<0.5,13.5,14> translate<16,0,0>}
}
object{Fenster_AS_6x6 translate <5,5,-0.6>}
}
#declare OGLRGiebelWand = difference{prism{0,0.5,4,<0,0>,<14.5,18>,<0,36>,<0,0>}object{Fenster_AS_5x6 rotate y*90 rotate z*-90 translate <4,0.6,21>}}
#declare DachSegment_1 = difference{prism{0,27,4,<0,0>,<17,21>,<0,42>,<0,0>}prism{0,28,4,<0,0>,<17,21>,<0,42>,<0,0> translate<-.2,-.5,0>} pigment{image_map{jpeg "dachziegel-textur-011.jpg" interpolate 2}scale 8}}
#declare DachSegment_2 = difference{prism{0,42,4,<0,0>,<17,21>,<0,42>,<0,0>}prism{0,43,4,<0,0>,<17,21>,<0,42>,<0,0> translate<-.2,-.5,0>} pigment{image_map{jpeg "dachziegel-textur-011.jpg" interpolate 2}scale 8}}
#declare DachSegment_3 = difference{prism{0,38,4,<0,0>,<18,0>,<9,4>,<0,0>}prism{0,39,4,<0,0>,<18,0>,<9,4>,<0,0> translate<0,-.5,-.2>} pigment{image_map{jpeg "dachziegel-textur-011.jpg" interpolate 2}scale 5}}
//=======================================================
#declare Haus_Roh = difference {
object{Rohbau(110,25,36)}
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
object{Haust_AS_6_10 translate<25,1,35.4>}
object{Haust_AS_6_10 translate<78,1,35.4>}
//Fenster links aussen
object{Fenster_AS_5x6 rotate y*90 translate <-.4,9,16>}
object{Fenster_AS_5x6 rotate y*90 translate <-.4,9,26>}
//Fenster rechts aussen
object{Fenster_AS_5x6 rotate y*90 translate <109.4,9,16>}
object{Fenster_AS_5x6 rotate y*90 translate <109.4,9,26>}
}
//=================================================
#declare Haus = union{
object{Haus_Roh}
//Strassenseite
object{OGVRGiebelWand  translate<22.5,24,.5> texture{Holzlatten scale 1.5}}
object{OGVRGiebelWand  translate<74.5,24,.5> texture{Holzlatten scale 1.5}}
//Hofseite
object{OGVRGiebelWand  rotate y*180 translate<39,24,35.4> texture{Holzlatten scale 1.5}}
object{OGVRGiebelWand  rotate y*180 translate<91,24,35.4> texture{Holzlatten scale 1.5}}
object{OGLRGiebelWand rotate z*90 translate<0.5,25,0> texture{Holzlatten scale 2}}
object{OGLRGiebelWand rotate z*90 translate<110,25,0> texture{Holzlatten scale 2}}
//Dach
object{DachSegment_1 rotate z*90 translate<26,22.7,-3>}
object{DachSegment_1 rotate z*90 translate<113,22.7,-3>}
object{DachSegment_2 rotate z*90 translate<78,22.7,-3>}
object{DachSegment_3 rotate x*-90 translate<21.75,37.25,36>}
object{DachSegment_3 rotate x*-90 translate<73.75,37.25,36>}
//Kamine
object{Kamin_2 translate<24,35,17>}
object{Kamin_2 translate<34,35,17>}
object{Kamin_2 translate<50,35,17>}
object{Kamin_2 translate<60,35,17>}
object{Kamin_2 translate<76,35,17>}
object{Kamin_2 translate<86,35,17>}
//Haustüren
object{Haustuer_6_10_rund rotate y*180 translate<31,1,36.1>}
object{Haustuer_6_10_rund rotate y*180 translate<84,1,36.1>}
//Fenster EG Strassenseite
object{Fenster6x6_Rnavajo translate <5,9,0>}
object{Fenster6x6_Rnavajo translate <15,9,0>}
object{Fenster6x6_Rnavajo translate <35,9,0>}
object{Fenster6x6_Rnavajo translate <45,9,0>}
object{Fenster6x6_Rnavajo translate <99,9,0>}
object{Fenster6x6_Rnavajo translate <88,9,0>}
object{Fenster6x6_Rnavajo translate <67,9,0>}
object{Fenster6x6_Rnavajo translate <56,9,0>}
//Fenster OG Strassenseite
object{Fenster6x6_Rnavajo translate <27.5,29,0>}
object{Fenster6x6_Rnavajo translate <79.5,29,0>}
//Fenster OG Hofseite
object{Fenster6x6_Rnavajo rotate y*180 translate <34,29,36>}
object{Fenster6x6_Rnavajo rotate y*180 translate <86,29,36>}
//Fenster EG Hofseiteseite
object{Fenster6x6_Rnavajo rotate y*180 translate <11,9,36>}
object{Fenster6x6_Rnavajo rotate y*180 translate <21,9,36>}
object{Fenster6x6_Rnavajo rotate y*180 translate <41,9,36>}
object{Fenster6x6_Rnavajo rotate y*180 translate <51,9,36>}
object{Fenster6x6_Rnavajo rotate y*180 translate <105,9,36>}
object{Fenster6x6_Rnavajo rotate y*180 translate <94,9,36>}
object{Fenster6x6_Rnavajo rotate y*180 translate <73,9,36>}
object{Fenster6x6_Rnavajo rotate y*180 translate <62,9,36>}
//Fenster links aussen
object{Fenster5x6_Rnavajo rotate y*90 translate <-.1,9,16>}
object{Fenster5x6_Rnavajo rotate y*90 translate <-.1,9,26>}
//Fenster links aussen OG
object{Fenster5x6_Rnavajo rotate y*90 translate <-.1,29,21>}
//Fenster rechts aussen
object{Fenster5x6_Rnavajo rotate y*-90 translate <110,9,11>}
object{Fenster5x6_Rnavajo rotate y*-90 translate <110,9,21>}
//Fenster rechts aussen OG
object{Fenster5x6_Rnavajo rotate y*-90 translate <110,29,16>}
}
//Szene=============================================================================================================

union{
object {Haus translate<-15,0,-130> texture{WandPutz}}
object {Haus rotate y*180 translate<95,0,-21> texture{WandPutz}}
//Gehweg
box{<-20,0,0>,<100,.05,15> translate <0,0,-90> texture{pigment{image_map{png "stonewall.png"} rotate x*90 scale 10}}}
box{<0,0,0>,<15,.05,40> translate <7,0,-95> texture{pigment{image_map{png "stonewall.png"} rotate x*90 scale 10}}}
box{<0,0,0>,<15,.05,40> translate <62,0,-95> texture{pigment{image_map{png "stonewall.png"} rotate x*90 scale 10}}}
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
