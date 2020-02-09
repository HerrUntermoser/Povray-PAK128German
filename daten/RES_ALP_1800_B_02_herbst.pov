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
                            location  <120 , 40 ,-60>
                            right x*image_width/image_height
							look_at <0,30,-60>
							}
//==============links============
#declare Camera_3 = camera { perspective angle 90
                            location  <-40 , 40 ,-80>
                            right x*image_width/image_height
							look_at <0,30,-80>
							}
//=========Oben=======
#declare Camera_4 = camera {perspective angle 90
                            location  <50 , 100 ,-70>
                            right     x*image_width/image_height
                            look_at   <50 , 0.0 ,-71>}
//===============Vorderseite===============
#declare Camera_5 = camera {perspective angle 90
                            location  <40 ,40 ,-160>
                            right x*image_width/image_height
							look_at <40,30,0>}
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
plane { <0,1,0>, 0  hollow  pigment{ color DarkSlateGrey } translate<0,-50,0> }
#end
//============OBJEKTE===============================
#declare Giebel = prism {0,1,4,<0,0>,<50,0>,<25,21>,<0,0>}
#declare BT = texture {pigment {color rgb 0}}
#declare HT = texture {pigment {color DarkSlateBlue}}
#declare Lattentexmap = texture_map{[0 DMFDarkOak][.9 DMFDarkOak][.9 BT][1 BT]}
#declare Wand_Farbe_1 =
texture{ pigment{ ripples scale 0.5 turbulence 0.75 color_map{[0 color rgb <.36,.54,.66>][.7 color rgb <.36,.54,.66>*.5][.7 color rgb <.29,.43,.52>][1 color rgb <.29,.43,.52>*.5]} }
         normal {cells .3 scale .03}
        finish {ambient 0.1}
       }
#declare FirstTextur = texture{pigment{ gradient x color_map{ [0.0 color Scarlet*0.4][0.9 color Scarlet][0.9 color rgb 0.2][1.0 color rgb 0.2]}}scale 2 finish{ambient 0}}
#declare TransparenzMuster =pigment{
  image_map{ jpeg "Diag_Grid_03.jpg"
             interpolate 2
           } //
          scale 10
       } 
#declare Pav_Mat = material{  
texture{
    pigment_pattern{ TransparenzMuster}
    texture_map{
     [0.0 pigment{rgbf<1,1,1,1>}]
     [0.5 pigment{rgbf<1,1,1,1>}]
     [1.0 T_Wood2 ]
    } }}
//===============================================
#declare g_beet = union{difference{box {<0,0,0>,<8,1,18>}box {<0.2,0.5,0.2>,<7.8,1.5,17.8>} texture{T_Wood3 scale 0.4 rotate x*90}}box {<0.2,0.5,0.2>,<7.8,0.6,17.8>texture{ pigment{bozo turbulence 0.3 color_map{[0.0 color rgb <0.4,0.26,0.13>*0.5][0.5 color rgb <0.2,0.13,0.07>*0.2][1 color rgb <0.18,0.12,0.06>*0.5]} }normal { bozo 3 scale 0.05} finish { diffuse 0.9}}}
#declare Random_1 = seed (2655);
#declare Random_2 = seed (1153);
//--------------------------------
union{
 // outer loop -------------------
 #declare NrX = 0.5;  // start x
 #declare EndNrX =  3.5;// end   x
 #while (NrX< EndNrX+1)
  // inner loop ------------------
  #declare NrZ = 0.5;     // start z
  #declare EndNrZ =  8; // end   z
  #while (NrZ< EndNrZ+1)

  sphere{ <0,0,0>, 0.25
    texture{ pigment{color DarkGreen}
             finish {phong 0.3}
           } // end of texture
    translate < 2*NrX+1.5*(-0.5+rand(Random_1)),0.7,2*NrZ+1.5*(-0.5+rand(Random_2))>
  } // end of sphere --------------

  #declare NrZ = NrZ + 1; // next Nr z
  #end // -------------- end of loop z
  // end inner loop
 #declare NrX = NrX + 1;  // next Nr x
 #end // --------------- end of loop x
// end of outer loop
}
   }
//===========================================================
#declare Haus_Roh =
union{
difference {
union{
box {<0,0,0>,<70,20,50>}
box {<19.5,27,-0.1>,<50,27.8,50.1> pigment{color NewTan*0.6}}
box {<20,20,0>,<20.5,30,50> texture{gradient z texture_map{Lattentexmap}scale <.8,1,1>}}
box {<49.5,20,0>,<50,30,49.5> texture{gradient z texture_map{Lattentexmap}scale <.8,1,1>}}
prism {0,.5,6,<0,0>,<30,0>,<30,10.5>,<15,21>,<0,10.5>,<0,0> rotate x*-90 translate<20,20,0.5> texture{gradient x texture_map{Lattentexmap}scale <.6,1,1>}}
prism {0,.5,6,<0,0>,<30,0>,<30,10.5>,<15,21>,<0,10.5>,<0,0> rotate x*-90 translate<20,20,49.5> texture{gradient x texture_map{Lattentexmap} scale <.6,1,1>}}
object { Giebel rotate<0,90,90> translate <1,20,50>  texture{gradient z texture_map{Lattentexmap}scale <.7,1,1>}}
object { Giebel rotate<0,90,90> translate <70,20,50>  texture{gradient z texture_map{Lattentexmap}scale <.7,1,1>}}
}
             
//Innenraum
box {<0.5,0.5,0.5>,<69.5,21,49.5>}
//Fensteraussparungen EG
box {<0,0,0>,<5,8.5,1> translate <10,4,-0.2>}
box {<0,0,0>,<5,8.5,1> translate <32.75,4,-0.2>}
box {<0,0,0>,<5,8.5,1> translate <55,4,-0.2>}
//Fensteraussparungen 1.
box {<0,0,0>,<5,8.5,1> translate <32.75,22,-0.4>}
//Fensteraussparungen DG
box {<0,0,0>,<5,8.5,1> translate <32.75,22,-0.2>}
//Fensteraussparungen links
box {<0,0,0>,<1,8.5,5> translate <-0.2,4,12>}
box {<0,0,0>,<1,8.5,5> translate <-0.2,4,33>}
//1.            
box {<0,0,0>,<2,8.5,5> translate <-0.6,22,18>}
box {<0,0,0>,<2,8.5,5> translate <-0.6,22,27>}
//Fensteraussparungen rechts
box {<0,0,0>,<2,8.5,5> translate <69.2,4,12>}
box {<0,0,0>,<2,8.5,5> translate <69.2,4,33>}
//1.            8.5
box {<0,0,0>,<2,8.5,5> translate <69,22,18>}
box {<0,0,0>,<2,8.5,5> translate <69,22,27>}
//Fensteraussparungen EG-R
box {<0,0,49>,<5,8.5,50> translate <10,4,0.2>}
box {<0,0,49>,<7,10,50> translate <32,0.5,0.2>}
box {<0,0,49>,<5,8.5,50> translate <55,4,0.2>}
//Fensteraussparungen DG-R
box {<0,0,49>,<5,8.5,50> translate <32.75,22,0.2>}
}
//Ziersockel unten
box {<-0.3,-0.05,-0.3>,<70.3,0.7,50.3> texture {T_Stone31 scale 0.05}}
//Ziersockel EG -> 1.
box {<-0.3,16.3,-0.3>,<70.3,16.7,50.3> texture {pigment{color NewTan*0.8}}}
box {<-0.5,16.7,-0.5>,<70.5,16.9,50.5> texture {pigment{color NewTan*0.5} normal {bumps 0.5 scale 0.08}}}
box {<-0.7,16.9,-0.7>,<70.7,17.2,50.7> texture {pigment{color NewTan*0.7} normal {bumps 0.5 scale 0.08}}}

 texture {Wand_Farbe_1}
 }


#declare WDR = cylinder {<0,0,0>,<26,0,0>,0.5 texture {T_Brass_1A}}
#declare SDR = cylinder {<0,0,0>,<0,34,0>,0.4 texture {T_Brass_1A}}
#declare Zaun_Saeule = box{<0,0,0>,<1.5,6.5,1.5> texture{T_Stone24} texture{pigment{brick 
                White*0.5
                Clear
                brick_size <2,0.75,0.65>
                mortar 0.15}
                normal {wrinkles 0.75}}
                }
#declare Zaun_Pfosten = union{cylinder{<0,0,0>,<0,6,0>,0.2} sphere{<0,6,0>,0.3} texture {pigment {color rgb 0.01} finish {phong 1}}} 
//Szene=============================================================================================================

union{
object {Haus_Roh translate <20,0,-100>}

//Fenster EG
object {Fenster5x8_5Z translate <30,4,-100>}
object {Fenster5x8_5Z translate <52.75,4,-100>}
object {Fenster5x8_5Z translate <75,4,-100>}
//Fenster DG
object {Fenster5x8_5Z translate <52.75,22,-100>}
//Fenster EG-R
object {Fenster5x8_5Z rotate <0,180,0> translate <35,4,-50.2>}
object {Fenster5x8_5Z rotate <0,180,0> translate <80,4,-50.2>}
//Fenster DG-R
object {Fenster5x8_5Z rotate <0,180,0> translate <57.75,22,-50.2>}
//Fenster EG-links
object {Fenster5x8_5Z rotate <0,90,0> translate <20,4,-83>}
object {Fenster5x8_5Z rotate <0,90,0> translate <20,4,-62>}
//Fenster DG-links
object {Fenster5x8_5Z rotate <0,90,0> translate <20,22,-77>}
object {Fenster5x8_5Z rotate <0,90,0> translate <20,22,-68>}

//Fenster EG-rechts
object {Fenster5x8_5Z rotate <0,-90,0> translate <90,4,-88>}
object {Fenster5x8_5Z rotate <0,-90,0> translate <90,4,-67>}
//Fenster DG-rechts
object {Fenster5x8_5Z rotate <0,-90,0> translate <90,22,-82>}
object {Fenster5x8_5Z rotate <0,-90,0> translate <90,22,-73>}
//Haustür
union{
difference{
box {<0,0,0.5>,<7,10,0.8> texture{T_Wood2  rotate x*90 scale 2}}
box {<2.8,2,0.4>,<4.2,8,0.9> texture{NBoldglass}}
}
sphere {<0,0,0>,0.35 translate <0.4,4.5,0.5> texture{T_Copper_2A}}
cylinder{<0,0,0>,<1,0,0>,0.29 translate <0.3,4.5,0.5> texture{T_Brass_1A}}
cylinder {<0,0,0>,<0,0,-2.9>,0.2 rotate x*30 translate <-0.3,9,0> texture {New_Brass}}
cylinder {<0,0,0>,<0,0,-2.9>,0.2 rotate x*30 translate <7.1,9,0> texture {New_Brass}}
rotate y*180
translate <59,0.5,-50>}
//Dachrinnen
object {WDR translate<17,20.5,-102>}
object {WDR translate<65,20.5,-102>}
object {SDR translate<43,0,-100.5>}
object {SDR translate<67,0,-100.5>}

object {WDR translate<17,18.5,-47>}
object {WDR translate<65,18.5,-47>}
object {SDR translate<43,-1,-48>}
object {SDR translate<67,-1,-48>}
//Dachflaechen
//vorne

#declare XL = 17;
#declare endx = 92;

#while (XL <= endx)
difference{
object{Dachziegelengobiert (33) rotate x*50 translate <XL,20.3,-101> texture{pigment{gradient y color_map {[0.0 color Scarlet*0.7]
                                                                                                [0.9 color Scarlet*0.5]
                                                                                                [0.9 color rgb 0.1]
                                                                                                [1 color rgb 0.1]
                                                                                                }
                                                                                                }scale <1,2,1>}}
box {<43,21,-102.5>,<66,30,-80>}
}
#declare XL = XL + 2.8;
#end
//hinten
#declare XLH = 17;
#declare endxLH = 92;

#while (XLH <= endxLH)
difference {
object{Dachziegelengobiert (36) rotate x*-50 translate <XLH,18.8,-48> texture{pigment{gradient y color_map {[0.0 color Scarlet]
                                                                                                [0.9 color Scarlet*0.5]
                                                                                                [0.9 color rgb 0.1]
                                                                                                [1 color rgb 0]
                                                                                                }
 
                                                                                               }}}
box {<43,21,-60>,<66,30,47>}
}
#declare XLH = XLH + 2.8;
#end
//MittelGiebelLinks
#declare ZV = -101;
#declare endZV = -47;

#while (ZV <= endZV)
union {
object{Dachziegelengobiert (20) rotate y*90 rotate z*-55 translate <39,30,ZV> texture{pigment{gradient y color_map {[0.0 color Scarlet]
                                                                                                [0.9 color Scarlet*0.5]
                                                                                                [0.9 color rgb 0.1]
                                                                                                [1 color rgb 0]
                                                                                                }
 
                                                                                               }}}
//Dachfirst Vorne nach hinten
cylinder{<0,0,-31>,<0,0,23>,0.5 translate <55,41.7,-70> texture{FirstTextur rotate y*90}}
}
#declare ZV = ZV + 2.8;
#end
//MittelGiebelRechts
#declare ZV = -101;
#declare endZV = -47;

#while (ZV <= endZV)
object{Dachziegelengobiert (20) rotate y*90 rotate z*55 translate <71.5,30,ZV> texture{pigment{gradient y color_map {[0.0 color Scarlet]
                                                                                                [0.9 color Scarlet*0.5]
                                                                                                [0.9 color rgb 0.1]
                                                                                                [1 color rgb 0]
                                                                                                }
 
                                                                                               }finish{ambient 0}}}
#declare ZV = ZV + 2.8;
#end
//Dachfirst
cylinder {<0,0,0>,<74,0,0>,0.5 translate <18,41.5,-75.5> texture{FirstTextur}}
//Kamin
difference{
union {
box {<0,0,0>,<12,7,3>}
box {<-0.4,6.5,-0.4>,<12.4,7.2,3.4> texture {T_Stone31 scale 0.5}}
texture{pigment{brick 
                White*0.5
                Scarlet*0.3
                brick_size <2,0.75,0.65>
                mortar 0.15}
                normal {wrinkles 0.75}
                }
}
box{<0.3,2,0.3>,<3.3,7.5,2.7> pigment {color rgb 0}}
box{<3.6,2,0.3>,<6.6,7.5,2.7> pigment {color rgb 0}}
box{<6.9,2,0.3>,<11.7,7.5,2.7> pigment {color rgb 0}}
translate<50,40,-76>}
box{<0,0,0>,<14,.05,35> pigment{image_map{png "dirtwall.png" map_type 0 interpolate 2}rotate x*90 scale <10,1,10>} translate <50,0,-50>}
//===================================
//Holzstoss==========================================
#declare startz = -105;
#declare endz = -80;
#while (startz <= endz)
object{holzstoss_basis rotate y*-90 translate <19,0,startz>}
#declare startz = startz + 1.2;
#end
#declare startz = -103;
#declare endz = -81;
#while (startz <= endz)
object{holzstoss_basis rotate y*-90 translate <19,0.8,startz>}
#declare startz = startz + 1.2;
#end
#declare startz = -102;
#declare endz = -82;
#while (startz <= endz)
object{holzstoss_basis rotate y*-90 translate <19,1.6,startz>}
#declare startz = startz + 1.2;
#end
//Gemüsebeete========================================

object {g_beet translate<-15,-0.1,-60>}
object {g_beet translate<-16,-0.1,-80>}
object {g_beet translate<-16,-0.1,-100>}
//================Pavillon
union{
box {<0,0,0>,<10,10,.1> material{Pav_Mat}}
box {<0,0,0>,<10,10,.1> translate<0,0,10> material{Pav_Mat}}
box {<0,0,0>,<.1,10,10> texture{T_Wood2}}
box {<0,9.9,0>,<10,10,10> texture{T_Wood2}}
 translate<0,0,-30>}
//Bäume


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
object{Lampe02_ scale .004 translate <48,0,-20>}
#include "kiefer.inc"
union {
object{FOLIAGE texture{gradient y frequency 4  turbulence .7 omega .4 texture_map{[0 Blaetter_Herbst1][.3 Blaetter_Herbst2][.3 Blaetter_Herbst1][1 Blaetter_Herbst2]}}}
object{WOOD}
double_illuminate //hollow
scale 28
translate <60,0,-110>
}
union {
object{FOLIAGE texture{gradient y frequency 4 turbulence .5 omega .4 texture_map{[0 Blaetter_Herbst1][.3 Blaetter_Herbst2][.3 Blaetter_Herbst1][1 Blaetter_Herbst2]}}}
object{WOOD}
double_illuminate hollow
scale 28
rotate y*45
translate <80,0,-30>
}
//Bodenplatte

object {bodenplatte texture { pigment{ image_map { jpeg "grasstex_herbst.jpg" map_type 0 interpolate 2} rotate <90,0,0> scale 30} finish {ambient 0}}}
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
