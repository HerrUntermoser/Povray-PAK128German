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
                            location <20 ,15.0 ,80>
                            look_at <20 ,15,0>}
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
//====Texturen================================================================================
#declare Hausfarbe_r = texture{pigment{bozo color_map{ [0 color rgb <.98,.98,.82>*0.9][1 color rgb <.91,.84,.42>]} scale <0.5,1,0.8>}normal{agate 0.1}}
#declare Hausfarbe_l = texture{pigment{leopard color_map{ [0 color VLightGrey*.9][1 color Thistle*.8]} scale 0.8}normal{facets}}
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
#declare Fensterfarbe = texture {pigment {color rgb 1*0.8} finish{ambient 0.2 phong 0.5}}
#declare Boxtextur = texture{pigment{color Clear}}
//====OBEKTE=================================================================================
#declare haus = difference{
box{<0,0,0>,<42,16,42>}
box{<0.5,0.2,0.5>,<41.5,19,41.5> pigment{color White}}
object{Fenster_AS_7x6 translate <4,6,-0.1>}
object{Fenster_AS_7x6 translate <32,6,-0.1>}
object{Fenster_AS_7x6 translate <4,6,41.4>}
object{Fenster_AS_7x6 translate <18,6,41.4>}
object{Fenster_AS_7x6 translate <32,6,41.4>}
object{Fenster_AS_7x6 rotate y*90 translate <-0.1,6,13>}
object{Fenster_AS_7x6 rotate y*90 translate <-0.1,6,34>}
object{Fenster_AS_7x6 rotate y*90 translate <41.5,6,13>}
object{Fenster_AS_7x6 rotate y*90 translate <41.5,6,34>}
object{Haust_AS_7_11 translate<20,0.05,-0.1>}
}
#declare Zaunlatte_1 = union {
box{<0,0,0>,<0.5,6,0.1>}
cylinder{<0,0,0>,<0,0,0.1>,0.3 translate <.25,6,0>}
texture{T_Wood6}}
//====SZENE==================================================================================
union{
 //Rechts
 union{
object{haus}
object{Roof_0 (30,42,42,2,0.35,.7,Ziegeltextur_r,Boxtextur) translate <0,16,0>}
object{Fenster7x6 translate <4,6,0.1> texture{Fensterfarbe}}
object{Fenster7x6 translate <32,6,0.1> texture{Fensterfarbe}}
object{Fenster7x6 translate <4,6,41.8> texture{Fensterfarbe}}
object{Fenster7x6 translate <18,6,41.8> texture{Fensterfarbe}}
object{Fenster7x6 translate <32,6,41.8> texture{Fensterfarbe}}
object{Fenster7x6 rotate y*90 translate <0.1,6,13> texture{Fensterfarbe}}
object{Fenster7x6 rotate y*90 translate <0.1,6,34> texture{Fensterfarbe}}
object{Fenster7x6 rotate y*90 translate <41.8,6,13> texture{Fensterfarbe}}
object{Fenster7x6 rotate y*90 translate <41.8,6,34> texture{Fensterfarbe}}
object{Haustuer_7_11 translate <20,.05,.05>}
object{Kamin_2 translate<14,22,19>}
 rotate y*-90 translate<27,0,-98>
 texture{Hausfarbe_r}}
object{Regenwasserfass translate<27,0,-102>}
 //Links
 union{
object{haus}
object{Roof_0 (30,42,42,2,0.35,.7,Ziegeltextur_l,Boxtextur) translate <0,16,0>}
object{Fenster7x6 translate <4,6,0.1> texture{Fensterfarbe}}
object{Fenster7x6 translate <32,6,0.1> texture{Fensterfarbe}}
object{Fenster7x6 translate <4,6,41.8> texture{Fensterfarbe}}
object{Fenster7x6 translate <18,6,41.8> texture{Fensterfarbe}}
object{Fenster7x6 translate <32,6,41.8> texture{Fensterfarbe}}
object{Fenster7x6 rotate y*90 translate <0.1,6,13> texture{Fensterfarbe}}
object{Fenster7x6 rotate y*90 translate <0.1,6,34> texture{Fensterfarbe}}
object{Fenster7x6 rotate y*90 translate <41.8,6,13> texture{Fensterfarbe}}
object{Fenster7x6 rotate y*90 translate <41.8,6,34> texture{Fensterfarbe}}
object{Haustuer_7_11 translate <20,.05,0>}
object{Kamin_2 translate<24,22,23>}
 rotate y*90 translate<53,0,-57>
 texture{Hausfarbe_l}}
 //Rauch aus dem Schornstein
 sphere{ <0,0,0>, 6
        pigment { rgbt 1 }
        hollow

 interior{
    media{ method 3
           emission <1,1,1>
           absorption rgb 0.8
           scattering{ 1, 1 extinction  .50}
           density{ spherical turbulence .4 density_map{
                    [0.00 rgb 0]
                    [1.00 rgb 1]
                               }
           }
           samples 20    // >=1, higher = more precise
           //intervals 1     //
          confidence 0.9
     }}
 scale 5
  translate<7,32,-81>
}
 //Kleinkram=======================================
 object{Bank2 scale 2 translate<53,0,-104>}
 object{Bank1 scale 2 rotate y*90 translate<51,0,-64>}
 object{Waeschestange scale 2 translate<57,0,-50>}
 object{Waeschestange scale 2 translate<59,0,-40>}
 //Karnickelverschlaege=================================
 object{Hasenbox1 rotate <0,180,0> translate <0,0,-123>}
 object{Hasenbox1 rotate <0,180,0> translate <12,0,-123>}
 //Blumenkasten Plazebo
 object{Blumenkasten_Placebo translate <28,-0.5,-100>}
 object{Blumenkasten_Placebo translate <28,-0.5,-90>}
 //Gehweg==============================================
 box{<0,0,0>,<26,0.05,119> translate<27,0,-134> texture{pigment{image_map{png "dirtwall.png" map_type 0 interpolate 2}rotate x*90}scale 20}}
 //Zaun
 #declare startx = -20;
 #declare endx = 27;
 #while (startx <= endx)
 object {Zaunlatte_1 translate <startx,0,-134>}
 #declare startx = startx + 0.8;
 #end
 #declare startx = -20;
 #declare endx = 27;
 #while (startx <= endx)
 object {Zaunlatte_1 translate <startx,0,-15>}
 #declare startx = startx + 0.8;
 #end
 #declare startx = 53;
 #declare endx = 100;
 #while (startx <= endx)
 object {Zaunlatte_1 translate <startx,0,-134>}
 #declare startx = startx + 0.8;
 #end
#declare startx = 53;
 #declare endx = 100;
 #while (startx <= endx)
 object {Zaunlatte_1 translate <startx,0,-15>}
 #declare startx = startx + 0.8;
 #end
 //Bäume
 
 #include "eiche.inc"
 #declare Rinde = 
 texture{ pigment{ color rgb< .21, .14,.07>*0.65 } 
	normal { bumps 1.00 scale <0.025,0.075,0.025> }
          finish { phong 0.2 reflection 0.00}         
        } // end of texture 
//-------------------------------------------------------- 
#declare Blaetter_1 = 
 texture{ pigment{ bozo color_map{
                  [0.0 color rgbf<1,0.1,0,0.05>*0.7]
                  [0.3 color rgbf<1,0.1,0,0.2>*0.7]
                  [0.8 color rgbf<1,0.1,0,0.1>*0.7]
                  [1.0 color rgbf<1,0.35,.11,0>]
                           } }   
          normal { bumps 0.15 scale 0.05 }
          finish {ambient 0.1 diffuse 0.9}
        }
#declare Blaetter_2 = 
 texture{ pigment{  color rgbf< 1, 0.31, 0.0, 0.2>*0.25}   
          normal { bumps 0.15 scale 0.05 }
          finish {ambient 0.1 diffuse 0.9 phong 0.9}
        }
 object { eiche_13_stems texture{Rinde}
 
         scale 3 rotate y*37 translate<10,0,-32>}
#include "trauerweide.inc"
#declare Blaetter_3 = 
 texture{ pigment{ color rgbf< 1, 1,.2,.3>*1}   
          normal { bumps 0.15 scale 0.05 }
          finish {ambient 0.1 diffuse 0.9}
        }
#declare Blaetter_4 = 
 texture{ pigment{  color rgbf< .77,.38,.06, 0.4>*1.05}   
          normal { bumps 0.15 scale 0.05 }
          finish {diffuse 0.8}
        }
object { weeping_willow_13_stems texture{Rinde}
         rotate y*37 translate<60,0,-32>}
object { weeping_willow_13_stems texture{Rinde}
         scale 2 rotate y*37 translate<90,0,-38>}
object { eiche_13_stems texture{Rinde}
         scale 3.4 rotate y*54 translate<10,0,-122>}
#include "black_oak_2.inc"
object { black_oak_2_13_stems texture{Rinde}
         scale 5 rotate y*54 translate<90,0,-118>}
object { black_oak_2_13_stems texture{Rinde}
         scale 4 rotate y*5 translate<60,0,-125>}
//Bodenplatte
object {bodenplatte texture{pigment{image_map{jpeg "grasstex1.jpg" map_type 0 interpolate 2}} rotate x*90 scale 50}}

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
