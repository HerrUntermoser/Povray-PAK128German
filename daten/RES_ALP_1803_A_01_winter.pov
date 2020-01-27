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
          //adc_bailout 2
          error_bound 0.6
          count 30
          brightness 0.55
          gray_threshold 0.25
         // media on
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
#declare Camera_0 = camera{
  orthographic
  location<100, 81.4, -100>  
look_at<0, 0, 0>
}
#declare Camera_1 = camera {perspective angle 90// rueckseite
                            location <20 ,15.0 ,80>
                            look_at <20 ,15,0>}
#declare Camera_2 = camera {perspective angle 90//rechts
                            location  <80 ,35 ,20>
                            right x*image_width/image_height
							look_at <0,34,20>}
#declare Camera_3 = camera { perspective angle 90//links
                            location <-30 ,10,-100>
                            right x*image_width/image_height
							look_at <0,5,-101>}

#declare Camera_4 = camera {perspective angle 90// oben
                            location <15 , 65 ,15>
                            right x*image_width/image_height
                            look_at <16, 0.0 ,16>}
#declare Camera_5 = camera {perspective angle 90// vorne
                            location <27 ,17,-154>
                            right x*image_width/image_height
							look_at <26,15,0>}
camera {Camera_0}

// sun -------------------------------------------------------------------
light_source{<0,2500,-2500> color rgb < 0.9921569,  0.9137255,  0.827451 >}  // sunlight
#if (Radiosity_ON = 1)
background {color rgbt 1}
#else
light_source{<0 , 20.0 ,400.0>color White*0.2 shadowless} // flash
//light_source{ <25, 35 ,15>color White*0.9 shadowless} // flash 2
sky_sphere{
 pigment{ gradient <0,1,0>
          color_map{
          [0.0 color rgb<1,1,1>        ]
          [0.8 color rgb<0.1,0.25,0.75>]
          [1.0 color rgb<0.1,0.25,0.75>]}
        } // end pigment
 }
 
plane { <0,1,0>, 0

        texture{ pigment{ color DarkGreen}
	         normal { bumps 0.25 scale 0.05 }
             
               }
          translate<0,-50,0>
      }
#end
//=============================================objekte
#declare Wand_Farbe_1 =texture{ pigment{bozo scale 1.5 turbulence 0 
										color_map{[0.0 color rgb <0.70,0.75,0.71>]
												[0.3 color rgb <0.70,0.75,0.71>*1.1]
												//[0.4 color rgb <0.70,0.75,0.71>*0.8]
												[0.5 color rgb <0.70,0.75,0.71>]
												[0.8 color rgb <0.70,0.75,0.71>*0.9]
												[1.0 color rgb <0.70,0.75,0.71>*0.8]
												}
}
normal{granite 1 scale 1}}


//Dachtextur
#declare Dachtextur = texture{pigment{image_map{ bmp "Sonny_Block_Dach.bmp" map_type 0 interpolate 2}}}//texture {pigment{color Brown}}
#declare Firsttextur = texture{
								pigment{gradient x
										color_map{
												[0 color rgb <1,.33,0>*.5]
												[0.9 color rgb <1,.33,.0>*.6]
												[0.9 color rgb 0.4*0.7]
												[1 color rgb 0.4*0.3]}
												}}
												
#declare WDR = difference{cylinder {<0,0,0>,<59.5,0,0>,0.4}cylinder {<0.1,0,0>,<59,0,0>,0.35 translate <0,0.2,0>} texture {T_Brass_1A}}
#declare SDR = cylinder {<0,0,0>,<0,19,0>,0.3 texture {T_Brass_1A}}
#declare Zaunpfosten = union{box{<0,0,0>,<1,5,1>}box{<-0.2,5,-0.2>,<1.2,5.2,1.2>}texture{pigment{color rgb 0.6} normal{granite 1 scale 1}}}
#declare Zaunlatte = box{<0,0,0>,<0.5,3.8,0.2> texture{pigment{P_WoodGrain1B color_map{[0 rgb <.21,.14,.07>]
																		[0.5 rgb <.28,.19,.09>]
																		[1 rgb <.5,.5,.59>]}
																}}}
#declare Wandbrett_1 = box {<0,0,0>,<0.1,15,0.8> texture{T_Wood22}}														
#declare WBTex =  texture{pigment{gradient z color_map{[0 color rgb <.30,.20,.09>][0.5 color rgb <.20,.13,.06>][0.95 color rgb <.20,.13,.06>][0.95 color Clear][0.96 color Clear][1 color rgb <.3,.2,.09>][0.96 color rgb <.3,.2,.09>]}}}
#declare heckentex = texture {
pigment
 {granite
  turbulence 0.0
  color_map
   {[0.0, 0.07 color rgb <.23,.48,.34> color rgb <.23,.48,.34>]
    [0.07, 0.2 color rgb <.15,.31,.22> color  color rgb <.23,.48,.34>]
    [0.2, 0.3 color rgb <.23,.48,.34> color Clear]
    [0.3, 0.7 color Clear color Clear]
    [0.7, 1.0 color rgb <.23,.60,.34> color rgb <.23,.48,.34>]
   }
   }finish {crand 0.02}}
   
//===========================================================



//Union SZENE!===============
union{
//Union Gebäude
union{
difference{
object{Rohbau (59.5,19,36.5)texture{pigment {
  brick color rgb<1,1,1>        // mortar
        color rgb<0.8,0.25,0.1> // brick
  brick_size <.35,.15,.35>
  mortar 0.02
  }}
  }
box{<40,3,-1>,<60,20,24>}
box{<25,14,-1>,<51,20,37>}
box{<-1,14,-1>,<26,19.5,5>}
//Fensterloch Vorderseite
object{Fenster_AS_6x6 translate <5,6,-0.1>}
object{Fenster_AS_6x6 translate <15.5,6,-0.1>}
//Fensterloch Rückseite
object{Fenster_AS_6x6 translate <5,6,35.9>}
object{Fenster_AS_6x6 translate <15.5,6,35.9>}
//Fensterloch links
object{Fenster_AS_5x6 rotate y*90 translate <-.2,6,16>}
object{Fenster_AS_5x6 rotate y*90 translate <-.2,6,26>}
//Fensterloch rechts
object{Fenster_AS_5x6 rotate y*90 translate <58.7,6,16>}
object{Fenster_AS_5x6 rotate y*90 translate <58.7,6,26>}
//Haustuerloch
object{Haust_AS_7k5_11 translate<27,1,-.1>}
 }
 box{<26,0,0.5>,<26.5,13,15>texture{pigment {
  brick color rgb<1,1,1>        // mortar
        color rgb<0.8,0.25,0.1> // brick
  brick_size <.35,.15,.35>
  mortar 0.02
  warp{planar <0,0,1>, 1}}}}
 box{<26,0,24>,<26.5,13,36> pigment{brick color rgb<1,1,1>        // mortar
        color rgb<0.8,0.25,0.1> // brick
  brick_size <.35,.15,.35>
  mortar 0.02}}
 box{<.5,0,19>,<16.5,13,19.5> pigment{brick color rgb<1,1,1>   color rgb<0.8,0.25,0.1>  brick_size <.35,.15,.35>  mortar 0.02}}
 box{<0,0,0>,<9,2,6> translate <32,0.5,12> pigment{brick color rgb<.2,.2,.2>   color rgb<0.8,0.25,0.1>  brick_size <.35,.15,.35>  mortar 0.02 scale 1.1}}
 box{<0,0,0>,<6,4,4.5> translate <33,2,12> pigment{brick color rgb<.2,.2,.2>   color rgb<0.8,0.25,0.1>  brick_size <.35,.15,.35>  mortar 0.02 scale 1.1}}
 box{<0,0,0>,<4,2,3> translate <33,7,12> pigment{brick color rgb<.2,.2,.2>   color rgb<0.8,0.25,0.1>  brick_size <.35,.15,.35>  mortar 0.02 scale 1.1}}
//Gerüst
    union{
box{<-2,6,-0.4>,<59,6.2,-5>}
box{<-2,14,-0.4>,<29,14.2,-5>}
cylinder{<0,0,0>,<0,16,0>,0.2 translate<0.5,0,-5>}
cylinder{<0,0,0>,<0,16,0>,0.2 translate<0.5,0,-.5>}
cylinder{<0,0,0>,<0,16,0>,0.2 translate<10,0,-5>}
cylinder{<0,0,0>,<0,16,0>,0.2 translate<10,0,-.5>}
cylinder{<0,0,0>,<0,16,0>,0.2 translate<20,0,-5>}
cylinder{<0,0,0>,<0,16,0>,0.2 translate<20,0,-.5>}
cylinder{<0,0,0>,<0,16,0>,0.2 translate<28,0,-5>}
cylinder{<0,0,0>,<0,16,0>,0.2 translate<28,0,-.5>}
cylinder{<0,0,0>,<0,8,0>,0.2 translate<40,0,-5>}
cylinder{<0,0,0>,<0,8,0>,0.2 translate<40,0,-.5>}
cylinder{<0,0,0>,<0,8,0>,0.2 translate<55,0,-5>}
cylinder{<0,0,0>,<0,8,0>,0.2 translate<55,0,-.5>}
 texture{T_Wood15 scale 0.5}
    }
//rechts
    union{
box{<-2,6,-0.4>,<36,6.2,-5>}
box{<-2,14,-0.4>,<35,14.2,-5>}
cylinder{<0,0,0>,<0,16,0>,0.2 translate<0.5,0,-5>}
cylinder{<0,0,0>,<0,16,0>,0.2 translate<0.5,0,-.5>}
cylinder{<0,0,0>,<0,16,0>,0.2 translate<10,0,-5>}
cylinder{<0,0,0>,<0,16,0>,0.2 translate<10,0,-.5>}
cylinder{<0,0,0>,<0,16,0>,0.2 translate<20,0,-5>}
cylinder{<0,0,0>,<0,16,0>,0.2 translate<20,0,-.5>}
cylinder{<0,0,0>,<0,16,0>,0.2 translate<28,0,-5>}
cylinder{<0,0,0>,<0,16,0>,0.2 translate<28,0,-.5>}
texture{T_Wood15 scale 0.5}
    rotate y*90 translate<66,0,36>}
union{
box{<-2,6,-0.4>,<26,6.2,-5>}
cylinder{<0,0,0>,<0,8,0>,0.2 translate<0.5,0,-5>}
cylinder{<0,0,0>,<0,8,0>,0.2 translate<0.5,0,-.5>}
cylinder{<0,0,0>,<0,8,0>,0.2 translate<10,0,-5>}
cylinder{<0,0,0>,<0,8,0>,0.2 translate<10,0,-.5>}
texture{T_Wood15 scale 0.5}
    rotate y*90 translate<26.5,0,26>
    }
 translate <0,0,-60>}
 //Sandhaufen & Weg================================
 height_field{jpeg "kies_sehrgrob.jpg" smooth scale <15,1,70> translate <25,0,-134> pigment{bozo turbulence 1 color_map{[0 color rgb 1*0.5][1 color rgb 1*1.1]}}}
 height_field{png "Mount2.png" smooth scale <18,6,24> translate <45,-0.2,-104> pigment{image_map { jpeg "Sand_Braun_Mittel.jpg" map_type 0 interpolate 2} rotate x*90}}
height_field{png "kegel_grauschwarz.png" smooth scale <18,6,34> rotate y*23 translate <64,-0.2,-114> pigment{image_map { jpeg "kies_grob.jpg" map_type 0 interpolate 2} rotate x*90 scale <8,1,5>}}
height_field{png "Mount1.png" smooth scale <18,3,12> rotate y*-14 translate <58,-0.2,-91> pigment{image_map { jpeg "kies_grob_gelbweiss.jpg" map_type 0 interpolate 2} rotate x*90 scale 1}}
 //Bretterstapel=========================
 union{
 box{<0,0,0>,<0.5,0.1,12>}
 box{<0,0,0>,<0.5,0.1,12> translate<1.3,0,0>}
 box{<0,0,0>,<0.5,0.1,12> translate<2.6,0,0>}
 box{<0,0,0>,<0.5,0.1,12> translate<3.9,0,0>}
 box{<0,0,0>,<0.5,0.1,12> translate<4.9,0,0>}
 box{<0,0,0>,<0.5,0.1,12> translate<5.8,0,0>}
 box{<0,0,0>,<5.5,4.1,12> translate<6.8,0,0> rotate y*47}
 box{<0,0,0>,<5.5,4.1,12> translate<14,0,34> rotate y*67}
 
 texture{DMFWood4}
 translate<-10,0,-100>
 }
 box{<0,0,0>,<5.5,2,12>
  texture{DMFWood4}
 rotate y*67 translate<-10,0,-80> }
 //Eiche links hinten
 #declare Rinde = 
 texture{ pigment{ bozo color_map{[0 color rgb< .9, 0.9, 0.9>*.7][0.5 color rgb 1][1 color rgb<.9,.9,.9>*.8]}} 
	normal { bumps 1.00 scale <0.025,0.075,0.025> }
          finish { phong 0.2 reflection 0.00}         
        } 
#include "black_oak_2.inc"        
object { black_oak_2_13_stems texture{Rinde}  scale 5 rotate y*54 translate<90,0,-32>}

 //Bodenplatte
object {bodenplatte texture { pigment{ image_map { jpeg "sand_schnee.jpg" map_type 0 interpolate 2}} rotate x*90 scale <6010,60> finish {ambient 0}}}

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
