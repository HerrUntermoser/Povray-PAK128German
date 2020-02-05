// PoVRay 3.7
// author: daniel_martin@gmx.at
#version 3.7;
#declare Radiosity_ON = 1; 
#if (Radiosity_ON = 1 )
global_settings{
  ambient_light 1
  assumed_gamma 1.0
  radiosity {
         adc_bailout 2
          error_bound 0.6
          count 30
          brightness 0.55
          gray_threshold 0.25
         // media on
         normal on
          recursion_limit 2
       } // --------------
 }
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
#include "shapes3.inc"
#include "Roof_0.inc"
#include "basis.inc"
#include "kleinkram.inc"
#declare Camera_0 = camera{
  orthographic
  location<100, 81.4, -100>  
look_at<0, 0, 0>
}
#declare Camera_1 = camera {perspective angle 90   // rueckseite
                            location  <-20 ,15.0 ,10.0>
                            look_at   <0 ,15,0>}
#declare Camera_2 = camera {perspective angle 90//rechts
                            location  <130 ,15 ,-60>
                            right x*image_width/image_height
							look_at <0,15,-60>
							}
#declare Camera_3 = camera { perspective angle 90//links
                            location  <-40 , 20 ,-80>
                            right x*image_width/image_height
							look_at <0,10,-70>
							}

#declare Camera_4 = camera {perspective angle 90        // oben
                            location  <50 , 100 ,-70>
                            right     x*image_width/image_height
                            look_at   <50 , 0.0 ,-71>}
#declare Camera_5 = camera {perspective angle 90// vorne
                            location  <50 , 15 ,-150>
                            right x*image_width/image_height
							look_at <50,15,0>}
camera {Camera_0}

// sun -------------------------------------------------------------------
light_source{<0,2500,-2500> color rgb < 0.9921569,  0.9137255,  0.827451 >}  // sunlight
//Zusätzliche Lichtquelle im Gebäude
light_source{<35,10 ,-50>color White*.9}
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
#declare BT = texture {pigment {color rgb 0.2}}
#declare TTrans = texture {pigment{color Clear}}
#declare BalkonPfosten = texture_map{[0.0 T_Wood12][0.6 T_Wood26][0.7 T_Wood12][0.7 TTrans][0.9 BT][1.0 BT]}
#declare HT = texture {pigment {color DarkSlateBlue}}
#declare Wand_Farbe_1 =
texture{ pigment{ brick
           color rgb .7
           color Scarlet//rgb<0.8,0.25,0.1>
           brick_size <1.2,.5,.6 >
          mortar .15
         }
  normal { wrinkles 0.75 scale 0.1}
  finish { diffuse 0.9 phong 0.2}
  }
#declare FirstTextur = texture{pigment{ gradient x color_map{ [0.0 color DarkSlateGrey*0.4][0.9 color DarkSlateGrey][0.9 color rgb 0.2][1.0 color rgb 0.2]}}scale 2 finish{ambient 0}}


#declare RoofTrans = <-2.35,0,0>;
#declare Roof_Base_Color = <0.69,0,0.16>;
#declare Roof_Color_Factor = 0.4;
//Dachtextur
#declare Roof_Texture1 = texture{
   pigment{gradient x 
           color_map{[0.00 color Scarlet*0.7 ]
                     [0.90 color Scarlet*0.6 ]
                     [0.90 color rgb 0.1 ]
                     [0.95 color rgb 0 ]
                     [1.00 color rgb 0 ]
                    }
           scale 4}
   normal { bumps 0.3 scale 0.015} 
   finish { specular 0.08 roughness 0.8}
   translate RoofTrans}

#declare Roof_Texture2 = texture{
   Roof_Texture1 
   finish { ambient 0.15 diffuse 0.85}}
#declare T_Wood_Door = texture{pigment{P_WoodGrain1A color_map {
    [0.000, 0.256 color rgb <0.30,0.65,1>*1.25 
                  color rgb <0.30,0.65,1>*1.25]
    [0.256, 0.393 color rgb <0.30,0.65,1>*1.25
                  color rgb <0.23,0.49,0.75>*1.25]
    [0.393, 0.581 color rgb <0.23,0.49,0.75>*1.25
                  color rgb <0.23,0.49,0.75>*1.25]
    [0.581, 0.726 color rgb <0.19,0.42,0.6>*1.25
                  color rgb <0.19,0.42,0.6>*1.25]
    [0.726, 0.983 color rgb <0.19,0.42,0.6>*1.25
                  color rgb <0.19,0.42,0.6>*1.25]
    [0.983, 1.000 color rgb <0.2,0.42,0.65>*1.25
                  color rgb <0.2,0.42,0.65>*1.25]
}}}
   //===========================================================
#declare Haus_Roh =
union{
difference {
box {<0,0,0>,<70,19.5,50>}       
//Innenraum
box {<0.5,0.5,0.5>,<69.5,25,49.5>}
//Fensteraussparungen EG
object {Fenster_AS_6x6 translate <10,6,-0.2>}
object {Fenster_AS_6x6 translate <25,6,-0.2>}
object {Fenster_AS_6x6 translate <40,6,-0.2>}
object {Fenster_AS_6x6 translate <55,6,-0.2>}
//Fensteraussparungen links
object {Fenster_AS_6x6 rotate y*90 translate <-0.2,6,11>}
object {Fenster_AS_6x6 rotate y*90 translate <-0.2,6,23>}

//Fensteraussparungen rechts
object {Fenster_AS_6x6 rotate y*90 translate <69.4,6,12>}
object {Fenster_AS_6x6 rotate y*90 translate <69.4,6,43>}
//Fensteraussparungen EG-R
object {Fenster_AS_6x6 translate <10,6,49.5>}
object {Fenster_AS_6x6 translate <25,6,49.5>}
object {Fenster_AS_6x6 translate <40,6,49.5>}
object {Fenster_AS_6x6 translate <55,6,49.5>}
//Haustuer
box {<0,0,0>,<9,11.5,1> rotate y*90 translate <-0.1,0.5,37>}
}
//Ziersockel unten
box {<-0.3,-0.05,-0.3>,<70.3,0.7,50.3> texture {T_Stone31 scale 0.05}}
texture {Wand_Farbe_1}
 }

//Szene=============================================================================================================

union{
union{
object {Haus_Roh}
object{Kamin_1 translate <19,32,25>}
object{Kamin_1 translate <48,32,22>}
//Gerüst
    union{
box{<-2,6,-0.4>,<59,6.2,-5>}
box{<-2,14,-0.4>,<59,14.2,-5>}
cylinder{<0,0,0>,<0,16,0>,0.2 translate<0.5,0,-5>}
cylinder{<0,0,0>,<0,16,0>,0.2 translate<0.5,0,-.5>}
cylinder{<0,0,0>,<0,16,0>,0.2 translate<10,0,-5>}
cylinder{<0,0,0>,<0,16,0>,0.2 translate<10,0,-.5>}
cylinder{<0,0,0>,<0,16,0>,0.2 translate<20,0,-5>}
cylinder{<0,0,0>,<0,16,0>,0.2 translate<20,0,-.5>}
cylinder{<0,0,0>,<0,16,0>,0.2 translate<28,0,-5>}
cylinder{<0,0,0>,<0,16,0>,0.2 translate<28,0,-.5>}
cylinder{<0,0,0>,<0,16,0>,0.2 translate<40,0,-5>}
cylinder{<0,0,0>,<0,16,0>,0.2 translate<40,0,-.5>}
cylinder{<0,0,0>,<0,16,0>,0.2 translate<55,0,-5>}
cylinder{<0,0,0>,<0,16,0>,0.2 translate<55,0,-.5>}
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
    rotate y*90 translate<76,0,36>}
union{
box{<-2,6,-0.4>,<26,6.2,-5>}
cylinder{<0,0,0>,<0,8,0>,0.2 translate<0.5,0,-5>}
cylinder{<0,0,0>,<0,8,0>,0.2 translate<0.5,0,-.5>}
cylinder{<0,0,0>,<0,8,0>,0.2 translate<10,0,-5>}
cylinder{<0,0,0>,<0,8,0>,0.2 translate<10,0,-.5>}
texture{T_Wood15 scale 0.5}
    rotate y*90 translate<76,0,26>
    }
 translate <0,0,-115>}
 //Bretterstapel
 union{
 box{<0,0,0>,<0.5,0.1,12>}
 box{<0,0,0>,<0.5,0.1,12> translate<1.3,0,0>}
 box{<0,0,0>,<0.5,0.1,12> translate<2.6,0,0>}
 box{<0,0,0>,<0.5,0.1,12> translate<3.9,0,0>}
 box{<0,0,0>,<0.5,0.1,12> translate<4.9,0,0>}
 box{<0,0,0>,<0.5,0.1,12> translate<5.8,0,0>}
 box{<0,0,0>,<5.5,4.1,12> translate<6.8,0,0> rotate y*47}
 box{<0,0,0>,<5.5,4.1,12> rotate y*67 translate<6,0,12>}
 
 texture{gradient y texture_map{BalkonPfosten}}
 translate<80,0,-120>
 }
 box{<0,0,0>,<5.5,2,12>
  texture{gradient x texture_map{BalkonPfosten}}
 rotate y*67 translate<10,0,-30> }
//Dachflaechen
object{ Roof_0 (   45,    // Roof___Angle1, // roof angle                              
                    70.00, // Roof___WideX,  //   base length of the roof part in x-direction
                    50.00, // Roof___WideZ,  //   base length of the roof part in z-direction  
                   1.0,  // Roof___Over,     // overhang
                   1.1, // R_Cyl,          // radius cylinders
                   1.4,  // Cyl_D,         // distance cylinders
                   Roof_Texture1, // Roof___Texture1, // cylinder texture
                   Roof_Texture2  // Roof___Texture2  // base box texture
                ) //------------------------------------------------------  
 scale <1,0.7,1>       
translate<-0,19.5,-115>}
//Sandhaufen & Weg================================
 height_field{tga "sandhaufen_hf.tga" smooth scale <35,4,12> translate <25,0,-34> pigment{image_map { jpeg "Sand_Braun_Mittel.jpg" map_type 0 interpolate 2} rotate x*90}}
 height_field{png "Mount2.png" smooth scale <18,6,24> rotate y*17 translate <42,-0.2,-42> pigment{image_map { jpeg "Sand_Braun_Mittel.jpg" map_type 0 interpolate 2} rotate x*90}}
height_field{png "kegel_grauschwarz.png" smooth scale <18,6,34> rotate y*23 translate <70,-0.2,-104> pigment{image_map { jpeg "kies_grob.jpg" map_type 0 interpolate 2} rotate x*90 scale <8,1,5>}}
//Kleinkram
object{schuttwanne rotate x*-90 rotate y*37 translate<70,0,-24> texture{Sandalwood}}
object{schuttwanne rotate x*-90 rotate y*-12 translate<65,0,-30> texture{Sandalwood}}
object{schuttwanne rotate x*-90 translate<68,0,-17> texture{Sandalwood}}

#include "kirsche_wood.inc"
#include "kirsche_foliage.inc"

union {
object{FOLIAGE texture{Laub_Sommer1} double_illuminate}

object{WOOD
	texture {
		onion
		texture_map {
			[0 Rinde scale <1/571.1, 1/5033.684, 1/571.1>]
			[0.3 Rinde scale <5.253021E-4, 5.9598497E-5, 5.253021E-4>]
			[1 Rinde scale <1.751007E-4, 1.9866166E-5, 1.751007E-4>]
		}
		scale <571.1, 5033.684, 571.1>/817.99994
	}
}
scale 28
translate <-6,0,-30>
}
//Bodenplatte
object {bodenplatte texture { pigment{ image_map {  jpeg "Boden-Erde-Steine.jpg" map_type 0 interpolate 2}} rotate <90,0,0> scale 5 finish {ambient 0}}}

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
