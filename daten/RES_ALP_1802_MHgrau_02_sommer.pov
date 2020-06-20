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
#include "woods.inc"
#include "basis.inc"
#include "kleinkram.inc"
#include "Taubenschlag_geom.inc"
#include "Lampe02_geom.inc"
#include "holzbank_geom.inc"
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
                            location  <35 ,30 ,-185>
                            right x*image_width/image_height
							look_at <35,30,0>}
camera {Camera_0}

//===========Sonne=========================
light_source{<0,2500,-2500>
                    color rgb < 0.9921569,  0.9137255,  0.827451 >
                    //adaptive 1
                    }  // sunlight
#if (Radiosity_ON = 1)
background {color rgbt 1}
#else
//light_source{<0 , 20.0 ,400.0>color White*0.2 shadowless} // flash
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
#declare WandPutz = texture{pigment{bozo turbulence 1 frequency 15 color_map{
                                    [0 color rgb <.70,.75,.71>*.7]
                                    [0.5 color rgb <.70,.75,.71>*1]
                                    [1 color rgb <.70,.75,.71>*.2]
                                    }
                                    scale <2,.5,1>}
                                    finish{ambient rgb <.7,.75,.71>*.2}}
#declare Holzlatten = texture {gradient y texture_map{[0 Holzpanel][.5 Holzpanel][.5 pigment {color rgb 0}][.6 pigment{color rgb 0}][.6 Holzpanel][1 Holzpanel]}}


//=======================================================
#declare dach = prism{0,40,4, <0,0>,<15,12>,<0,24>,<0,0> texture{pigment{image_map{jpeg "dachziegel_alt.jpg" interpolate 2}}scale 5}}
#declare Dachfenster = union{
difference{box{<0,0,0>,<7,7,8>}object{Fenster_AS_5x5 translate<1,1,-.1>}}
object{Fenster(5,5,texture{pigment{color rgb .2*.5}finish{ambient .2 diffuse .8 specular .1}}) translate<1,1,.1>}
box{<0,0,0>,<7.5,.1,8> translate<-.25,7.05,-.1> texture{T_Copper_1A}}
box{<0,0,0>,<7,-1,.2> rotate x*38.65 translate<0,.1,0>}
texture{pigment{color rgb .5*.7}finish{ambient .2 diffuse .8 specular .1}}}
#declare FarbigerSockel =
union{
box{<0,0,0>,<16.5,2,.02>}
box{<23.5,0,0>,<40,2,.02>}
 pigment{color rgb <.38,.4,.47>*.5}
}
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
object{Fenster_ML(5,6,T_Wood1, texture {pigment{ color rgb .7*.5}}) translate<2.5,7,.1>}
object{Fenster_ML(5,6,T_Wood1, texture {pigment{ color rgb .7*.5}}) rotate y*180 translate<7.5,7,20.1>}
object{Fenster_ML(5,6,T_Wood1, texture {pigment{ color rgb .7*.5}}) translate<32.5,7,.1>}
object{Fenster_ML(5,6,T_Wood1, texture {pigment{ color rgb .7*.5}}) rotate y*180 translate<37.5,7,20.1>}
object{Fenster_ML(5,6,T_Wood1, texture {pigment{ color rgb .7*.5}}) rotate y*180 translate<22.5,7,20.1>}
object{Fenster(3,3,texture{pigment{color rgb 1}}) translate<11,10,.1>}
object{Fenster(3,3,texture{pigment{color rgb 1}}) translate<26,10,.1>}
object{Haustuer_7_11_rgrau translate<16.5,.1,.1>}
object{FarbigerSockel}
//Lampe
prism {
    conic_sweep
    linear_spline
    0.225,1,5,
    <4,4>,<-4,4>,<-4,-4>,<4,-4>,<4,4>
    //rotate <180, 0, 0>
scale <.2, 2,.2>
    translate <20,14,-1>
        pigment { color rgb .2 }
  }
object{Dachfenster translate<16.5,21,0>}
object{Kamin_2a rotate y*90  translate<27,27,10>}
box{<0,0,0>,<7,2,.1> translate<16.5,12,-.1> pigment{image_map{tga "greenalpha.tga" interpolate 2}scale 2}}
cylinder{<0,0,0>,<0,18,0>,.2 translate<39,0,-.2> texture{T_Copper_2A}}
}
#declare gehweg = box{<0,0,0>,<7,.1,8> texture {pigment{image_map{jpeg "pflastersteine.jpeg" interpolate 2}} rotate x*90 scale 10}}
#declare Waescheleine = union{
 cylinder{<0,0,0>,<0,7,0>,0.2} 
 cylinder{<0,0,0>,<0,7,0>,0.2 translate <20,0,0>}
 box{<0,1,0>,<7,7,.05> texture{pigment{image_map{png "bettuch_tex.png" interpolate 2}scale <7,7,1>} finish{ambient  rgb <.98,.98,.82>*1.1}}}
 box{<9,1,0>,<16,7,.05>  texture{pigment{image_map{png "bettuch_tex.png" interpolate 2}scale <16,7,1>} finish{ambient rgb <.98,.98,.82>*1.1}}}
 texture{pigment{color rgb 0.2*0.5}}
 }
 #declare Waescheleine3 = union{
 cylinder{<0,0,0>,<0,7,0>,0.2} 
 cylinder{<0,0,0>,<0,7,0>,0.2 translate <30,0,0>}
 box{<0,1,0>,<7,7,.05> pigment{ color rgb 1}}
 box{<9,1,0>,<16,7,.05>   texture{pigment{image_map{png "bettuch_tex.png" interpolate 2}scale <16,7,1>} finish{ambient rgb <0,.71,0>}}}
 box{<17,1,0>,<25,7,.05> pigment{ color rgb 1}}
 texture{pigment{color rgb 0.2*0.5}}
 }
//Szene=============================================================================================================

union{
//box{<-20,0,-1>,<100,5,1> translate<0,0,-134> pigment{color rgb <1,0,0>}}
object {Haus texture{WandPutz} translate <-20,0,-125>}
object {Haus texture{WandPutz} translate <20,0,-125>}
object {Haus texture{WandPutz} translate <60,0,-125>}
object {Haus texture{WandPutz} rotate y*180 translate <20,0,-20>}
object {Haus texture{WandPutz} rotate y*180 translate <60,0,-20>}
object {Haus texture{WandPutz} rotate y*180 translate <100,0,-20>}
object{gehweg translate <-4,0,-134>}
object{gehweg translate <36,0,-134>}
object{gehweg translate <76,0,-134>}
object{gehweg translate <-4,0,-23>}
object{gehweg translate <36,0,-23>}
object{gehweg translate <76,0,-23>}
object{Waescheleine translate<0,0,-60>}
object{Waescheleine translate<30,0,-60>}
object{Waescheleine3 translate<20,0,-70>}
object{Lampe02_ scale .003 translate <10,0,-133> material{lampe02_mat}}
object{Lampe02_ scale .003 translate <46,0,-133> material{lampe02_mat}}
object{Lampe02_ scale .003 translate <8,0,-17> material{lampe02_mat}}
object{Lampe02_ scale .003 translate <46,0,-17> material{lampe02_mat}}
object{Taubenschlag_Taubenschlag_ scale .002 translate <90,0,-70> material{Taubenschlag_}}
object{holzbank scale .003 rotate y*180 translate<80,0,-22>}
object{holzbank scale .003 rotate y*180 translate<90,0,-22>}
//Bodenplatte
object {bodenplatte texture{pigment{ image_map { jpeg "grasstex1.jpg" interpolate 2}  scale 40 rotate x*90}}}
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
