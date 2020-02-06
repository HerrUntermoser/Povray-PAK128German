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
#include "metals.inc"
#include "stones.inc"
#include "woods.inc"
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
                            location  <140 ,35 ,-60>
                            right x*image_width/image_height
							look_at <0,5,-60>
							}
#declare Camera_3 = camera { perspective angle 90//links
                            location  <-60 , 30 ,-90>
                            right x*image_width/image_height
							look_at <0,10,-80>
							}

#declare Camera_4 = camera {perspective angle 90        // oben
                            location  <50 , 100 ,-70>
                            right     x*image_width/image_height
                            look_at   <50 , 0.0 ,-71>}
#declare Camera_5 = camera {perspective angle 90// vorne
                            location  <30 , 60 ,-140>
                            right x*image_width/image_height
							look_at <30,60,0>}
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
 
plane { <0,1,0>, 0 pigment{ color DarkGreen} translate<0,-50,0>}
#end
//=============================================objekte
#declare BT = texture {pigment {color rgb 0.2}}
#declare TTrans = texture {pigment{color Clear}}
#declare BalkonPfosten = texture_map{[0.0 T_Wood12][0.6 T_Wood26][0.7 T_Wood12][0.7 TTrans][0.9 BT][1.0 BT]}
#declare HT = texture {pigment {color DarkSlateBlue}}
#declare Wand_Farbe_1 =
texture{ pigment{ brick
           color rgb .7
           color rgb<.45,.11,.11>
           brick_size <1.8,.9,1.2 >
          mortar .15
         }
  normal { wrinkles 0.75 scale .4}
  finish { diffuse 0.9 phong 0.2}
  }
  #declare Ziegelstapel =
texture{ pigment{ brick
           color rgbt .7
           color rgb<.45,.11,.11>
           brick_size <1.8,.9,.9 >
          mortar .09
         }
  normal { wrinkles 0.75 scale .4}
  finish { diffuse 0.9 phong 0.2}
  }
#declare FirstTextur = texture{pigment{ gradient x color_map{ [0.0 color DarkSlateGrey*0.4][0.9 color DarkSlateGrey][0.9 color rgb 0.2][1.0 color rgb 0.2]}}scale 2 finish{ambient 0}}
#declare Dachbalken = prism{0,.65,8,
		<0,0>,
		<30,30>,
		<0,60>,
		<-.65,59.35>,
		<28.75,30>,
		<29.35,30>,
		<-.65,.65>,
		<0,0>
		texture{T_Wood12}}
#declare Geruest_L = union{
box{<-2,6,-0.4>,<70,6.2,-5> texture{T_Wood15}}
box{<-2,14,-0.4>,<70,14.2,-5> texture{T_Wood15}}
box{<-2,22,-0.4>,<70,22.2,-5> texture{T_Wood15}}
box{<-2,30,-0.4>,<70,30.2,-5> texture{T_Wood15}}
box{<-2,38,-0.4>,<70,38.2,-5> texture{T_Wood15}}
cylinder{<0,0,0>,<0,48,0>,0.2 translate<0.5,0,-5>}
cylinder{<0,0,0>,<0,48,0>,0.2 translate<0.5,0,-.5>}
cylinder{<0,0,0>,<0,48,0>,0.2 translate<10,0,-5>}
cylinder{<0,0,0>,<0,48,0>,0.2 translate<10,0,-.5>}
cylinder{<0,0,0>,<0,48,0>,0.2 translate<20,0,-5>}
cylinder{<0,0,0>,<0,48,0>,0.2 translate<20,0,-.5>}
cylinder{<0,0,0>,<0,48,0>,0.2 translate<28,0,-5>}
cylinder{<0,0,0>,<0,48,0>,0.2 translate<28,0,-.5>}
cylinder{<0,0,0>,<0,48,0>,0.2 translate<40,0,-5>}
cylinder{<0,0,0>,<0,48,0>,0.2 translate<40,0,-.5>}
cylinder{<0,0,0>,<0,48,0>,0.2 translate<55,0,-5>}
cylinder{<0,0,0>,<0,48,0>,0.2 translate<55,0,-.5>}
cylinder{<0,0,0>,<0,48,0>,0.2 translate<65,0,-5>}
cylinder{<0,0,0>,<0,48,0>,0.2 translate<65,0,-.5>}
cylinder{<0,0,0>,<0,48,0>,0.2 translate<70,0,-5>}
cylinder{<0,0,0>,<0,48,0>,0.2 translate<70,0,-.5>}
//Längsstreben
cylinder{<0,0,0>,<70,0,0>,0.2 translate<0,9,-5>}
cylinder{<0,0,0>,<70,0,0>,0.2 translate<0,9,-.5>}
cylinder{<0,0,0>,<70,0,0>,0.2 translate<0,17,-5>}
cylinder{<0,0,0>,<70,0,0>,0.2 translate<0,17,-.5>}
cylinder{<0,0,0>,<70,0,0>,0.2 translate<0,26,-5>}
cylinder{<0,0,0>,<70,0,0>,0.2 translate<0,26,-.5>}
cylinder{<0,0,0>,<70,0,0>,0.2 translate<0,34,-5>}
cylinder{<0,0,0>,<70,0,0>,0.2 translate<0,34,-.5>}
cylinder{<0,0,0>,<70,0,0>,0.2 translate<0,41,-5>}
cylinder{<0,0,0>,<70,0,0>,0.2 translate<0,41,-.5>}
cylinder{<0,0,0>,<70,0,0>,0.2 translate<0,44,-5>}
cylinder{<0,0,0>,<70,0,0>,0.2 translate<0,44,-.5>}

texture{Rust}
    }
#declare EimerKran = union{
box{<0,0,0>,<20,.65,.65> translate<0,30,0> texture{T_Wood15}}
cylinder{<0,0,0>,<0,29,0>,.1 translate<.3,0,.3>pigment{color rgb 1}}
cylinder{<0,0,0>,<0,1,0>,.3 translate<.3,0,.3> texture{T_Brass_1A}}
}
   //===========================================================
#declare Haus_Roh =
union{
difference {
union{
box {<0,0,0>,<70,39,50>}
box {<-.1,27,-0.1>,<70.1,27.8,50.1> pigment{color NewTan*.6}}
prism{0,.5,4,
        <0,0>,
        <25,25>,
        <0,50>,
        <0,0>
        rotate z*90 translate <.5,39,0>}
        
prism{0,0.5,4,
        <0,0>,
        <25,25>,
        <0,50>,
        <0,0>
        rotate z*90 translate <70,39,0>}
}
//Innenraum
box {<0.5,0.5,0.5>,<69.5,45,49.5>}
//Fensteraussparungen EG
box {<0,0,0>,<5,8.5,1> translate <10,4,-0.2>}
box {<0,0,0>,<5,8.5,1> translate <32.75,4,-0.2>}
box {<0,0,0>,<5,8.5,1> translate <55,4,-0.2>}
//Fensteraussparungen 1.
box {<0,0,0>,<5,8.5,1> translate <10,22,-0.4>}
box {<0,0,0>,<5,8.5,1> translate <32.75,22,-0.4>}
box {<0,0,0>,<5,8.5,1> translate <55,22,-0.4>}
//Fensteraussparungen DG
box {<0,0,0>,<5,8.5,1> translate <32.75,38,-0.2>}
//Fensteraussparungen links
box {<0,0,0>,<1,8.5,5> translate <-0.2,4,12>}
box {<0,0,0>,<1,8.5,5> translate <-0.2,4,33>}
//1.            
box {<0,0,0>,<1,8.5,5> translate <-0.4,22,12>}
box {<0,0,0>,<1,8.5,5> translate <-0.4,22,33>}
//DG            
box {<0,0,0>,<1,8.5,5> translate <-0.2,38,12>}
box {<0,0,0>,<1,8.5,5> translate <-0.2,38,33>}
//Fensteraussparungen rechts
box {<0,0,0>,<1,8.5,5> translate <69.2,4,12>}
box {<0,0,0>,<1,8.5,5> translate <69.2,4,33>}
//1.            8.5
box {<0,0,0>,<1,8.5,5> translate <69.4,22,12>}
box {<0,0,0>,<1,8.5,5> translate <69.4,22,33>}
//2.            8.5
box {<0,0,0>,<1,8.5,5> translate <69.2,38,12>}
box {<0,0,0>,<1,8.5,5> translate <69.2,38,33>}
//Fensteraussparungen EG-R
box {<0,0,49>,<5,8.5,50> translate <10,4,0.2>}
box {<0,0,49>,<7,10,50> translate <32,0.5,0.2>}
box {<0,0,49>,<5,8.5,50> translate <55,4,0.2>}
//Fensteraussparungen 1.R
box {<0,0,49>,<5,8.5,50> translate <10,22,0.4>}
box {<0,0,49>,<5,10,50> translate <32.75,20,0.4>}
box {<0,0,49>,<5,8.5,50> translate <55,22,0.4>}
//Fensteraussparungen DG-R
box {<0,0,49>,<5,8.5,50> translate <32.75,38,0.2>}
}
//Ziersockel unten
box {<-0.3,-0.05,-0.3>,<70.3,0.7,50.3> texture {T_Stone31 scale 0.05}}
//Ziersockel EG -> 1.
box {<-0.3,16.3,-0.3>,<70.3,16.7,50.3> texture {pigment{color NewTan*0.8}}}
box {<-0.5,16.7,-0.5>,<70.5,16.9,50.5> texture {pigment{color NewTan*0.5} normal {bumps 0.5 scale 0.08}}}
box {<-0.7,16.9,-0.7>,<70.7,17.2,50.7> texture {pigment{color NewTan*0.7} normal {bumps 0.5 scale 0.08}}}
//Ziersockel 2.
difference{
box {<-0.2,37,-0.2>,<70.2,37.7,50.2> texture {pigment{color NewTan*0.6} normal {bumps 0.3 scale 0.08}}}
box {<.5,36,.5>,<69.5,38,49.5>}
}
box {<0.5,35,0.5>,<69.5,35.5,49.5> texture{pigment{bozo turbulence 0.5 color_map{[0 color rgb 0.8][1 color rgb 0.9]} scale <.5,1,.5>} finish{ambient .1}}}
 texture {Wand_Farbe_1}
 }

//Szene=============================================================================================================

union{
union{
object {Haus_Roh}
object{Dachbalken rotate z*90 translate<5,34,-5>}
object{Dachbalken rotate z*90 translate<15,34,-5>}
object{Dachbalken rotate z*90 translate<25,34,-5>}
object{Dachbalken rotate z*90 translate<45,34,-5>}
object{Dachbalken rotate z*90 translate<55,34,-5>}
object{Dachbalken rotate z*90 translate<65,34,-5>}
box{<0.5,0,0>,<69.5,.6,.6> translate<0,63,24.4> texture{T_Wood12}}
//Kamin
difference{
union {
box {<0,0,0>,<12,65,3>}
box {<-0.4,64.5,-0.4>,<12.4,65.2,3.4> texture {T_Stone31 scale 0.5}}
texture{pigment{brick 
                White*0.5
                Scarlet*0.3
                brick_size <2,0.75,0.65>
                mortar 0.15}
                normal {wrinkles 0.75}
                }
}
box{<0.3,2,0.3>,<3.3,65.5,2.7> pigment {color rgb 0}}
box{<3.6,2,0.3>,<6.6,65.5,2.7> pigment {color rgb 0}}
box{<6.9,2,0.3>,<11.7,65.5,2.7> pigment {color rgb 0}}
translate<30,.1,24>}
//Gerüst
object{Geruest_L}
object{Geruest_L translate<0,0,55.5>}
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
object{EimerKran translate<-5,0,34>}
 translate <20,0,-100>}
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
 translate<30,35,-86>
 }
 box{<0,0,0>,<5.5,2,12>
  texture{gradient x texture_map{BalkonPfosten}}
 rotate y*67 translate<-5,0,-50> }
//gelagerte Balken hinter dem Haus
union{
box{<0,0,0>,<70,.6,.6> translate<0,.6,4> texture{T_Wood12}}
box{<0,0,0>,<70,.6,.6> translate<0,.6,7> texture{T_Wood12}}
box{<0,0,0>,<70,.6,.6> translate<0,.6,9> texture{T_Wood12}}
box{<0,0,0>,<0.5,.5,12> translate<8,0,0>}
 box{<0,0,0>,<0.5,.5,12> translate<32,0,0>}
 box{<0,0,0>,<0.5,.5,12> translate<62,0,0>}
 translate<-7,0,-31>
 texture{T_Wood26}
 }
//Sandhaufen & Weg================================
 
 height_field{tga "sandhaufen_hf.tga" smooth scale <35,4,12> translate <5,0,-74> pigment{image_map { jpeg "Sand_Braun_Mittel.jpg" map_type 0 interpolate 2} rotate x*90}}
 height_field{png "Mount2.png" smooth scale <18,6,24> rotate y*17 translate <0,-0.2,-72> pigment{image_map { jpeg "Sand_Braun_Mittel.jpg" map_type 0 interpolate 2} rotate x*90}}
height_field{png "Mount1.png" smooth scale <18,2,18> rotate y*23 translate <-10,-0.2,-104> pigment{image_map { jpeg "kies_grob_gelbweiss.jpg" map_type 0 interpolate 2} rotate x*90 scale <8,1,5>}}
//Kleinkram
object{schuttwanne rotate x*-90 rotate y*37 translate<0,0,-104> texture{Sandalwood}}
object{schuttwanne rotate x*-90 rotate y*-12 translate<-15,0,-100> texture{Sandalwood}}
object{schuttwanne rotate x*-90 translate<-15,0,-37> texture{Sandalwood}}
object{Regenwasserfass scale 0.7 translate<0,0,-112>}
object{Regenwasserfass scale 0.7 translate<-7,0,-113.5>}
object{Regenwasserfass scale 0.7 translate<1,0,-110>}
object{Regenwasserfass scale 0.7 translate<1,0,-80>}
object{Regenwasserfass scale 0.7 translate<3,0,-85>}
object{Regenwasserfass scale 0.7 translate<-2,0,-119>}
object{Regenwasserfass scale 0.7 translate<-9,0,-117>}
//Ziegelstapel
box{<0,0,0>,<5.5,6,12>
  texture{Ziegelstapel}
 translate<64,0,-28> }
box{<0,0,0>,<5.5,6,12>
  texture{Ziegelstapel}
 rotate y*7 translate<72,0,-28> }
 box{<0,0,0>,<5.5,6,12>
  texture{Ziegelstapel}
 translate<81,0,-28> }
 union{
 box{<0,0,0>,<5.5,4,12>}
 box{<2,4,3>,<4.5,7,12>}
   texture{Ziegelstapel}
 rotate y*-4 translate<89,0,-28> }
//Bodenplatte
object {bodenplatte texture { pigment{ image_map {  jpeg "kies_grob_gelbweiss.jpg" map_type 0 interpolate 2}} rotate <90,0,0> scale 40 finish {ambient 0.1}}}

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
