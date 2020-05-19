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
#include "woods.inc"
#include "basis.inc"
#include "kleinkram.inc"
#include "Taubenschlag_geom.inc"
//=============Render Kamera=========
  #declare Camera_0 = camera{
  orthographic
  location<100, 81.4, -100>  
look_at<0, 0, 0>
}
//=========Rückseite============
#declare Camera_1 = camera {perspective angle 90
                            location  <60 ,10 ,-70.0>
                            look_at   <60 ,10,-200>}
//=============rechts==============
#declare Camera_2 = camera {perspective angle 90
                            location  <130 , 40 ,-100>
                            right x*image_width/image_height
							look_at <0,30,-100>
							}
//==============links============
#declare Camera_3 = camera { perspective angle 90
                            location  <-40 , 40 ,-30>
                            right x*image_width/image_height
							look_at <0,30,-30>
							}
//=========Oben=======
#declare Camera_4 = camera {perspective angle 90
                            location  <0 , 90 ,-50>
                            right     x*image_width/image_height
                            look_at   <0 , 0.0 ,-55>}
//===============Vorderseite===============
#declare Camera_5 = camera {perspective angle 90
                            location  <90 ,40 ,-150>
                            right x*image_width/image_height
							look_at <90,35,0>}
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
#declare DachSegment_1 = difference{prism{0,73,4,<0,0>,<0,40>,<20,20>,<0,0>}prism{0,41,4,<0,0>,<0,40>,<20,20>,<0,0> translate<-.2,-.5,0>} pigment{image_map{jpeg "dachziegel_alt.jpg" interpolate 2}scale 8}}
#declare DachSegment_2 = difference{prism{0,73,4,<0,0>,<0,40>,<20,20>,<0,0>}prism{0,41,4,<0,0>,<0,40>,<20,20>,<0,0> translate<-.2,-.5,0>} pigment{image_map{jpeg "dachziegel_alt.jpg" interpolate 2}scale 8}}
#declare DachSegment_3 = difference{prism{0,38,4,<0,0>,<18,0>,<9,4>,<0,0>}prism{0,39,4,<0,0>,<18,0>,<9,4>,<0,0> translate<0,-.5,-.2>} pigment{image_map{jpeg "dachziegel_alt.jpg" interpolate 2}scale 5}}
#declare DachEcken = difference{
    box {<1,1,1>, <-1,0,-1>}
    plane { x-y,  -sqrt(2)/2 }
    plane { -x-y, -sqrt(2)/2 }
    plane { z-y,  -sqrt(2)/2 }
    plane { -z-y, -sqrt(2)/2 }
}
//=======================================================
#declare Haus_Roh = difference {
box{<0,0,0>,<110,25,109>}
box{<0,0,0>,<109,26,35> translate<.5,.5,.5>}
box{<0,0,0>,<109,26,35> translate<.5,.5,73.5>}
box{<0,0,0>,<35,26,38.5> translate<.5,.5,35.5>}
box{<0,0,0>,<35,26,38.5> translate<73.5,.5,35.5>}
box{<0,0,0>,<37,26,37> translate<36,.5,36>}
//Fensterloch Vorderseite
object{Fenster_AS_6x6 translate <5,9,-0.1>}
object{Fenster_AS_6x6 translate <15,9,-0.1>}
object{Fenster_AS_6x6 translate <25,9,-0.1>}
object{Fenster_AS_6x6 translate <35,9,-0.1>}
object{Fenster_AS_6x6 translate <45,9,-0.1>}
object{Fenster_AS_6x6 translate <55,9,-0.1>}
object{Fenster_AS_6x6 translate <65,9,-0.1>}
object{Fenster_AS_6x6 translate <75,9,-0.1>}
object{Fenster_AS_6x6 translate <85,9,-0.1>}
object{Fenster_AS_6x6 translate <95,9,-0.1>}
//Fensterloch Rückseite
object{Fenster_AS_6x6 translate <5,9,108.4>}
object{Fenster_AS_6x6 translate <15,9,108.4>}
object{Fenster_AS_6x6 translate <25,9,108.4>}
object{Fenster_AS_6x6 translate <35,9,108.4>}
object{Fenster_AS_6x6 translate <45,9,108.4>}
object{Fenster_AS_6x6 translate <55,9,108.4>}
object{Fenster_AS_6x6 translate <65,9,108.4>}
object{Fenster_AS_6x6 translate <75,9,108.4>}
object{Fenster_AS_6x6 translate <85,9,108.4>}
object{Fenster_AS_6x6 translate <95,9,108.4>}
//Fensterloch Innenhof
object{Fenster_AS_6x6 translate <43,9,35.4>}
object{Fenster_AS_6x6 translate <57,9,35.4>}
object{Fenster_AS_6x6 translate <39,9,72.7>}
object{Fenster_AS_6x6 translate <61,9,72.7>}
//Fenster links aussen
object{Fenster_AS_5x6 rotate y*90 translate <-.4,9,16>}
object{Fenster_AS_5x6 rotate y*90 translate <-.4,9,36>}
object{Fenster_AS_5x6 rotate y*90 translate <-.4,9,83>}
object{Fenster_AS_5x6 rotate y*90 translate <-.4,9,96>}
//Fenster rechts aussen
object{Fenster_AS_5x6 rotate y*90 translate <109.4,9,16>}
object{Fenster_AS_5x6 rotate y*90 translate <109.4,9,36>}
object{Fenster_AS_5x6 rotate y*90 translate <109.4,9,83>}
object{Fenster_AS_5x6 rotate y*90 translate <109.4,9,96>}
//Hofdurchgang
union{
box{<-1,0,0>,<112,13,11>}
cylinder{<-1,0,0>,<112,0,0>,5.5 translate <0,13,5.5>}
translate <0,0,54.5>}
}
//=================================================
#declare Haus = union{
object{Haus_Roh}
//Strassenseite
//object{OGVRGiebelWand  translate<22.5,24,.5> texture{Holzlatten scale 1.5}}
//object{OGVRGiebelWand  translate<74.5,24,.5> texture{Holzlatten scale 1.5}}
//Hofseite
//object{OGVRGiebelWand  rotate y*180 translate<39,24,35.4> texture{Holzlatten scale 1.5}}
//object{OGVRGiebelWand  rotate y*180 translate<91,24,35.4> texture{Holzlatten scale 1.5}}
//object{OGLRGiebelWand rotate z*90 translate<0.5,25,0> texture{Holzlatten scale 2}}
//object{OGLRGiebelWand rotate z*90 translate<110,25,0> texture{Holzlatten scale 2}}
//Dach
object{DachSegment_1 rotate z*90 translate<92,23,-2>}
object{DachSegment_1 rotate z*90 translate<92,23,71>}
object{DachSegment_2 rotate z*90 rotate y*90 translate<72,23,18>}
object{DachSegment_2 rotate z*90 rotate y*90 translate<-2,23,18>}
//Dachecken
object{DachEcken scale <20,20,20> translate<91.99,23,18.01> pigment{image_map{jpeg "dachziegel_alt.jpg" interpolate 2}rotate x*90 scale 8}}//rechts vorn
object{DachEcken scale <20,20,20> translate<17.99,23,18.01> pigment{image_map{jpeg "dachziegel_alt.jpg" interpolate 2}rotate x*90 scale 8}}//links vorn
object{DachEcken scale <20,20,20> translate<17.99,23,90.99>  pigment{image_map{jpeg "dachziegel_alt.jpg" interpolate 2}rotate x*90 scale 8}}//links hinten
object{DachEcken scale <20,20,20> translate<91.99,23,90.99>  pigment{image_map{jpeg "dachziegel_alt.jpg" interpolate 2}rotate x*90 scale 8}}//rechts hinten
//object{DachSegment_3 rotate x*-90 translate<21.75,37.25,36>}
//object{DachSegment_3 rotate x*-90 translate<73.75,37.25,36>}
//Kamine
//vorne
object{Kamin_2 translate<24,36,14>}
object{Kamin_2 translate<44,36,14>}
object{Kamin_2 translate<64,36,14>}
object{Kamin_2 translate<84,36,14>}
//hinten
object{Kamin_2 translate<24,36,92>}
object{Kamin_2 translate<44,36,92>}
object{Kamin_2 translate<64,36,92>}
object{Kamin_2 translate<84,36,92>}
//rechts
object{Kamin_2 rotate y*90 translate<94,36,45>}
//links
object{Kamin_2 rotate y*90 translate<14,36,48>}
//Haustüren
//object{Haustuer_6_10_rund rotate y*180 translate<31,1,36.1>}
//object{Haustuer_6_10_rund rotate y*180 translate<84,1,36.1>}
//Fenster EG Strassenseite
object{Fenster6x6_Rnavajo translate <5,9,0>}
object{Fenster6x6_Rnavajo translate <15,9,0>}
object{Fenster6x6_Rnavajo translate <25,9,0>}
object{Fenster6x6_Rnavajo translate <35,9,0>}
object{Fenster6x6_Rnavajo translate <45,9,0>}
object{Fenster6x6_Rnavajo translate <55,9,0>}
object{Fenster6x6_Rnavajo translate <65,9,0>}
object{Fenster6x6_Rnavajo translate <75,9,0>}
object{Fenster6x6_Rnavajo translate <85,9,0>}
object{Fenster6x6_Rnavajo translate <95,9,0>}
//Fenster Rückseite
object{Fenster6x6_Rnavajo rotate y*180 translate <11,9,109>}
object{Fenster6x6_Rnavajo rotate y*180 translate <21,9,109>}
object{Fenster6x6_Rnavajo rotate y*180 translate <31,9,109>}
object{Fenster6x6_Rnavajo rotate y*180 translate <41,9,109>}
object{Fenster6x6_Rnavajo rotate y*180 translate <51,9,109>}
object{Fenster6x6_Rnavajo rotate y*180 translate <61,9,109>}
object{Fenster6x6_Rnavajo rotate y*180 translate <71,9,109>}
object{Fenster6x6_Rnavajo rotate y*180 translate <81,9,109>}
object{Fenster6x6_Rnavajo rotate y*180 translate <91,9,109>}
object{Fenster6x6_Rnavajo rotate y*180 translate <101,9,109>}
//Fenster Hofseite
object{Fenster6x6_Rnavajo rotate y*180 translate <45,9,72.8>}
object{Fenster6x6_Rnavajo rotate y*180 translate <67,9,72.8>}
object{Fenster6x6_Rnavajo rotate y*180 translate <49,9,36>}
object{Fenster6x6_Rnavajo rotate y*180 translate <63,9,36>}
//Fenster links aussen
object{Fenster5x6_Rnavajo rotate y*90 translate <-.1,9,16>}
object{Fenster5x6_Rnavajo rotate y*90 translate <-.1,9,36>}
object{Fenster5x6_Rnavajo rotate y*90 translate <-.1,9,83>}
object{Fenster5x6_Rnavajo rotate y*90 translate <-.1,9,96>}
//Fenster rechts aussen
object{Fenster5x6_Rnavajo rotate y*-90 translate <110,9,11>}
object{Fenster5x6_Rnavajo rotate y*-90 translate <110,9,31>}
object{Fenster5x6_Rnavajo rotate y*-90 translate <110,9,78>}
object{Fenster5x6_Rnavajo rotate y*-90 translate <110,9,91>}
}
//Szene=============================================================================================================

union{
object {Haus translate<-15,0,-129> texture{WandPutz}/* texture{pigment{image_map{png "diagonalesnetz_gruen.png"}}}*/}

//Laternen 
//object{Laterne_1 scale 1.4 translate <7,0,-85>}
//object{Laterne_1 scale 1.4 translate <7,0,-70>}
//object{Laterne_1 scale 1.4 translate <60,0,-85>}
//object{Laterne_1 scale 1.4 translate <60,0,-70>}
//Taubenschlag
//object{Taubenschlag scale .003 translate <50,0,-68>}
//Büsche
/*
#include "trauerweide.inc"
#declare Blaetter_3 = 
 texture{ pigment{ color rgb< .16, .27,0>*1}   
          normal { bumps 0.15 scale 0.05 }
          finish {ambient 0.1 diffuse 0.9 phong 0.9}
        }
#declare Blaetter_4 = 
 texture{ pigment{  color rgb< .11,.19,0>*1.05}   
          normal { bumps 0.15 scale 0.05 }
          finish {phong 0.9}
        }
union { object { weeping_willow_13_stems texture{Rinde}}
         object { weeping_willow_13_leaves  double_illuminate
                  texture{ Blaetter_3 }   
                  interior_texture{ Blaetter_4 }}
         scale .5 rotate y*37 translate<90,0,-63>}
union { object { weeping_willow_13_stems texture{Rinde}}
         object { weeping_willow_13_leaves  double_illuminate
                  texture{ Blaetter_3 }   
                  interior_texture{ Blaetter_4 }}
         scale .5 rotate y*37 translate<80,0,-65>}
union { object { weeping_willow_13_stems texture{Rinde}}
         object { weeping_willow_13_leaves  double_illuminate
                  texture{ Blaetter_3 }   
                  interior_texture{ Blaetter_4 }}
         scale .7 rotate y*-27 translate<0,0,-69>}
         */
//Bodenplatte
object {bodenplatte texture { pigment{ image_map { jpeg "grastex2.jpg" map_type 0 interpolate 2} rotate <90,0,0> scale 30} normal{bump_map{ jpeg "grastex2_tiefe.jpg" interpolate 2 bump_size 5}rotate x*90 scale 30}finish {ambient 0}}}
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
