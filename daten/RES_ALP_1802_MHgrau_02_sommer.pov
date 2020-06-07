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
                            location  <10 ,10 ,70>
                            look_at   <10 ,10,0>}
//=============rechts==============
#declare Camera_2 = camera {perspective angle 90
                            location  <90 , 20 ,0>
                            right x*image_width/image_height
							look_at <0,20,0>
							}
//==============links============
#declare Camera_3 = camera { perspective angle 90
                            location  <-40 ,30 ,0>
                            right x*image_width/image_height
							look_at <0,30,-10>
							}
//=========Oben=======
#declare Camera_4 = camera {perspective angle 90
                            location  <0 , 90 ,20>
                            right     x*image_width/image_height
                            look_at   <0 , 0.0 ,25>}
//===============Vorderseite===============
#declare Camera_5 = camera {perspective angle 90
                            location  <20 ,30 ,-25>
                            right x*image_width/image_height
							look_at <15,30,0>}
camera {Camera_0}

//===========Sonne=========================
light_source{<0,2500,-2500> color rgb < 0.9921569,  0.9137255,  0.827451 >}  // sunlight
#if (Radiosity_ON = 1)
background {color rgbt 1}
#else
light_source{<0 , 20.0 ,400.0>color White*0.2 shadowless} // flash
//light_source{ <25, 5 ,15>color White*0.9 shadowless} // flash 2
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
#declare WandPutz = texture{pigment{ color rgb <1,0,0>} finish{ambient .1 diffuse .9}}
#declare Holzlatten = texture {gradient y texture_map{[0 Holzpanel][.5 Holzpanel][.5 pigment {color rgb 0}][.6 pigment{color rgb 0}][.6 Holzpanel][1 Holzpanel]}}


//=======================================================
#declare dach = prism{0,40,4, <0,0>,<15,12>,<0,24>,<0,0> texture{pigment{color rgb <0,0,1>*.5}}}
#declare Dachfenster = union{
difference{box{<0,0,0>,<7,7,8>}object{Fenster_AS_5x5 translate<1,1,-.1>}}
object{Fenster(5,5,texture{pigment{color rgb .2*.5}finish{ambient .2 diffuse .8 specular .1}}) translate<1,1,.1>}
box{<0,0,0>,<7.5,.1,8> translate<-.25,7.05,-.1> texture{T_Copper_1A}}
box{<0,0,0>,<7,-1,.2> rotate x*38.65 translate<0,.1,0>}
texture{pigment{color rgb .5*.7}finish{ambient .2 diffuse .8 specular .1}}}
#declare Haus = union{
difference{
object{ Rohbau(40,18,20)}
object{Fenster_AS_5x6 translate<2.5,7,-.1>}
object{Fenster_AS_5x6 translate<32.5,7,-.1>}
object{Fenster_AS_var (3,3,1) translate<11,10,-.1>}
object{Fenster_AS_var (3,3,1) translate<26,10,-.1>}
object{Haust_AS_7_11 translate<16.5,.1,-.1>}
//Hinten
object{Fenster_AS_5x6 translate<2.5,7,19.4>}
object{Fenster_AS_5x6 translate<17.5,7,19.4>}
object{Fenster_AS_5x6 translate<32.5,7,19.4>}
}
object{dach rotate z*90 translate<40,18,-2>}
object{Fenster_ML(5,6,T_Wood1, texture {pigment{ color rgb .7*.7}}) translate<2.5,7,.1>}
object{Fenster_ML(5,6,T_Wood1, texture {pigment{ color rgb .7*.7}}) rotate y*180 translate<7.5,7,20.1>}
object{Fenster_ML(5,6,T_Wood1, texture {pigment{ color rgb .7*.7}}) translate<32.5,7,.1>}
object{Fenster_ML(5,6,T_Wood1, texture {pigment{ color rgb .7*.7}}) rotate y*180 translate<37.5,7,20.1>}
object{Fenster_ML(5,6,T_Wood1, texture {pigment{ color rgb .7*.7}}) rotate y*180 translate<22.5,7,20.1>}
object{Fenster(3,3,texture{pigment{color rgb 1}}) translate<11,10,.1>}
object{Fenster(3,3,texture{pigment{color rgb 1}}) translate<26,10,.1>}
object{Dachfenster translate<16.5,21,0>}
object{Kamin_2a rotate y*90  translate<27,27,10>}
}

//Szene=============================================================================================================

union{
object {Haus texture{WandPutz}}
//Bodenplatte
object {bodenplatte texture { pigment{ image_map { jpeg "grasstex1.jpg" map_type 0 interpolate 2} rotate <90,0,0> scale 40*2}/* normal{bump_map{ jpeg "grastex2_tiefe.jpg" interpolate 2 bump_size 5}rotate x*90 scale 30}*/finish {ambient 0}}}
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
