// PoVRay 3.7
// author: daniel_martin@gmx.at
#version 3.7; // 3.6
#declare Radiosity_ON =1; 
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
#include "kleinkram.inc"
#include "Taubenschlag_geom.inc"

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
							look_at <0,40,-50>
							}
#declare Camera_3 = camera { perspective angle 90//links
                            location  <-30 , 46 ,-70>
                            right x*image_width/image_height
							look_at <0,38,-70>
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
        } // end pigment
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
texture{ pigment{ bumps turbulence 2 color_map{[0.0 color rgb <.9,.454,0>]
                                                [.3 color rgb <.9,.22,0>*.8]
                                                [1.0 color rgb <.9,.22,0>]

}} finish {ambient 0.3}
       }
#declare FirstTextur = texture{pigment{ gradient x color_map{ [0.0 color DarkSlateGrey*0.4][0.9 color DarkSlateGrey][0.9 color rgb 0.2][1.0 color rgb 0.2]}}scale 2 finish{ambient 0}}
#declare Haus_Roh =
union{
difference {
union{
box {<0,0,0>,<70,44,50>}
prism{0,0.5,4,
        <0,0>,
        <25,25>,
        <0,50>,
        <0,0>
        rotate z*90 translate <0.5,44,0>}
        
prism{0,0.5,4,
        <0,0>,
        <25,25>,
        <0,50>,
        <0,0>
        rotate z*90 translate <70,44,0>}
        
    }
//Innenraum
box {<0.5,0.5,0.5>,<69.5,45,49.5>}
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
//Fensteraussparungen 1
box {<0,0,0>,<5,8.5,1> translate <10,22,-0.2>}
box {<0,0,0>,<5,8.5,1> translate <32.75,22,-0.2>}
box {<0,0,0>,<5,8.5,1> translate <55,22,-0.2>}
//Fensteraussparungen 1 Vorderseite
box {<0,0,49>,<5,8.5,50> translate <10,22,0.2>}
box {<0,0,49>,<5,8.5,50> translate <55,22,0.2>}
//Fensteraussparungen rechts
box {<0,0,0>,<1,8.5,5> translate <69.2,4,12>}
box {<0,0,0>,<1,8.5,5> translate <69.2,4,33>}
//1.
box {<0,0,0>,<1,8.5,5> translate <69.4,22,12>}
box {<0,0,0>,<1,8.5,5> translate <69.4,22,33>}
//Fensteraussparungen EG-R
box {<0,0,49>,<5,8.5,50> translate <10,4,0.2>}
box {<0,0,49>,<7,10,50> translate <32,0.5,0.2>}
box {<0,0,49>,<5,8.5,50> translate <55,4,0.2>}
//2 OG links und rechts
box {<0,0,0>,<2,8.5,5> translate <69.3,43,22>}
box {<0,0,0>,<2,8.5,5> translate <-0.2,43,22>}
}
//Ziersockel unten
box {<-0.3,-0.05,-0.3>,<70.3,0.7,50.3> texture {T_Stone31 scale 0.05}}
//Ziersockel EG -> 1.
box {<-0.3,16.3,-0.3>,<70.3,16.7,50.3> texture {pigment{color rgb <0.89,0.85,0.65>*0.5}}}
box {<-0.5,16.7,-0.5>,<70.5,16.9,50.5> texture {pigment{color rgb <0.89,0.85,0.65>*0.6} normal {bumps 0.5 scale 0.08}}}
box {<-0.7,16.9,-0.7>,<70.7,17.2,50.7> texture {pigment{color rgb <0.89,0.85,0.65>*0.7} normal {bumps 0.5 scale 0.08}}}
 //Ziersockel OG -> 2.
box {<-0.3,36.3,-0.3>,<70.3,36.7,50.3> texture {pigment{color rgb <0.89,0.85,0.65>*0.5}}}
box {<-0.5,36.7,-0.5>,<70.5,36.9,50.5> texture {pigment{color rgb <0.89,0.85,0.65>*0.6} normal {bumps 0.5 scale 0.08}}}
box {<-0.7,36.9,-0.7>,<70.7,37.2,50.7> texture {pigment{color rgb <0.89,0.85,0.65>*0.7} normal {bumps 0.5 scale 0.08}}}
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
#declare SDR = cylinder {<0,0,0>,<0,43,0>,0.4 texture {T_Brass_1A}}
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
object {Haus_Roh translate <20,0,-100>}

//Fenster EG
object {Fenster5x8_5_L translate <30,4,-100> texture{pigment{color rgb <.39,.07,.07>*1.1}}}
object {Fenster5x8_5_L translate <52.75,4,-100> texture{pigment{color rgb <.39,.07,.07>*1.1}}}
object {Fenster5x8_5_L translate <75,4,-100> texture{pigment{color rgb <.39,.07,.07>*1.1}}}
//Fenster EG-R
object {Fenster5x8_5_L rotate <0,180,0> translate <35,4,-50.2> texture{pigment{color rgb <.39,.07,.07>*1.1}}}
object {Fenster5x8_5_L rotate <0,180,0> translate <80,4,-50.2> texture{pigment{color rgb <.39,.07,.07>*1.1}}}
//Fenster EG-links
object {Fenster5x8_5_L rotate <0,90,0> translate <20,4,-83> texture{pigment{color rgb <.39,.07,.07>*1.1}}}
object {Fenster5x8_5_L rotate <0,90,0> translate <20,4,-62> texture{pigment{color rgb <.39,.07,.07>*1.1}}}
//Fenster 1-links
object {Fenster5x8_5_L rotate <0,90,0> translate <20,22,-83> texture{pigment{color rgb <.39,.07,.07>*1.1}}}
object {Fenster5x8_5_L rotate <0,90,0> translate <20,22,-62> texture{pigment{color rgb <.39,.07,.07>*1.1}}}
//Fenster EG-rechts
object {Fenster5x8_5_L rotate <0,-90,0> translate <90,4,-88> texture{pigment{color rgb <.39,.07,.07>*1.1}}}
object {Fenster5x8_5_L rotate <0,-90,0> translate <90,4,-67> texture{pigment{color rgb <.39,.07,.07>*1.1}}}
//Fenster 1-rechts
object {Fenster5x8_5_L rotate <0,-90,0> translate <90,22,-88> texture{pigment{color rgb <.39,.07,.07>*1.1}}}
object {Fenster5x8_5_L rotate <0,-90,0> translate <90,22,-67> texture{pigment{color rgb <.39,.07,.07>*1.1}}}
//Fenster 1
object {Fenster5x8_5_L translate <30,22,-100> texture{pigment{color rgb <.39,.07,.07>*1.1}}}
object {Fenster5x8_5_L translate <52.75,22,-100> texture{pigment{color rgb <.39,.07,.07>*1.1}}}
object {Fenster5x8_5_L translate <75,22,-100> texture{pigment{color rgb <.39,.07,.07>*1.1}}}
//Fenster 1 Vorderseite
object {Fenster5x8_5_L rotate <0,180,0> translate <35,22,-50> texture{pigment{color rgb <.39,.07,.07>*1.1}}}
object {Fenster5x8_5_L rotate <0,180,0> translate <80,22,-50> texture{pigment{color rgb <.39,.07,.07>*1.1}}}
//2.OG links und rechts
object {Fenster5x8_5_L rotate <0,-90,0> translate <90,43,-78> texture{pigment{color rgb <.39,.07,.07>*1.1}}}
object {Fenster5x8_5_L rotate <0,90,0> translate <20,43,-73> texture{pigment{color rgb <.39,.07,.07>*1.1}}}
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
translate <59,0.5,-50>}
//Dachrinnen
object {WDR translate<20,43,-101>}
object {SDR translate<43,0,-100.5>}
object {SDR translate<67,0,-100.5>}

object {WDR translate<20,43,-49>}
object {SDR translate<43,-1,-49>}
object {SDR translate<67,-1,-49>}
//Dachflaechen
//vorne
#declare XL = 19;
#declare endx = 90;
#while (XL <= endx)
object{Dachziegelengobiert (37) rotate x*45 translate <XL,43.4,-101> texture{pigment{gradient y color_map {[0.0 color rgb 1*0.7]
                                                                                                [0.9 color rgb 0.3*0.5]
                                                                                                [0.9 color rgb 0.1]
                                                                                                [1 color rgb 0.1]
                                                                                                }
                                                                                                }scale <1,2,1>}}
#declare XL = XL + 2.8;
#end

//hinten
#declare XLH = 19;
#declare endxLH = 90;

#while (XLH <= endxLH)
object{Dachziegelengobiert (37) rotate x*-45 translate <XLH,43.4,-49> texture{pigment{gradient y color_map {[0.0 color rgb 1*0.7]
                                                                                                [0.9 color rgb 0.3*0.5]
                                                                                                [0.9 color rgb 1]
                                                                                                [1 color rgb 0]
                                                                                                }
 
                                                                                               }}}
#declare XLH = XLH + 2.8;
#end
//Dachfirst
cylinder {<0,0,0>,<72,0,0>,0.5 translate <20,67,-75> texture{FirstTextur}}
//Kamin
object{Kamin_2 translate<50,63,-78>}
object{Kamin_2 translate<50,63,-71>}
object{Zaun_Saeule translate<-20,0,-15>}//linkshinten
object{Zaun_Saeule translate<-20,0,-15>}//linksvorne
object{Zaun_Saeule translate<-20,0,-73>}//linksmitte
object{Zaun_Saeule translate<10,0,-15>}//linksvorne Pfosten
object{Zaun_Saeule translate<98.5,0,-134>}//rechtsvorne
object{Zaun_Saeule translate<98.5,0,-15>}//rechtshinten
object{Zaun_Saeule translate<98.5,0,-73>}//rechtsmitte

#declare zLstart = -132;
#declare zLende = -15;
#while (zLstart <= zLende)
object{Zaun_Pfosten_Z translate <-19.5,0,zLstart>}
#declare zLstart = zLstart + 0.7;
#end
#declare zRstart = -132;
#declare zRende = -15;
#while (zRstart <= zRende)
object{Zaun_Pfosten_Z translate <99.5,0,zRstart>}
#declare zRstart = zRstart + 0.7;
#end
#declare xHstart = 10;
#declare xHende = 100;
#while (xHstart <= xHende)
object{Zaun_Pfosten translate <xHstart,0,-14.8>}
#declare xHstart = xHstart + 0.7;
#end
#declare xVstart =-20;
#declare xVende = 100;
#while (xVstart <= xVende)
object{Zaun_Pfosten translate <xVstart,0,-133.8>}
#declare xVstart = xVstart + 0.7;
#end
//Kisten
object {Waeschestange  scale 2 translate<-5,0,-55>}
//Tisch
object{Table (8,3,5,0.1,0.4) translate<30,0,-45> texture{DMFWood2}}
//Kiesfläche
box {<-19,-0.1,-14>,<99,0.05,-60>texture{ pigment{image_map{jpeg "kies_grob_schnee.jpg" map_type 0 interpolate 2} rotate x*90 scale <10,1,10>}
                 finish { diffuse 0.9}
               } }
//Bäume

#include "birke.inc"

#declare LEAVES=1*BUNCHES;
#declare BOTTOM_COLOR_1=<0.3,0.4,0,0,0>;
#declare BOTTOM_COLOR_2=<0.4,0.5,0,0,0>;
#declare TOP_COLOR_1=<.12,.30,.17,0,0>;
#declare TOP_COLOR_2=<.12, .30,.17,0,0>;

#include "TOMTREE-1.5.inc"
#declare Tree_01 = object{ TREE double_illuminate hollow}
#declare BOZO1 = pigment {
	bozo
	color_map {
		[0 color rgb <.1,.1,.1>]
		[1 color rgb 1*0.4]
	}
	scale 0.04
}
#declare BOZO2 = pigment {
	bozo
	color_map {
		[0 color rgb <1,1,.1>]
		[1 color rgb <0.1,.3,1>*.6]
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
object{ Tree_01
        scale 3.3
        rotate< 90, 45, 0>
        translate< 20, 1.00, -110>
      }
object{ Tree_01
        scale 3.3
        rotate< 90, 45, 0>
        translate< 20, 1.00, -120>
      }
object{ Tree_01
        scale 4  //skalierung 0 
        rotate< 90, 45, 0>
        translate< 20, 1.00, -125>
      }
object{ Tree_01
       scale 30  //skalierung 0 
        rotate< 0, 45, 0>
        translate< 60, 1.00, -125>
      }
object{ Tree_01
       scale 30  //skalierung 0 
        rotate< 0, 45, 0>
        translate< 90, 1.00, -115>
      }

#include "kiefer.inc"
union {
object{FOLIAGE texture{Blaetter_Winter1}}
object{WOOD}
double_illuminate hollow
scale 25
translate <40,0,-120>
}
union {
object{FOLIAGE texture{Blaetter_Winter1}}
object{WOOD}
double_illuminate hollow
scale 28
translate <-10,0,-110>
}
union {
object{FOLIAGE texture{Blaetter_Winter1}}
object{WOOD}
double_illuminate hollow
scale 24
rotate y*45
translate <-10,0,-70>
}
//Taubenschlag
object{Taubenschlag_Taubenschlag_ scale .002 translate <70,0,-20> material{Taubenschlag_}}
//Bodenplatte
object {bodenplatte texture { pigment{ image_map { jpeg "grasstex1_schnee.jpg" map_type 0 interpolate 2}} rotate x*90 scale 15 finish {ambient 0}}}

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
