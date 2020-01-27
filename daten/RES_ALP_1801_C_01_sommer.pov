// PoVRay 3.7
// author: daniel_martin@gmx.at
#version 3.7; // 3.6
#declare Radiosity_ON = 1; 
#if (Radiosity_ON = 1 )
global_settings{
  ambient_light 1
  assumed_gamma 1.0
   photons
   { count 20000
     media 100}
  radiosity {
         // pretrace_start 1
         // pretrace_end 1
          //adc_bailout 2
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
#include "Roof_0.inc"


#declare Camera_0 = camera{ orthographic
													location<100, 81.4, -100>  
													look_at<0, 0, 0>}
#declare Camera_1 = camera {perspective angle 90// rueckseite
                            location <80 ,15.0 ,10>
                            look_at <80 ,15,0>}
#declare Camera_2 = camera {perspective angle 90//rechts
                            location  <100 ,15 ,-40>
                            right x*image_width/image_height
							look_at <0,15,-40>}
#declare Camera_3 = camera { perspective angle 90//links
                            location <-40 ,20,-100>
                            right x*image_width/image_height
							look_at <0,15,-100>}

#declare Camera_4 = camera {perspective angle 90// oben
                            location <35 , 65 ,-25>
                            right x*image_width/image_height
                            look_at <36, 0.0 ,-25>}
#declare Camera_5 = camera {perspective angle 90// vorne
                            location <44,14,-144>
                            right x*image_width/image_height
							look_at <41,12,0>}
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
//====Texturen================================================================================
#declare Hausfarbe_r = texture{pigment{bozo color_map{ [0 color rgb .98][1 color rgb .6]} scale <0.5,1,0.8>}normal{agate 0.1}}
#declare Hausfarbe_l = texture{pigment{color rgb 0.99 }normal{granite 1 scale 0.25}}
#declare Ziegeltextur_r = texture{pigment{gradient x 
           color_map{[0.00 color rgb<0.51,0.41,0.33>*0.2 ]
                     [0.90 color rgb<0.51,0.41,0.33>*0.1 ]
                     [0.90 color rgb 0.2]
                     [0.95 color rgb 0]
                     [1.00 color rgb 0]}
                    scale 2 }}
#declare Ziegeltextur_l = texture{pigment{gradient x 
           color_map{[0.00 color rgb 0.51*0.4 ]
                     [0.90 color rgb 0.51*0.4 ]
                     [0.90 color rgb 0.51*0.1]
                     [0.95 color rgb 0.51*0.1]
                     [0.95 color rgb 0]
                     [1.00 color rgb 0]}
                    scale 3 }}
#declare TTrans = texture {pigment{color Clear}}
#declare BT = texture {pigment {color rgb 0.2}}
#declare Fensterfarbe = texture {pigment {color rgb 1*0.8} finish{ambient 0.2 phong 0.5}}
#declare Boxtextur = texture{pigment{color Clear}}
#declare BalkonPfosten = texture_map{[0.0 T_Wood12][0.6 T_Wood26][0.7 T_Wood12][0.7 TTrans][0.9 BT][1.0 BT]}
#declare Blechdachtex = texture{pigment{ color rgb <.65,.16,.16>*0.5} normal{bumps 0.1 scale 0.9} finish{metallic specular 0.8 roughness 1/20 reflection 0.02}}
//====OBEKTE=================================================================================
#declare haus = difference{
box{<0,0,0>,<41,13,56>}
box{<0.5,0.2,0.5>,<40.5,14,55.5> pigment{color White}}
//Front
object{Fenster_AS_5x5 translate <7.5,5,-0.1>}
object{Fenster_AS_5x5 translate <18,5,-0.1>}
object{Fenster_AS_5x5 translate <28.5,5,-0.1>}
//Hinten
object{Fenster_AS_5x5 translate <7.5,5,55.3>}
object{Fenster_AS_5x5 translate <18,5,55.3>}
object{Fenster_AS_5x5 translate <28,5,55.3>}
//Türseite
object{Haust_AS_6_10 rotate y*90 translate<-.1,0.05,33>}
object{Fenster_AS_5x5 rotate y*90 translate <-.1,5,13>}
object{Fenster_AS_5x5 rotate y*90 translate <-.1,5,24>}
object{Fenster_AS_5x5 rotate y*90 translate <-.1,5,41>}
object{Fenster_AS_5x5 rotate y*90 translate <-.1,5,51>}
//Längsseite
object{Fenster_AS_5x5 rotate y*90 translate <40.4,5,13>}
object{Fenster_AS_5x5 rotate y*90 translate <40.4,5,24>}
object{Fenster_AS_5x5 rotate y*90 translate <40.4,5,32>}
object{Fenster_AS_5x5 rotate y*90 translate <40.4,5,41>}
object{Fenster_AS_5x5 rotate y*90 translate <40.4,5,51>}
}
#declare Stall = difference{
box{<0,0,0>,<30,13,30>}
box{<0.5,0.2,0.5>,<29.5,14,29.5> pigment{color rgb 0.5}}
//Front
object{Fenster_AS_5x5 translate <18,5,-0.1>}
box{<0,0,0>,<11,11,0.6> translate <2,0.2,-0.1>}
//Türseite
object{Fenster_AS_5x5 rotate y*90 translate <-.1,5,13>}
object{Fenster_AS_5x5 rotate y*90 translate <-.1,5,24>}
object{Fenster_AS_5x5 rotate y*90 translate <-.1,5,41>}
object{Fenster_AS_5x5 rotate y*90 translate <-.1,5,51>}
//Längsseite
object{Fenster_AS_5x5 rotate y*90 translate <29.4,5,13>}
object{Fenster_AS_5x5 rotate y*90 translate <29.4,5,24>}
}
#declare Zaunlatte_1 = union {
box{<0,0,0>,<0.5,6,0.1>}
cylinder{<0,0,0>,<0,0,0.1>,0.3 translate <.25,6,0>}
texture{T_Wood6}}

#declare Dach = union{
difference {prism{0,58,4,<0,0>,<43,0>,<21.5,10>,<0,0>} prism{-0.2,58.2,4,<0,0>,<43,0>,<21.5,10>,<0,0> translate z*-0.3}}
//links
	union{
box{<0,0,0>,<23.7,0.1,0.2> rotate y*24.94 translate <21.5,0.2,10>}
box{<0,0,0>,<23.7,0.1,0.2> rotate y*24.94 translate <21.5,7,10>}
box{<0,0,0>,<23.7,0.1,0.2> rotate y*24.94 translate <21.5,14,10>}
box{<0,0,0>,<23.7,0.1,0.2> rotate y*24.94 translate <21.5,21,10>}
box{<0,0,0>,<23.7,0.1,0.2> rotate y*24.94 translate <21.5,28,10>}
box{<0,0,0>,<23.7,0.1,0.2> rotate y*24.94 translate <21.5,35,10>}
box{<0,0,0>,<23.7,0.1,0.2> rotate y*24.94 translate <21.5,42,10>}
box{<0,0,0>,<23.7,0.1,0.2> rotate y*24.94 translate <21.5,49,10>}
box{<0,0,0>,<23.7,0.1,0.2> rotate y*24.94 translate <21.5,57.7,10>}
//falze rechts
box{<0,0,0>,<-23.7,0.1,0.2> rotate y*-24.94 translate <21.5,0.2,10>}
box{<0,0,0>,<-23.7,0.1,0.2> rotate y*-24.94 translate <21.5,7,10>}
box{<0,0,0>,<-23.7,0.1,0.2> rotate y*-24.94 translate <21.5,14,10>}
box{<0,0,0>,<-23.7,0.1,0.2> rotate y*-24.94 translate <21.5,21,10>}
box{<0,0,0>,<-23.7,0.1,0.2> rotate y*-24.94 translate <21.5,28,10>}
box{<0,0,0>,<-23.7,0.1,0.2> rotate y*-24.94 translate <21.5,35,10>}
box{<0,0,0>,<-23.7,0.1,0.2> rotate y*-24.94 translate <21.5,42,10>}
box{<0,0,0>,<-23.7,0.1,0.2> rotate y*-24.94 translate <21.5,49,10>}
box{<0,0,0>,<-23.7,0.1,0.2> rotate y*-24.94 translate <21.5,57.7,10>}
//Giebelfalz
box{<0,0,0>,<0.1,58,0.2> translate <21.45,0,10.1>}
	texture{T_Brass_1A}}
texture{Blechdachtex}}
#declare dachfenster =
union{
      object{Fenster4x5 pigment{color rgb 1}}
      prism{0,0.5,4,<0,0>,<5,0>,<2.5,2>,<0,0> rotate x*-90 translate<-0.5,5,0.5>}
      difference{
      prism{0,14,4,<0,0>,<6,0>,<3,2>,<0,0>}
      prism{0,15.5,4,<0,0>,<6,0>,<3,2>,<0,0> translate <0,-1,-0.2>}
       rotate x*-90 translate<-1,5,13.7> texture{pigment{ color rgb <.65,.16,.16>*0.5} normal{bumps 0.1 scale 0.9} finish{metallic specular 0.8 roughness 1/20 reflection 0.02}}}
       
      box{<0,0,0>,<-0.5,5,14>}
      box{<4,0,0>,<4.5,5,14>}
      box{<-0.5,0,0>,<4.5,-0.5,7>}
texture{pigment{ color rgb <.65,.16,.16>*0.5} normal{bumps 0.1 scale 0.9} finish{metallic specular 0.8 roughness 1/20 reflection 0.02}}}
#declare Fenstergitter = union{
cylinder{<0,0,0>,<0,5,0>,0.1 translate <2.4,0,0>}
cylinder{<0,0,0>,<5,0,0>,0.1 translate<0,1.5,0>}
cylinder{<0,0,0>,<5,0,0>,0.1 translate<0,3.5,0>}
texture{Rust}
}
//====SZENE==================================================================================
union{
 
 union{
object{haus}
prism{0,0.5,4,<0,0>,<41,0>,<20.5,10>,<0,0> rotate x*-90 translate<0,12.9,0>}
prism{0,0.5,4,<0,0>,<41,0>,<20.5,10>,<0,0> rotate x*-90 translate<0,12.9,56>}
object{Haustuer_6_10 rotate y*90 translate<.1,0.05,33>}
object{Fenster5x5L rotate x*-90 rotate y*90 translate<.15,7.5,10.5>}
object{Fenster5x5L rotate x*-90 rotate y*90 translate<.15,7.5,21.5>}
object{Fenster5x5L rotate x*-90 rotate y*90 translate<.15,7.5,38.5>}
object{Fenster5x5L rotate x*-90 rotate y*90 translate<.15,7.5,48.5>}
//=============
object{Fenster5x5L rotate x*-90 rotate y*-90 translate<40.9,7.5,10.5>}
object{Fenster5x5L rotate x*-90 rotate y*-90 translate<40.9,7.5,21.5>}
object{Fenster5x5L rotate x*-90 rotate y*-90 translate<40.9,7.5,29.5>}
object{Fenster5x5L rotate x*-90 rotate y*-90 translate<40.9,7.5,38.5>}
object{Fenster5x5L rotate x*-90 rotate y*-90 translate<40.9,7.5,48.5>}
//=============
object{Fenster5x5L rotate x*-90 translate<10,7.5,0.1>}
object{Fenster5x5L rotate x*-90 translate<20.5,7.5,0.1>}
object{Fenster5x5L rotate x*-90 translate<31,7.5,0.1>}
//=============
object{Fenster5x5L rotate x*-90 rotate y*180 translate<10,7.5,55.9>}
object{Fenster5x5L rotate x*-90 rotate y*180 translate<20.5,7.5,55.9>}
object{Fenster5x5L rotate x*-90 rotate y*180 translate<30.5,7.5,55.9>}
//=============
object{dachfenster rotate y*-90 translate<37,15,10>}
object{dachfenster rotate y*-90 translate<37,15,30>}
object{dachfenster rotate y*90 translate<3,15,14>}
object{dachfenster rotate y*90 translate<3,15,41>}
//object{Haustuer_7_11 translate <20,.05,.05>}
object{Dach rotate x*-90 translate <-1,13,56+1>}
object{Kamin_2 translate<14,16,19>}
object{Kamin_1 translate<25,16,39>}
object{DachRinneWaagrecht(56,.4) rotate y*90 translate<-1.2,12.8,55>}
object{DachRinneWaagrecht(56,.4) rotate y*90 translate<41.8,12.8,55>}
cylinder{<0,0,0>,<0,13,0>,0.3 translate<41.5,0,-.7> texture{T_Copper_1A}}
translate <10,0,-133>
texture{Hausfarbe_r}}
object{Regenwasserfass scale 0.9 translate<52,0,-102>}
object{Regenwasserfass scale 0.9 translate<52,0,-98>}
object{Regenwasserfass scale 0.9 translate<52,0,-94>}
object{Regenwasserfass scale 0.9 translate<56,0,-98>}
object{Regenwasserfass scale 0.9 translate<56,0,-94>}
object{Plumpsklo texture{T_Wood12 scale 0.5} rotate y*12 translate<-10,0,-50>}
//Karnickelverschlag=============================
union{
difference{
box{<0,0,-20>,<10,4,-22>}
box{<-1,4,-19.5>,<11,8,-23> rotate x*7 translate <0,-1,0>}
 texture{gradient x texture_map{BalkonPfosten}}}
box{<-1.5,4,-19.5>,<10.5,4.4,-23> rotate x*7 translate <0,-3,0> texture{gradient x texture_map{
//[0.0 T_Stone17][0.7 T_Stone17][0.7 T_Stone8][0.9 BT][1.0 BT]}}}
[0.0 T_Wood2][0.7 T_Wood2][0.7 T_Wood15][0.9 BT][1.0 BT]}}}
rotate <0,180,0> translate <12,0,-43>}
//Brunnen
object{Brunnen translate <-15,-5,-80>}
//Gemuesebeet
union{
height_field{png "dirtwall_snow.png" smooth scale <70,1,20>}
cylinder{<0,0,0>,<70,0,0>,0.3 translate <0,.7,0>}
cylinder{<0,0,0>,<70,0,0>,0.3 translate <0,.7,20>}
cylinder{<0,0,0>,<0,0,20>,0.3 translate <0,.7,0>}
cylinder{<0,0,0>,<0,0,20>,0.3 translate <70,.7,0>}
 translate <10,-.7,-55>
texture{ pigment{bozo turbulence 0.3 color_map{[0.0 color rgb <0.4,0.26,0.13>*0.5][0.5 color rgb <0.2,0.13,0.07>*0.2][1 color rgb <0.18,0.12,0.06>*0.5]} }normal { bozo 3 scale 0.05} finish { diffuse 0.9}}
 }
 //Dass grünzeugs auf dem feld
 box {<0,0,0>,<69,0.1,19> translate <10,0,-55> pigment{image_map{png "ackerfruechte_gruen"} rotate x*90 scale <69,1,19>}}
 //Stall
 union{
 object{Stall texture{Hausfarbe_l}}
        prism{0,29,5,
		<0,0>,
		<30,0>,
		<30,8>,
		<25,8>,
		<0,0> rotate x*-90 translate <0,13,29.5>
		 texture{pigment{ color rgb <.65,.16,.16>*0.5} normal{bumps 0.1 scale 0.9} finish{metallic specular 0.8 roughness 1/20 reflection 0.02}}}
		prism{0,0.5,5,
		<0,0>,
		<30,0>,
		<30,8>,
		<25,8>,
		<0,0> rotate x*-90 translate <0,13,0.5> texture {Hausfarbe_l}}
        prism{0,0.5,5,
		<0,0>,
		<30,0>,
		<30,8>,
		<25,8>,
		<0,0> rotate x*-90 translate <0,13,30> texture {Hausfarbe_l}}
		box{<0,0,0>,<5.5,11,0.1> rotate y*-5 translate <2,0.2,0.2> texture{ gradient x texture_map{BalkonPfosten}}}
		box{<0,0,0>,<5.5,11,0.1> rotate y*8 translate <7.5,0.2,0.9> texture{ gradient x texture_map{BalkonPfosten}}}
		object{Fenstergitter translate <18,5,0.1>}
		object{Fenstergitter rotate y*90 translate <29.4,5,13>}
        object{Fenstergitter rotate y*90 translate <29.4,5,24>}
		box{<0,0,0>,<-1,0.2,30> translate <0,13,0> texture {T_Wood26}}
		box{<0,0,0>,<2,0.2,30> translate <30,21,0> texture {T_Wood26}}
		translate <69,0,-90>
  }
 //Gehweg
 box{<0,0,0>,<6,0.05,28> translate<-8,0,-134> texture{pigment{image_map{png "dirtwall.png" map_type 0 interpolate 2}rotate x*90}scale 10}}
 box{<0,0,0>,<20,0.05,7> translate<-6,0,-106> texture{pigment{image_map{png "dirtwall.png" map_type 0 interpolate 2}rotate x*90}scale 10}}
 //Kiesfläche vor dem Stall
 box{<0,0,0>,<49,0.05,44> translate<51,0,-134> texture{pigment{image_map{jpeg "kies_grob.jpg" interpolate 2}rotate x*90}scale 5}}
 //Holzstämme davor
 union{
 cylinder{<0,0,0>,<0,0,10>,0.4 texture{T_Wood15}}
 cylinder{<0,0,0>,<0,0,10>,0.4 translate <-0.8,0,0>texture{T_Wood15}}
 cylinder{<0,0,0>,<0,0,10>,0.4 translate <-1.6,0,0>texture{T_Wood15}}
 cylinder{<0,0,0>,<0,0,10>,0.4 translate <-2.45,0,0>texture{T_Wood15}}
 cylinder{<0,0,0>,<0,0,10>,0.4 translate <-3.25,0,0>texture{T_Wood15}}
 cylinder{<0,0,0>,<0,0,10>,0.4 translate <0.8,0,0>texture{T_Wood15}}
 cylinder{<0,0,0>,<0,0,10>,0.4 translate <1.6,0,0>texture{T_Wood15}}
 cylinder{<0,0,0>,<0,0,10>,0.4 translate <2.4,0,0>texture{T_Wood15}}
 cylinder{<0,0,0>,<0,0,10>,0.4 translate <3.25,0,0>texture{T_Wood15}}
 cylinder{<0,0,0>,<0,0,10>,0.4 translate <-0.7,0.8,0>texture{T_Wood15}}
 cylinder{<0,0,0>,<0,0,10>,0.4 translate <0.7,0.8,0>texture{T_Wood15}}
 cylinder{<0,0,0>,<0,0,10>,0.4 translate <1.5,0.8,0>texture{T_Wood15}}
 cylinder{<0,0,0>,<0,0,10>,0.4 translate <2.4,0.8,0>texture{T_Wood15}}
  rotate y*8 translate <90,0.4,-120>}
  //Holz an der Stallwand
  #declare startz = -91;
  #declare startx = 79;
#declare endx = 98;
#while (startx <= endx)
object{holzstoss_basis translate <startx,0,startz>}
#declare startx = startx + 1.2;
#end
#declare startx = 81;
#declare endx = 96;
#while (startx <= endx)
object{holzstoss_basis translate <startx,0.8,startz>}
#declare startx = startx + 1.2;
#end
#declare startx = 83;
#declare endx = 95;
#while (startx <= endx)
object{holzstoss_basis translate <startx,1.6,startz>}
#declare startx = startx + 1.2;
#end
object{Waeschestange rotate y*88 translate <-14,0,-110>}
object{Bank1 rotate y*90 translate<8,0,-120>}
//Misthaufen
height_field{png "kegel_grauschwarz.png" smooth scale <7,2,7> translate<80,0,-23> texture{pigment{image_map{png "Misthaufentextur.png" map_type 0 interpolate 2}}}}
//Bäume
 //Kleine Büsche vor dem Haus
 
 #declare RINDE = texture {
	pigment {
		granite
		cubic_wave
		color_map {
			[0 color rgb <0.35, 0.25, 0.17>]
			[0.35 color rgb <0.49019, 0.34117, 0.21176>]
			[0.5 color rgb <0.49019, 0.34117, 0.21176>*2]
			[0.65 color rgb <0.49019, 0.34117, 0.21176>]
			[1 color rgb <0.35, 0.25, 0.17>]
		}
		scale <1.0, 10.0, 1.0>*3
	}
	finish {
		phong -1.0/5 phong_size 4
	}
}
#declare RINDE1 = texture {
	pigment {
		granite
		cubic_wave
		color_map {
			[0 color rgb <0.35, 0.25, 0.17>]
			[0.35 color rgb <0.0, 1.2, 0.0>/4]
			[0.50 color rgb <0.0, 1.2, 0.0>/2]
			[0.65 color rgb <0.0, 1.2, 0.0>/4]
			[1 color rgb <0.35, 0.25, 0.17>]
		}
		scale <1.0, 10.0, 1.0>*3
	}
	finish {
		phong -1.0/5 phong_size 4
	}
}
 #declare BOZO1 = pigment {
	bozo
	color_map {
		[0  color rgbf< 0.31, 0.36, 0.0, 0.1>*1.0]
		[1 color rgbf< 0.30, 0.35, 0.0, 0.1>*1.0]
	}
	scale 0.04
}
#declare BOZO2 = pigment {
	bozo
	color_map {
		[0 color rgb<0.17, 0.58, 0.0>*0.5]
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
#include "palme.inc"
union {
object{FOLIAGE texture{LAUB}}
object{WOOD
	texture {
		onion
		texture_map {
			[0 RINDE scale <1/571.1, 1/5033.684, 1/571.1>]
			[0.3 RINDE scale <5.253021E-4, 5.9598497E-5, 5.253021E-4>]
			[1 RINDE scale <1.751007E-4, 1.9866166E-5, 1.751007E-4>]
		}
		scale <571.1, 5033.684, 571.1>/817.99994
	}
}
scale <5,2,5>
translate <-7,0,-105>
}
union {
object{FOLIAGE texture{LAUB}}
object{WOOD
	texture {
		onion
		texture_map {
			[0 RINDE scale <1/571.1, 1/5033.684, 1/571.1>]
			[0.3 RINDE scale <5.253021E-4, 5.9598497E-5, 5.253021E-4>]
			[1 RINDE scale <1.751007E-4, 1.9866166E-5, 1.751007E-4>]
		}
		scale <571.1, 5033.684, 571.1>/817.99994
	}
}
scale <5,2,5>
translate <-9,0,-109>
}
union {
object{FOLIAGE texture{LAUB}}
object{WOOD
	texture {
		onion
		texture_map {
			[0 RINDE scale <1/571.1, 1/5033.684, 1/571.1>]
			[0.3 RINDE scale <5.253021E-4, 5.9598497E-5, 5.253021E-4>]
			[1 RINDE scale <1.751007E-4, 1.9866166E-5, 1.751007E-4>]
		}
		scale <571.1, 5033.684, 571.1>/817.99994
	}
}
scale <5,2,5>
translate <-8,0,-114>
}
//Kirschbaum
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
			[0 RINDE scale <1/571.1, 1/5033.684, 1/571.1>]
			[0.3 RINDE scale <5.253021E-4, 5.9598497E-5, 5.253021E-4>]
			[1 RINDE scale <1.751007E-4, 1.9866166E-5, 1.751007E-4>]
		}
		scale <571.1, 5033.684, 571.1>/817.99994
	}
}
scale 20
translate <90,0,-35>
}
//Busch nebem dem haus
#declare Blatt_Textur = 
 texture{ pigment{ color rgbf< 0.31, 0.36, 0.0, 0.1>*1.0 }   
          normal { bumps 0.15 scale 0.05 }
          finish { phong 1 reflection 0.00}
        }
#declare Rinde = 
 texture{ pigment{ color rgb< 0.70, 0.56, 0.43>*0.25 } 
	normal { bumps 1.00 scale <0.025,0.075,0.025> }
          finish { phong 0.2 reflection 0.00}         
        }
#include "eastern_cottonwood.inc"
union {object { eastern_cottonwood_13_stems texture {Rinde} }
         object { eastern_cottonwood_13_leaves texture {Blatt_Textur}}
         translate <-2,0,-98>}
 
 //Bodenplatte
 difference{
object {bodenplatte texture{pigment{image_map{jpeg "grasstex1.jpg" map_type 0 interpolate 2}rotate x*90}scale 10}}
box{<10,-1,-55>,<80,0.1,-35>}
}
//Ende Bodenplatte

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
