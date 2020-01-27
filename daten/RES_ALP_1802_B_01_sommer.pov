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
                            location <20 ,15.0 ,0>
                            look_at <20 ,15,-100>}
#declare Camera_2 = camera {perspective angle 90//rechts
                            location  <120 ,10 ,-100>
                            right x*image_width/image_height
							look_at <0,10,-100>}
#declare Camera_3 = camera { perspective angle 90//links
                            location <-30 ,10,-100>
                            right x*image_width/image_height
							look_at <0,5,-101>}

#declare Camera_4 = camera {perspective angle 90// oben
                            location <15 , 65 ,-115>
                            right x*image_width/image_height
                            look_at <16, 0.0 ,-116>}
#declare Camera_5 = camera {perspective angle 90// vorne
                            location <29 ,7,-140>
                            right x*image_width/image_height
							look_at <27,0,0>}
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
#declare Wand_Farbe_1 =texture{ pigment{bozo scale 1.5 turbulence .1 
										color_map{[0.0 color rgb <.3,.65,1>]
												[0.3 color rgb <.3,.65,1>]
												[0.8 color rgb <.25,.55,.85>]
												[1.0 color rgb <.25,.55,.85>]
												}
}
normal{agate 1 agate_turb 0.4 scale 1}}


//Dachtextur
#declare Dachtextur = texture{pigment{image_map{ png "dachziegel_grau.png" map_type 0 interpolate 2}} normal{bump_map{png "dachziegel_grau_bump.png" map_type 0 interpolate 2 bump_size 2}}scale 4}//texture {pigment{color Brown}}
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
#declare Zaunpfosten = union{box{<0,0,0>,<1,5,1>}box{<-0.2,5,-0.2>,<1.2,5.2,1.2>} texture{pigment{brick 
																																												color rgb 0.2
																																												color Scarlet*0.4
																																												brick_size <0.5,0.2,0.5>
																																												mortar 0.08}
																																												normal{agate 1 turbulence 0.5 scale 0.2}}}
#declare Zaunlatte = union{
cylinder{<0,0,0>,<0,3.8,0>,0.1}
cone{<0,3.8,0>,0.2,<0,4.5,0>,0}
texture{T_Chrome_1A}
}
#declare Wandbrett_1 = box {<0,0,0>,<0.1,15,0.8> texture{T_Wood22}}														
#declare WBTex =  texture{pigment{gradient z color_map{[0 color rgb 0.9][0.5 color rgb 0.6][0.95 color rgb 0.6][0.95 color Clear][0.96 color Clear][1 color rgb 0.9][0.96 color rgb .9]}}}
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
   
    
 #declare Gartentor = union{
 cylinder{<0,0,0>,<0,4,0>,0.1 texture{T_Chrome_1B}}
 object{Zaunlatte translate <0.3,0.1,0>}
 object{Zaunlatte translate <1.3,0.1,0>}
 object{Zaunlatte translate <2.3,0.1,0>}
 object{Zaunlatte translate <3.3,0.1,0>}
 object{Zaunlatte translate <4.3,0.1,0>}
 object{Zaunlatte translate <5.3,0.1,0>}
 object{Zaunlatte translate <6.3,0.1,0>}
 object{Zaunlatte translate <7.3,0.1,0>}
 object{Zaunlatte translate <8.3,0.1,0>}
 }
//===========================================================
#declare Haus = difference {
union{
//Grundkörper
box {<0,-0.1,0>,<59.5,19,36.5>}
//Mauern 1.OG li. & re.
prism{0,0.5,5,<0,0>,<14.5,15>,<14.5,21.5>,<0,36.5>,<0,0> rotate z*90 translate<0.5,19,0>}
prism{0,0.5,5,<0,0>,<14.5,15>,<14.5,21.5>,<0,36.5>,<0,0> rotate z*90 translate<59.5,19,0>}
//Mitte 1.OG
// prism{0,0.5,7,<0,0>,<16.5,0>,<16.5,13.5>,<10.5,17>,<6,17>,<0,13.5>,<0,0> rotate x*-90 translate<22.5,19,.5>}
// box{<0,0,0>,<0.5,13.5,12> translate<22.5,19,0>}
//box{<0,0,0>,<0.5,13.5,12> translate<38.5,19,0>}
//Wandbrettln rechts
prism{0,0.5,5,<0,0>,<14.5,15>,<14.5,21.5>,<0,36.5>,<0,0> rotate z*90 translate<59.55,18.5,0> texture{WBTex}}
box{<0,15,0>,<.5,18.5,36.5> translate<59.55,0,0> texture{WBTex}}
}
box {<0.5,0.5,0.5>,<59,19.5,36>}//innenraum
//Fensterloch Vorderseite
object{Fenster_AS_6x6 translate <5,6,-0.1>}
object{Fenster_AS_6x6 translate <15.5,6,-0.1>}
object{Fenster_AS_6x6 translate <38,6,-0.1>}
object{Fenster_AS_6x6 translate <48.5,6,-0.1>}
//object{Fenster_AS_6x6 translate <27.5,22,-0.1>}//1.OG Vorderseite

//Fensterloch Rückseite
object{Fenster_AS_6x6 translate <5,6,35.9>}
object{Fenster_AS_6x6 translate <15.5,6,35.9>}
object{Fenster_AS_6x6 translate <38,6,35.9>}
object{Fenster_AS_6x6 translate <48.5,6,35.9>}
//Fensterloch links
object{Fenster_AS_5x6 rotate y*90 translate <-.2,22,16>}
object{Fenster_AS_5x6 rotate y*90 translate <-.2,22,26>}
//Fensterloch rechts
object{Fenster_AS_5x6 rotate y*90 translate <58.7,22,16>}
object{Fenster_AS_5x6 rotate y*90 translate <58.7,22,26>}
object{Fenster_AS_5x6 rotate y*90 translate <58.7,6,16>}
object{Fenster_AS_5x6 rotate y*90 translate <58.7,6,26>}
//Haustuerloch
object{Haust_AS_7k5_11 translate<27,1,-.1>}
//==============================================Ende difference
}


union{
union{
object {Haus}
//Fenster EG===========================================
object{Fenster6x6_RW translate<5,6,0.15>}
object{Fenster6x6_RW translate<15.4,6,0.15>}
object{Fenster6x6_RW translate<38,6,0.15>}
object{Fenster6x6_RW translate<48.4,6,0.15>}
//object{Fenster6x6_RW translate<27.5,22,0.15>}//1.OG Vorderseite
//Fenster Rückseite
object{Fenster6x6_RW rotate y*180 translate<11.5,6,36.35>}
object{Fenster6x6_RW rotate y*180 translate<21.5,6,36.35>}
object{Fenster6x6_RW rotate y*180 translate<44.5,6,36.35>}
object{Fenster6x6_RW rotate y*180 translate<54.5,6,36.35>}
//Fenster links
object{Fenster5x6_RW rotate y*90 translate<.15,22,16>}
object{Fenster5x6_RW rotate y*90 translate<.15,22,26>}
//Fenster rechts
object{Fenster5x6_RW rotate y*-90 translate<59.35,6,11>}
object{Fenster5x6_RW rotate y*-90 translate<59.35,6,21>}
object{Fenster5x6_L rotate y*-90 translate<59.35,22,11> texture{T_Wood2}}
object{Fenster5x6_L rotate y*-90 translate<59.35,22,21> texture{T_Wood2}}
//Dachflaechen
prism{0,0.2,7,<-1,0>,<60.5,0>,<60.5,20.5>,<58,31>,<1.5,31>,<-1,20.5>,<-1,0> rotate x*-45 translate<0,15.5,-3.5> texture{Dachtextur scale 3}}
prism{0,0.2,7,<-1,0>,<60.5,0>,<60.5,20.5>,<58,31>,<1.5,31>,<-1,20.5>,<-1,0> rotate x*-135 translate<0,15.5,40> texture{Dachtextur  scale 3}}
prism{0,0.2,4,<0,0>,<0,14.5>,<8,7.25>,<0,0> rotate z*71 translate<-1,30,11> texture{Dachtextur scale 3 rotate y*90}}
prism{0,0.2,4,<0,0>,<0,14.5>,<8,7.25>,<0,0> rotate z*108 translate<60.65,30,11> texture{Dachtextur scale 3 rotate y*90}}
//Frontdach
// prism{0,0.2,6,<0,0>,<10.1,0>,<12.7,2.8>,<12.7,20>,<0,13.5>,<0,0>rotate z*31 translate <19.9,30.8,-1.5> texture{Dachtextur scale 3 rotate y*-90}}
// prism{0,0.2,6,<0,0>,<10.1,0>,<12.7,2.8>,<12.7,20>,<0,13.5>,<0,0>rotate z*149 translate <41.6,31,-1.5> texture{Dachtextur scale 3 rotate y*90}}
// prism{0,0.2,4,<0,0>,<4.4,0>,<2.2,2.9>,<0,0> rotate x*-26 translate<28.5,36,-1.4> texture{Dachtextur scale 3}}
//Dachfirste
cylinder{<1.5,0,0>,<58.5,0,0>,0.1 translate<0,37.5,18.25> texture{Firsttextur}}//X
//cylinder{<0,0,0>,<0,0,17>,0.1 translate<30.75,37.5,1> texture{Firsttextur rotate y*90}}//Z
//cylinder{<0,0,0>,<0,0,3.75>,0.1 rotate y*37 rotate x*-26 translate<28.5,36.1,-1.5> texture{Firsttextur rotate y*-45}}//Sattel VL
//cylinder{<0,0,0>,<0,0,3.75>,0.1 rotate y*-37 rotate x*-26 translate<32.9,36.1,-1.5> texture{Firsttextur rotate y*45}}//Sattel VR
//Holzbalken
union{
box{<-1,0,0>,<60.5,0.7,0.7> translate <0,19.2,1>}
box{<-1,0,0>,<60.5,0.7,0.7> translate <0,19.2,34.9>}
box{<-1,0,0>,<60.5,0.7,0.7> translate <0,22.9,5>}
box{<-1,0,0>,<60.5,0.7,0.7> translate <0,22.9,30.9>}
box{<-1,0,0>,<60.5,0.7,0.7> translate <0,27.2,9>}
box{<-1,0,0>,<60.5,0.7,0.7> translate <0,27.2,26.9>}
//box{<0,0,-1>,<0.7,0.7,5> translate<24,32.4,0>}
//box{<0,0,-1>,<0.7,0.7,5> translate<37,32.4,0>}
texture{T_Wood2}
}
//Farbige Hausecken
union{
box{<0,0,0>,<0.8,18,0.8> translate<-0.05,0,-0.05>}
box{<0,0,0>,<0.8,18,0.8> translate<-0.05,0,36.55>}
box{<0,0,0>,<0.8,18,0.8> translate<58.85,0,-0.05>}
box{<0,0,0>,<0.8,18,0.8> translate<58.85,0,35.85>}
texture{pigment{color rgb <1,.87,.68>}}
}
//Haustür
object{Haustuer_7k5_11 translate<27,1,0> texture{T_Wood22}}
//====KLEINKRAM
//Treppenstufen
box{<0,0,0>,<8.5,0.5,1> translate<26.5,0,-1> texture{T_Grnt9 scale 0.5}}
box{<0,0,0>,<8,0.5,0.5> translate<26.25,0.5,-0.5> texture{T_Grnt9 scale 0.5}}
//Treppengeländer Stein
prism{0,1,6,
		<0,0>,
		<3,0>,
		<3,4>,
		<1.5,8>,
		<0,8>,
		<0,0>
		rotate z*90
		rotate x*-90
		translate<26,-1,0>
		texture{T_Stone42} texture{T_Grnt22}}
//Dachluken
union{
difference{box{<0,0,0>,<2,2,1>}box{<0.1,0.1,-0.1>,<1.9,1.9,1.1>}}
box{<0.1,0.1,0.1>,<1.9,1.9,0.2> texture{NBoldglass}}
rotate x*45 translate<10,26,6> texture{T_Brass_1A}}
union{
difference{box{<0,0,0>,<2,2,1>}box{<0.1,0.1,-0.1>,<1.9,1.9,1.1>}}
box{<0.1,0.1,0.1>,<1.9,1.9,0.2> texture{NBoldglass}}
rotate x*45 translate<20,26,6> texture{T_Brass_1A}}
union{
difference{box{<0,0,0>,<2,2,1>}box{<0.1,0.1,-0.1>,<1.9,1.9,1.1>}}
box{<0.1,0.1,0.1>,<1.9,1.9,0.2> texture{NBoldglass}}
rotate x*45 translate<30,26,6> texture{T_Brass_1A}}
union{
difference{box{<0,0,0>,<2,2,1>}box{<0.1,0.1,-0.1>,<1.9,1.9,1.1>}}
box{<0.1,0.1,0.1>,<1.9,1.9,0.2> texture{NBoldglass}}
rotate x*45 translate<47,26,6> texture{T_Brass_1A}}
union{
difference{box{<0,0,0>,<2,2,1>}box{<0.1,0.1,-0.1>,<1.9,1.9,1.1>}}
box{<0.1,0.1,0.1>,<1.9,1.9,0.2> texture{NBoldglass}}
rotate x*-45 translate<10,25,30.5> texture{T_Brass_1A}}
//Dachrinnen
object{WDR translate<0,15.5,-3.8>}
object{WDR translate<0,15.5,40>}
//Kamine
object{Kamin_1 translate <20,30,20>}
object{Kamin_1 translate <40,32,17>}
translate <0,0,-124>
texture {Wand_Farbe_1}}
//Zaun=============================
//Sockel
union{
box{<-20,0,-134>,<27,4,-133>}
box{<34,0,-134>,<80,4,-133>}
box{<-20,0,-80>,<100,4,-79>}
box{<-20,0,-133>,<-19,4,-80>}
box{<99,0,-133>,<100,4,-80>}
texture{heckentex}}
//Pfosten
//Ecken und Eingang
object{Zaunpfosten translate<-20,0,-134>}
object{Zaunpfosten translate<26,0,-134>}
object{Zaunpfosten translate<34,0,-134>}
object{Zaunpfosten translate<99,0,-134>}
object{Zaunpfosten translate<99,0,-80>}
object{Zaunpfosten translate<-20,0,-80>}
//Rest
object{Zaunpfosten translate<-5,0,-134>}
object{Zaunpfosten translate<15,0,-134>}
object{Zaunpfosten translate<45,0,-134>}
object{Zaunpfosten translate<60,0,-134>}
object{Zaunpfosten translate<80,0,-134>}
object{Zaunpfosten translate<-5,0,-80>}
object{Zaunpfosten translate<15,0,-80>}
object{Zaunpfosten translate<30,0,-80>}
object{Zaunpfosten translate<45,0,-80>}
object{Zaunpfosten translate<60,0,-80>}
object{Zaunpfosten translate<80,0,-80>}
//-------
object{Zaunpfosten translate<-20,0,-119>}
object{Zaunpfosten translate<-20,0,-104>}
object{Zaunpfosten translate<99,0,-119>}
object{Zaunpfosten translate<99,0,-104>}
//Latten
#declare startx1 = -20;
#declare endx1 = 26;
#while (startx1 <= endx1)
object{Zaunlatte translate<startx1,1.2,-133.6>}
#declare startx1 = startx1 + 0.7;
#end
#declare startx1 = 35;
#declare endx1 = 80;
#while (startx1 <= endx1)
object{Zaunlatte translate<startx1,1.2,-133.6>}
#declare startx1 = startx1 + 0.7;
#end
#declare startx1 = -20;
#declare endx1 = 100;
#while (startx1 <= endx1)
object{Zaunlatte translate<startx1,1.2,-79.5>}
#declare startx1 = startx1 + 0.7;
#end
#declare startz1 = -133;
#declare endz1 = -80;
#while (startz1 <= endz1)
object{Zaunlatte rotate y*90 translate<-19.5,1.2,startz1>}
#declare startz1 = startz1 + 0.7;
#end
#declare startz1 = -133;
#declare endz1 = -80;
#while (startz1 <= endz1)
object{Zaunlatte rotate y*90 translate<99.5,1.2,startz1>}
#declare startz1 = startz1 + 0.7;
#end
//=================================================
//================Querlatten===========================
//Vorne
cylinder{<0,0,0>,<45,0,0>,0.1 translate <-19,2,-133.6> texture{T_Chrome_1A}}
cylinder{<0,0,0>,<45,0,0>,0.1 translate <-19,3.8,-133.6> texture{T_Chrome_1A}}
cylinder{<0,0,0>,<45,0,0>,0.1 translate <35,2,-133.6> texture{T_Chrome_1A}}
cylinder{<0,0,0>,<45,0,0>,0.1 translate <35,3.8,-133.6> texture{T_Chrome_1A}}
//hinten
cylinder{<-19,0,0>,<99.5,0,0>,0.1 translate <0,2,-79.5> texture{T_Chrome_1A}}
cylinder{<-19,0,0>,<99.5,0,0>,0.1 translate <0,3.8,-79.5> texture{T_Chrome_1A}}
//links
cylinder{<0,0,-79.5>,<0,0,-133.5>,0.1 translate <-19.5,2,0> texture{T_Chrome_1A}}
cylinder{<0,0,-79.5>,<0,0,-133.5>,0.1 translate <-19.5,3.8,0> texture{T_Chrome_1A}}
//rechts
cylinder{<0,0,-79.5>,<0,0,-133.5>,0.1 translate <99.5,2,0> texture{T_Chrome_1A}}
cylinder{<0,0,-79.5>,<0,0,-133.5>,0.1 translate <99.5,3.8,0> texture{T_Chrome_1A}}
//Gartentor
box{<0,-0.1,0>,<10,0.02,12> translate <26,0,-134> texture{pigment{image_map{ png "pflaster_gruen.png" map_type 0 interpolate 2}}scale 4 rotate x*90}}
 object{Gartentor translate <80,0,-133.5>}
 object{Gartentor rotate y*15 translate <90,0,-130.5>}
 //Bank vor dem Haus
box{<0,0,0>,<9,0.1,1> translate<14,2,-125.2> texture{T_Wood21}}
//Schuppen

difference{box{<0,0,0>,<25,15,15>}box{<-0.1,0.2,0.1>,<24.9,16,15.1>}box{<1,0.2,-2>,<24,12,16>} texture{gradient y texture_map{STex}}
translate<70,0,-114>}
//Einfahrt rechts
box {<65,0.01,-130>,<99,0.05,-85> texture{pigment{granite 
color_map{[0 color Brown*0.2][1 color rgb <.40,.26,.13>*0.5]}
}normal {agate 1 scale 1}scale 2}
}
//Blumenbeet rechts
height_field{tga "huegel.tga" smooth scale <10,1.7,10> translate <-13,-0.2,-105> texture{pigment{color rgb <.42,.27,.14>*0.2}}}
torus{5,0.2 translate <-8,0.2,-100> texture{T_Grnt15 normal { pigment_pattern{brick color rgb 0.2, color rgb 0.8 
scale 0.07  turbulence 0.9} 1}}}
//Wäschestange
object{Waeschestange rotate y*90 translate<-8,0,-110>}
object{Waeschestange rotate y*90 translate<-12,0,-110>}
//Gruenzeugs dahinter
height_field{png "grass_hf.png" smooth scale <120,0.6,70> translate <-20,0,-85> texture{pigment{gradient x turbulence 0.5 color_map{[0.0 color rgb <.55,.71,.0>*0.3][0.5 color rgb <.35,.45,.0>*0.5][1.0 color rgb <.55,.71,.0>*0.5]}}}}
//Bäume&Büsche

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
		[0 color rgb <0,0.502,0>]
		//[0 color rgb 1]
		[1 color rgb <0.376,0.349,0.153>]
		//[1 color rgb 0.9]
	}
	scale 0.04
}
#declare BOZO2 = pigment {
	bozo
	color_map {
		[0 color rgb<0.176, 0.349, 0.153>]
		//[0 color rgb<1, 0.9,1>]
		[1 color rgb<0.149, 0.298,0.132>]
		//[1 color rgb<1, 0.98,1>]
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
		scale 597.0447
	}
	finish {
		phong 0.1 phong_size 10*0.1
	}
}
#include "kiefer.inc"
union {
object{FOLIAGE}
object{WOOD}
double_illuminate hollow
scale 20
translate <95,0,-128>
}
//Schwarzeiche
#declare Stem_Texture = 
 texture{ pigment{ color rgb< 0.70, 0.56, 0.43>*0.25 } 
	normal { bumps 1.00 scale <0.025,0.075,0.025> }
          finish { phong 0.2 reflection 0.00}         
        } // end of texture 
//-------------------------------------------------------- 
#declare Leaves_Texture_1 = 
 texture{ pigment{ color rgbf< 0.31, 0.36, 0.0, 0.1>*1.0 }   
          normal { bumps 0.15 scale 0.05 }
          finish { phong 1 reflection 0.00}
        } // end of texture 
//-------------------------------------------------------- 
#declare Leaves_Texture_2 = 
 texture{ pigment{ color rgbf< 0.30, 0.35, 0.0, 0.1>*1.0 }   
          normal { bumps 0.15 scale 0.05 }
          finish { phong 0.2 reflection 0.00}
        } // end of texture 

#include "ca_black_oak_13m.inc"
union{object{ ca_black_oak_13_stems  texture{ Stem_Texture }} object{ ca_black_oak_13_leaves double_illuminate texture{ Leaves_Texture_1 } interior_texture{ Leaves_Texture_2 }}      scale <2,3,2> translate<-8,0,-100>}
//Bodenplatte
object {bodenplatte
texture { pigment{ image_map { png "grass.png" map_type 0 interpolate 2}} rotate <90,0,0> scale 5 finish {ambient 0}}
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
