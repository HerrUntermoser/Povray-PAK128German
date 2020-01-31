// PoVRay 3.7
// author: daniel_martin@gmx.at
#version 3.7; // 3.6
#declare Radiosity_ON =0; 
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

  #declare Camera_0 = camera{
  orthographic
  location<100, 81.4, -100>  
look_at<0, 0, 0>
}
#declare Camera_1 = camera {perspective angle 90   // rueckseite
                            location  <20 ,65.0 ,30.0>
                            look_at   <20 ,65,0>}
#declare Camera_2 = camera {perspective angle 90//rechts
                            location  <130 , 40 ,-50>
                            right x*image_width/image_height
							look_at <0,30,-50>
							}
#declare Camera_3 = camera { perspective angle 90//links
                            location  <-30 , 46 ,-70>
                            right x*image_width/image_height
							look_at <0,28,-70>
							}

#declare Camera_4 = camera {perspective angle 90        // oben
                            location  <50 , 100 ,-70>
                            right     x*image_width/image_height
                            look_at   <50 , 0.0 ,-71>}
#declare Camera_5 = camera {perspective angle 90// vorne
                            location  <50 , 15.0 ,-200>
                            right x*image_width/image_height
							look_at <50,0,0>}
camera {Camera_0}

// sun -------------------------------------------------------------------
light_source{<0,2500,-2500> color rgb < 0.9921569,  0.9137255,  0.827451 >} 
#if (Radiosity_ON = 1)
background {color rgbt 1}
#else
light_source{<0 , 20.0 ,400.0>color White*0.2 shadowless} // flash
light_source{ <35, 15 ,-70>color White*0.9 shadowless} // flash 2
sky_sphere{
 pigment{ gradient <0,1,0>
          color_map{
          [0.0 color rgb<1,1,1>        ]
          [0.8 color rgb<0.1,0.25,0.75>]
          [1.0 color rgb<0.1,0.25,0.75>]}
        }
 }
 
plane { <0,1,0>, 0  hollow
       texture{ pigment{ color DarkGreen}
	         normal { bumps 0.25 scale 0.05 }
             
               }
          translate<0,-50,0>
      } // end of plane ------------------------------------------
#end
//objekte
#declare BT = texture {pigment {color rgb 0.2}}
#declare TTrans = texture {pigment{color Clear}}
#declare BalkonPfosten = texture_map{[0.0 T_Wood12][0.6 T_Wood26][0.7 T_Wood12][0.7 TTrans][0.9 BT][1.0 BT]}
#declare HT = texture {pigment {color DarkSlateBlue}}
#declare Wand_Farbe_1 =
texture{ pigment{color MediumSeaGreen*0.8}
         normal {cells 0.2 scale 0.02}
        finish {ambient MediumSeaGreen*0.3}
       }
#declare Fenster5x8_5_L = union {
box {<0.2,0.2,0.05>,<4.8,8.3,0.1> texture {Glass}}
                difference {
                box {<0,0,0>,<5,8.5,0.2>}
                box {<0.2,0.2,-0.1>,<4.8,8.3,0.25>}
                }
                box {<0,6.2,0>,<5,6.4,0.2>}
                box {<2.4,0,0>,<2.6,6.4,0.2>}
box{<0,0,0>,<2.5,8.5,-0.1> rotate y*-2 translate <-2.5,0,0>}
box{<2.5,0,0>,<5,8.5,-0.1> rotate y*2 translate <2.5,0,0>}
    texture{pigment{gradient y color_map{[0 color rgb <.40,.26,.13>]
                                                                [.5 color rgb <.40,.26,.13>]
                                                                [.5 color rgb 0]
                                                                [.7 color rgb 0]
                                                                [.7 color rgb <.40,.26,.13>]
                                                                [1 color rgb <.40,.26,.13>]
                }}
     }
                }
#declare FirstTextur = texture{pigment{ gradient x color_map{ [0.0 color DarkSlateGrey*0.4][0.9 color DarkSlateGrey][0.9 color rgb 0.2][1.0 color rgb 0.2]}}scale 2 finish{ambient 0}}
#declare Haus_Roh =
union{
difference {
union{
box {<0,0,0>,<70,22,50>}
prism{0,0.5,4,
        <0,0>,
        <25,25>,
        <0,50>,
        <0,0>
        rotate z*90 translate <0.5,22,0>}
        
prism{0,0.5,4,
        <0,0>,
        <25,25>,
        <0,50>,
        <0,0>
        rotate z*90 translate <70,22,0>}
        
    }
//Innenraum
box {<0.5,0.5,0.5>,<69.5,23,49.5>}
//Fensteraussparungen EG
box {<0,0,0>,<5,8.5,1> translate <10,4,-0.2>}
box {<0,0,0>,<5,8.5,1> translate <32.75,4,-0.2>}
box {<0,0,0>,<5,8.5,1> translate <55,4,-0.2>}
//Fensteraussparungen links
box {<0,0,0>,<1,8.5,5> translate <-0.2,4,12>}
box {<0,0,0>,<1,8.5,5> translate <-0.2,4,33>}
//1.            
box {<0,0,0>,<1,8.5,5> translate <-0.4,22,12>}
box {<0,0,0>,<1,8.5,5> translate <-0.4,22,33>}

//Fensteraussparungen rechts
box {<0,0,0>,<1,8.5,5> translate <69.2,4,12>}
box {<0,0,0>,<1,8.5,5> translate <69.2,4,33>}
//1.            8.5
box {<0,0,0>,<1,8.5,5> translate <69.4,22,12>}
box {<0,0,0>,<1,8.5,5> translate <69.4,22,33>}
//Fensteraussparungen EG-R
box {<0,0,49>,<5,8.5,50> translate <10,4,0.2>}
box {<0,0,49>,<7,10,50> translate <32,0.5,0.2>}
box {<0,0,49>,<5,8.5,50> translate <55,4,0.2>}
}
//Ziersockel unten
box {<-0.3,-0.05,-0.3>,<70.3,0.7,50.3> texture {T_Stone31 scale 0.05}}
//Ziersockel EG -> 1.
box {<-0.3,16.3,-0.3>,<70.3,16.7,50.3> texture {Wand_Farbe_1}}
box {<-0.5,16.7,-0.5>,<70.5,16.9,50.5> texture {Wand_Farbe_1}}
box {<-0.7,16.9,-0.7>,<70.7,17.2,50.7> texture {FirstTextur}}
 texture {Wand_Farbe_1}
 }
#declare Giebel = prism {0,1,4,<0,0>,<12,0>,<6,5>,<0,0>}
#declare Balkon = union{
box {<0,0,0>,<15,0.1,2> pigment {color NewTan*0.5}}
box {<0,0,1.9>,<15,5,2> texture{gradient x texture_map{BalkonPfosten}}}
box {<0,0,0>,<0.1,5,2> texture{gradient z texture_map{BalkonPfosten}}}
box {<14.9,0,0>,<15,5,2> texture{gradient z texture_map{BalkonPfosten}}}
}
#declare WDR = cylinder {<0,0,0>,<70,0,0>,0.5 texture {T_Brass_1A}}
#declare SDR = cylinder {<0,0,0>,<0,23,0>,0.4 texture {T_Brass_1A}}
#declare Zaun_Saeule = box{<0,0,0>,<1.5,6.5,1.5> texture{T_Stone28 scale 0.7} texture{pigment{brick 
                White*0.2
                Clear
                brick_size <2,0.75,0.65>
                mortar 0.15}
                normal {wrinkles 0.75}}
                }
#declare Zaun_Pfosten = box{<-0.2,0,-0.1>,<0.2,6,0.1> texture {T_Wood2}}
#declare Zaun_Pfosten_Z = box{<-0.1,0,-0.2>,<0.1,6,0.2> texture {T_Wood2}}
//Szene=============================================================================================================
union{
union{
object {Haus_Roh}
difference{
prism{0,75,4,
		<0,0>,
		<0,60>,
		<30,30>,
		<0,0>}

prism{0,77,4,
		<0,0.2>,
		<0,59.8>,
		<29.8,30>,
		<0,0.2> translate<-.1,-1,0>}
rotate z*90 translate<72.5,17.1,-5> pigment{image_map{png "dachziegel_grau.png" map_type 0 interpolate 2} scale <20,20,20>}}
 translate <20,0,-75>}
//Fenster EG
object {Fenster5x8_5_L translate <30,4,-75>}
object {Fenster5x8_5_L translate <52.75,4,-75>}
object {Fenster5x8_5_L translate <75,4,-75>}
//Fenster EG-R
object {Fenster5x8_5_L rotate <0,180,0> translate <35,4,-25.2>}
object {Fenster5x8_5_L rotate <0,180,0> translate <80,4,-25.2>}
//Fenster EG-links
object {Fenster5x8_5_L rotate <0,90,0> translate <20,4,-58>}
object {Fenster5x8_5_L rotate <0,90,0> translate <20,4,-37>}
//Fenster 1-links
object {Fenster5x8_5_L rotate <0,90,0> translate <20,22,-58>}
object {Fenster5x8_5_L rotate <0,90,0> translate <20,22,-37>}
//Fenster EG-rechts
object {Fenster5x8_5_L rotate <0,-90,0> translate <90,4,-63>}
object {Fenster5x8_5_L rotate <0,-90,0> translate <90,4,-42>}
//Fenster 1-rechts
object {Fenster5x8_5_L rotate <0,-90,0> translate <90,22,-63>}
object {Fenster5x8_5_L rotate <0,-90,0> translate <90,22,-42>}
//Haustür
union{
difference{
box {<0,0,0.5>,<7,10,0.8> texture{T_Wood2  rotate x*90 scale 2}}
box {<2.8,2,0.4>,<4.2,8,0.9> texture{NBoldglass}}
}
sphere {<0,0,0>,0.35 translate <0.4,4.5,0.5> texture{T_Copper_2A}}
cylinder{<0,0,0>,<1,0,0>,0.29 translate <0.3,4.5,0.5> texture{T_Brass_1A}}
prism {0,9,4
        <0,0>,
        <4,0>,
        <0,1.5>,
        <0,0> rotate x*-90 rotate y*90 translate <8,10,0>texture {T_Wood2}}
cylinder {<0,0,0>,<0,0,-2.9>,0.2 rotate x*30 translate <-0.3,9,0> texture {New_Brass}}
cylinder {<0,0,0>,<0,0,-2.9>,0.2 rotate x*30 translate <7.1,9,0> texture {New_Brass}}
rotate y*180
translate <59,0.5,-25>}
//Dachrinnen
object {WDR texture {T_Copper_1A} translate<20,21,-76>}
object {WDR translate<20,17,-80>}
object {SDR translate<43,0,-75.5>}
object {SDR translate<67,0,-75.5>}

object {WDR texture {T_Copper_1A}translate<20,21,-23>}
object {WDR translate<20,16.5,-19>}
object {SDR translate<43,-1,-23>}
object {SDR translate<67,-1,-23>}
//Dachflaechen
//vorne

//Dachfirst
cylinder {<0,0,0>,<72,0,0>,0.5 translate <20,47,-50> texture{FirstTextur}}
//Kamin
object{Kamin_2 translate<50,42,-51>}
//Kunstwerk
intersection{
box {<-0.5,-0.5,-0.5>,< 0.5,0.5,0.5>
     texture{T_Stone18 scale 0.5} }
sphere{<0,0,0>,0.66
     texture{T_Stone21} }
cylinder{<0,0,-1>,<0,0,1>,0.3 inverse
  texture{pigment{color YellowGreen}
          finish {phong 0.5}}}
cylinder{<0,-1,0>,<0,1,0>,0.3 inverse
  texture{pigment{color YellowGreen}
          finish {phong 0.5}}}
cylinder{<-1,0,0>,<1,0,0>,0.3 inverse
  texture{pigment{color YellowGreen}
          finish {phong 0.5}}}
scale 5 translate <65,0,-40>}
intersection{
box {<-0.5,-0.5,-0.5>,< 0.5,0.5,0.5>
     texture{T_Stone18 scale 0.5} }
sphere{<0,0,0>,0.66
     texture{T_Stone21} }
cylinder{<0,0,-1>,<0,0,1>,0.3 inverse
  texture{pigment{color YellowGreen}
          finish {phong 0.5}}}
cylinder{<0,-1,0>,<0,1,0>,0.3 inverse
  texture{pigment{color YellowGreen}
          finish {phong 0.5}}}
cylinder{<-1,0,0>,<1,0,0>,0.3 inverse
  texture{pigment{color YellowGreen}
          finish {phong 0.5}}}
scale 5 rotate y*27 translate <70,0,-28>}
//Kiesfläche
box {<20,-0.1,-14>,<65,0.05,-60>texture{ pigment{image_map{jpeg "kies_grob.jpg" map_type 0 interpolate 2} rotate x*90 scale <10,1,10>}
                 finish { diffuse 0.9}
               } }
//Bäume

#include "eiche.inc"
 #declare Rinde = 
 texture{ pigment{ color rgb< 0.70, 0.56, 0.43>*0.65 } 
	normal { bumps 1.00 scale <0.025,0.075,0.025> }
          finish { phong 0.2 reflection 0.00}         
        } // end of texture 
//-------------------------------------------------------- 
#declare Blaetter_1 = 
 texture{ pigment{ color rgb< .31, .57, .25>*0.9}   
          normal { bumps 0.15 scale 0.05 }
          finish {ambient 0.1 diffuse 0.9 phong 0.9}
        }
#declare Blaetter_2 = 
 texture{ pigment{  color rgbf< 0.2, 0.5, 0.0, 0.2>*0.25}   
          normal { bumps 0.15 scale 0.05 }
          finish {ambient 0.1 diffuse 0.9 phong 0.9}
        }
 union { object { eiche_13_stems texture{Rinde}}
         object { eiche_13_leaves  double_illuminate
                  texture{ Blaetter_1 }   
                  interior_texture{ Blaetter_2 }}
         scale 3 rotate y*37 translate <27,0,-55>}
#include "trauerweide.inc"
#declare Blaetter_3 = 
 texture{ pigment{ color rgbf< .16, .27,0,.3>*1}   
          normal { bumps 0.15 scale 0.05 }
          finish {ambient 0.1 diffuse 0.9 phong 0.9}
        }
#declare Blaetter_4 = 
 texture{ pigment{  color rgbf< .11,.19,0, 0.4>*1.05}   
          normal { bumps 0.15 scale 0.05 }
          finish {phong 0.9}
        }
#include "black_oak_2.inc"        
union { object { weeping_willow_13_stems texture{Rinde}}
         object { weeping_willow_13_leaves  double_illuminate
                  texture{ Blaetter_3 }   
                  interior_texture{ Blaetter_4 }}
         rotate y*37 translate<60,0,-62>}
union { object { weeping_willow_13_stems texture{Rinde}}
         object { weeping_willow_13_leaves  double_illuminate
                  texture{ Blaetter_3 }   
                  interior_texture{ Blaetter_4 }}
         scale 3 rotate y*37 translate <5,0,-31>}
union { object { black_oak_2_13_stems texture{Rinde}}
         object { black_oak_2_13_leaves  double_illuminate
                  texture{ Blaetter_4 }   
                  interior_texture{ Blaetter_3 }}
         scale 3 rotate y*54 translate<10,0,-122>}

union { object { black_oak_2_13_stems texture{Rinde}}
         object { black_oak_2_13_leaves  double_illuminate
                  texture{ Blaetter_4 }   
                  interior_texture{ Blaetter_3 }}
         scale 5 rotate y*54 translate<90,0,-118>}
union { object { eiche_13_stems texture{Rinde}}
         object { eiche_13_leaves  double_illuminate
                  texture{ Blaetter_4 }   
                  interior_texture{ Blaetter_3 }}
         scale 4 rotate y*5 translate<60,0,-125>}
union { object { black_oak_2_13_stems texture{Rinde}}
         object { black_oak_2_13_leaves  double_illuminate
                  texture{ Blaetter_4 }   
                  interior_texture{ Blaetter_3 }}
         scale 4 rotate y*5 translate<0,0,-80>}
union { object { black_oak_2_13_stems texture{Rinde}}
         object { black_oak_2_13_leaves  double_illuminate
                  texture{ Blaetter_4 }   
                  interior_texture{ Blaetter_3 }}
         scale 4 rotate y*5 translate<95,0,-85>}
//Kirschbaum
#declare BOZO1 = pigment {
	bozo
	color_map {
		[0  color rgbf<.16,.27,0,.3>*1]
		[1  color rgbf<.31,.57,.25,.1>*0.9]
	}
	scale 0.04
}
#declare BOZO2 = pigment {
	bozo
	color_map {
		[0 color rgbf< 0.2, 0.5, 0.0, 0.2>*0.25]
		[1 color rgb<0.17, 0.58, 0.0>*0.5]
	}
	scale 0.04
}

#declare LAUB = texture {
	pigment {
		gradient y
		cubic_wave
		turbulence 0.0
		omega 0.0
		pigment_map {
			[0.0 BOZO1]
			[1 BOZO2]
		}
		scale 1006.7368
	}
	finish {
		phong 0.4*0.0 phong_size 20*0.0
	}
}
 #include "kirsche_wood.inc"
#include "kirsche_foliage.inc"
#include "kirsche_blossom.inc"

union {
object{FOLIAGE texture{LAUB}}
object{BLOSSOM texture{pigment{color rgb 1}}}

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
scale 30
translate<10,0,-42>
}
union {
object{FOLIAGE texture{LAUB}}
object{BLOSSOM texture{pigment{color rgb 1}}}

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
scale 25
translate <37,0,-91>
}
union {
object{FOLIAGE texture{LAUB}}
object{BLOSSOM texture{pigment{color rgb 1}}}

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
scale 22
 translate<10,0,-38>
}
union {
object{FOLIAGE texture{LAUB}}
object{BLOSSOM texture{pigment{color rgb 1}}}

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
scale 22
 translate<40,0,-68>
}
//Bodenplatte
object {bodenplatte texture { pigment{ image_map { jpeg "grasstex1.jpg" map_type 0 interpolate 2}} rotate x*90 scale 15 finish {ambient 0}}}

#declare Richtung = 3;
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
