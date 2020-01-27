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
#include "shapes3.inc"
#include "Roof_0.inc"
#include "basis.inc"
#declare Camera_0 = camera{
  orthographic
  location<100, 81.4, -100>  
look_at<0, 0, 0>
}
#declare Camera_1 = camera {perspective angle 90   // rueckseite
                            location  <-20 ,15.0 ,10.0>
                            look_at   <0 ,15,0>}
#declare Camera_2 = camera {perspective angle 90//rechts
                            location  <100 ,15 ,-110>
                            right x*image_width/image_height
							look_at <0,5,-100>
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
                            location  <50 , 5.0 ,-150>
                            right x*image_width/image_height
							look_at <50,8,0>}
camera {Camera_0}

// sun -------------------------------------------------------------------
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
texture{ pigment{ color rgb <1,1,0.70>*0.8}
         normal {bozo 1 turbulence 0.5 scale 1.2}}
#declare FirstTextur = texture{pigment{ gradient x color_map{ [0.0 color DarkSlateGrey*0.4][0.9 color DarkSlateGrey][0.9 color rgb 0.2][1.0 color rgb 0.2]}}scale 2 finish{ambient 0}}


#declare RoofTrans = <-1.25,0,0>;
#declare Roof_Base_Color = <0.69,0,0.16>;
#declare Roof_Color_Factor = 0.4;
//winter

#declare Roof_Texture1 = texture{
   pigment{dents turbulence 0.3
           color_map{[0.00 color White*0.7 ]
                     [0.90 color White*1.1 ]
                     [0.95 color rgb 0.7 ]
                     [1.00 color rgb 0.4 ]
                    }
           scale 2}
   normal { bumps 0.3 scale 0.015} 
   finish { specular 0.08 roughness 0.8}
   translate RoofTrans}

#declare Roof_Texture2 = texture{
   Roof_Texture1  
   finish { ambient 0.15 diffuse 0.85}}
#declare T_Wood_Door = texture{pigment{P_WoodGrain1B 
color_map {[0.0 color rgb <0.40,0.3,0.16>]
    [0.5 color rgb <0.40,0.3,0.16>*0.5]
    [0.5 color rgb <0.29,0.22,0.11>*0.7]
    [1.0 color rgb <0.29,0.22,0.11>*0.9]}
    }}
   //===========================================================
#declare Haus_Roh =
union{
difference {
box {<0,0,0>,<70,19.5,50>}       
//Abzug Dachflaechen
//Innenraum
box {<0.5,0.5,0.5>,<69.5,25,49.5> pigment{color MediumSeaGreen}}
//Fensteraussparungen EG
object {Fenster_AS_6x6 translate <10,6,-0.2>}
object {Fenster_AS_6x6 translate <25,6,-0.2>}
object {Fenster_AS_6x6 translate <40,6,-0.2>}
object {Fenster_AS_6x6 translate <55,6,-0.2>}
//Fensteraussparungen links
object {Fenster_AS_6x6 rotate y*90 translate <-0.2,6,12>}
object {Fenster_AS_6x6 rotate y*90 translate <-0.2,6,45>}
//Fensteraussparungen rechts
object {Fenster_AS_6x6 rotate y*90 translate <69.5,6,12>}
object {Fenster_AS_6x6 rotate y*90 translate <69.5,6,43>}
//Fensteraussparungen EG-R
object {Fenster_AS_6x6 translate <10,6,49.5>}
object {Fenster_AS_6x6 translate <25,6,49.5>}
object {Fenster_AS_6x6 translate <40,6,49.5>}
object {Fenster_AS_6x6 translate <55,6,49.5>}
//Haustuer
box {<0,0,0>,<9,12,1> rotate y*90 translate <-0.1,0.5,35>}
}
//Ziersockel unten
box {<-0.3,-0.05,-0.3>,<70.3,0.7,50.3> texture {T_Stone31 scale 0.05}}
texture {Wand_Farbe_1}
 }
#declare WDR = difference{cylinder {<0,0,0>,<71,0,0>,0.4}cylinder {<0,0,0>,<70.5,0,0>,0.35 translate <0,0.2,0>} texture {T_Brass_1A}}
#declare SDR = cylinder {<0,0,0>,<0,19,0>,0.3 texture {T_Brass_1A}}

#declare Zaun_Saeule = union{box{<0,0,0>,<1.5,7.5,1.5> texture{T_Stone31 scale 0.7} texture{pigment{brick 
                White*0.2
                Clear
                brick_size <2,0.75,0.65>
                mortar 0.15}
                normal {wrinkles 0.75}}
                }box{<-0.2,6.5,-0.2>,<1.7,6.6,1.7> texture{T_Stone31}
                }
                }
#declare Zaun_Pfosten = box{<-0.2,0,-0.1>,<0.2,6,0.1> texture {T_Wood22 normal{bumps 0.3 scale 0.4}}}
#declare Zaun_Pfosten_Z = box{<-0.1,0,-0.2>,<0.1,6,0.2> texture {T_Wood22}}
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
//Szene=============================================================================================================

union{
object {Haus_Roh translate <0,0,-115>}
//Fenster EG===========================================
union{
object {Fenster6x6_L2}
difference {box {<-0.4,-0.4,-0.05>,<6.9,6.9,0.05>}box{<0,0,-0.1>,<6.5,6.5,0.1>} pigment{color PaleGreen*0.7}}
 translate <10,6,-115.1>}
union{
object {Fenster6x6_L2}
difference {box {<-0.4,-0.4,-0.05>,<6.9,6.9,0.05>}box{<0,0,-0.1>,<6.5,6.5,0.1>} pigment{color PaleGreen*0.7}}
 translate <25,6,-115.1>}
 union{
object {Fenster6x6_L2}
difference {box {<-0.4,-0.4,-0.05>,<6.9,6.9,0.05>}box{<0,0,-0.1>,<6.5,6.5,0.1>} pigment{color PaleGreen*0.7}}
 translate <40,6,-115.1>}
 union{
object {Fenster6x6_L2}
difference {box {<-0.4,-0.4,-0.05>,<6.9,6.9,0.05>}box{<0,0,-0.1>,<6.5,6.5,0.1>} pigment{color PaleGreen*0.7}}
 translate <55,6,-115.1>}
 //Fenster EG-Rückseite
union{
object {Fenster6x6_L2}
difference {box {<-0.4,-0.4,-0.05>,<6.9,6.9,0.05>}box{<0,0,-0.1>,<6.5,6.5,0.1>} pigment{color PaleGreen*0.7}}
 rotate y*180 translate <16,6,-65>}
union{
object {Fenster6x6_L2}
difference {box {<-0.4,-0.4,-0.05>,<6.9,6.9,0.05>}box{<0,0,-0.1>,<6.5,6.5,0.1>} pigment{color PaleGreen*0.7}}
 rotate y*180 translate <31,6,-65>}
union{
object {Fenster6x6_L2}
difference {box {<-0.4,-0.4,-0.05>,<6.9,6.9,0.05>}box{<0,0,-0.1>,<6.5,6.5,0.1>} pigment{color PaleGreen*0.7}}
 rotate y*180 translate <46,6,-65>}
union{
object {Fenster6x6_L2}
difference {box {<-0.4,-0.4,-0.05>,<6.9,6.9,0.05>}box{<0,0,-0.1>,<6.5,6.5,0.1>} pigment{color PaleGreen*0.7}}
 rotate y*180 translate <61,6,-65>}

//Fenster EG-links
union{
object {Fenster6x6_L2}
difference {box {<-0.4,-0.4,-0.05>,<6.9,6.9,0.05>}box{<0,0,-0.1>,<6.5,6.5,0.1>} pigment{color PaleGreen*0.7}}
 rotate y*90 translate <0,6,-103>}
union{
object {Fenster6x6_L2}
difference {box {<-0.4,-0.4,-0.05>,<6.9,6.9,0.05>}box{<0,0,-0.1>,<6.5,6.5,0.1>} pigment{color PaleGreen*0.7}}
 rotate y*90 translate <0,6,-69>}
//Fenster EG-rechts
union{
object {Fenster6x6_L2}
difference {box {<-0.4,-0.4,-0.05>,<6.9,6.9,0.05>}box{<0,0,-0.1>,<6.5,6.5,0.1>} pigment{color PaleGreen*0.7}}
 rotate y*-90 translate <70,6,-109>}
union{
object {Fenster6x6_L}
difference {box {<-0.4,-0.4,-0.05>,<6.9,6.9,0.05>}box{<0,0,-0.1>,<6.5,6.5,0.1>} pigment{color White*0.7}}
 rotate y*-90 translate <70,6,-77>}

//Haustür
union{
box {<0,0,0.5>,<9,12.5,0.8> texture{T_Wood_Door }}
sphere {<0,0,0>,0.35 translate <0.4,3.5,0.5> texture{T_Copper_2A}}
cylinder{<0,0,0>,<1,0,0>,0.29 translate <0.3,3.5,0.5> texture{T_Brass_1A}}
box{<-0.8,0,-0.1>,<0,12.5,0> pigment{color rgb <.23,.48,.34>*0.4}}
box{<9,0,-0.1>,<9.8,12.5,0> pigment{color rgb <.23,.48,.34>*0.4}}
box{<-0.8,12.5,-0.1>,<9.8,13.3,0> pigment{color rgb <.23,.48,.34>*0.4}}
rotate y*90
translate <-0.3,0.5,-80>}
//Treppenstufen
union{
cylinder{<0,0,0>,<0,0.2,0>,5}
cylinder{<0,0,0>,<0,0.29,0>,4 translate<0,0.2,0>}
texture {T_Grnt25 scale 0.7 normal{pigment_pattern{ brick
                     color rgb 0.2,
                     color rgb 0.8
                     scale 0.8}}}
translate <0,0,-82>}
//Treppenstufen
union{
cylinder{<0,0,0>,<0,0.2,0>,5}
cylinder{<0,0,0>,<0,0.29,0>,4 translate<0,0.2,0>}
texture {T_Grnt25 scale 0.7 normal{pigment_pattern{ brick
                     color rgb 0.2,
                     color rgb 0.8
                     scale 0.8}}}
translate <0,0,-84>}
object{ Segment_of_Torus( 1,
                          0.6,
                          90
                        ) //------------
        texture{T_Brass_1A}
        scale<1,1,1>
        rotate<-90,0,0>
        rotate<-0,120,0>
        translate<0.5,14,-114.8>
      }
//Dachflaechen
object{ Roof_0 (   45,    // Roof___Angle1, // roof angle                              
                    70.00, // Roof___WideX,  //   base length of the roof part in x-direction
                    50.00, // Roof___WideZ,  //   base length of the roof part in z-direction  
                   1.0,  // Roof___Over,     // overhang
                   1.4, // R_Cyl,          // radius cylinders
                   1.6,  // Cyl_D,         // distance cylinders
                   Roof_Texture1, // Roof___Texture1, // cylinder texture
                   Roof_Texture2  // Roof___Texture2  // base box texture
                ) //------------------------------------------------------  
 scale <1,0.7,1>       
translate<-0,19.5,-115>}
//====KLEINKRAM

//Dachrinnen
object{WDR translate<-0.5,19,-116>}
object{WDR translate<0,19,-64>}
object{SDR translate<-0.3,0,-115.7>}
object{SDR translate<70.3,0,-64.7>}
//Kamin
object {Kamin_1 translate<19,26,-102>}
object {Kamin_1 translate<29,30,-86>}
//Brunnen=============================
object{Brunnen translate <55,-5,-30>}
//Karnickelverschlag=============================
union{
difference{
box{<0,0,-20>,<10,4,-22>}
box{<-1,4,-19.5>,<11,8,-23> rotate x*7 translate <0,-1,0>}
 texture{gradient x texture_map{BalkonPfosten}}}
box{<-1.5,4,-19.5>,<10.5,4.4,-23> rotate x*7 translate <0,-3,0> texture{gradient x texture_map{
[0.0 T_Stone17][0.7 T_Stone17][0.7 T_Stone8][0.9 BT][1.0 BT]}}}

rotate <0,180,0> translate <12,0,-83>}

//Holzstoss==========================================
#declare startz = -105;
#declare endz = -80;
#while (startz <= endz)
object{holzstoss_basis rotate y*-90 translate <71,0,startz>}
#declare startz = startz + 1.2;
#end
#declare startz = -103;
#declare endz = -81;
#while (startz <= endz)
object{holzstoss_basis rotate y*-90 translate <71,0.8,startz>}
#declare startz = startz + 1.2;
#end
#declare startz = -102;
#declare endz = -82;
#while (startz <= endz)
object{holzstoss_basis rotate y*-90 translate <71,1.6,startz>}
#declare startz = startz + 1.2;
#end
//Mauer======================================================
box { <-20,0,-134>,<-19,3,-15>texture { T_Stone44
                   normal { agate 0.35 scale 0.05}
                   finish { phong 0.2 }
                   scale 0.2
                 }}

#declare xVstart =0;
#declare xVende = 100;
#while (xVstart <= xVende)
object{Zaun_Pfosten translate <xVstart,0,-133.8>}
#declare xVstart = xVstart + 0.6;
#end

//Asphalt in der Einfahrt

box {<-9,-0.1,-80>,<0,0.05,-134> pigment{ bozo scale 1.5 turbulence 0.35
         color_map { [0.00 color rgb<1,1,1>]
                     [0.08 color rgb<0,0,0>]
                     [0.32 color rgb 0.9*0.7]
                     [1.00 color rgb 1]
                   } // end of color_map
         scale 0.2
       }}
box {<-19.8,-0.1,-18>,<62,0.05,-65> texture{ pigment{bozo turbulence 0.3 color_map{[0.0 color rgb 1*0.2]
                                                                [0.5 color rgb .9*1]
                                                                [1 color rgb 1]
                                                                } }
                 normal { bozo 3 scale 0.05}
                 finish { diffuse 0.9 specular 1}}} 
//Bäume

#include "sassafras_m.inc"
#declare Stem_Texture = 
 texture{ pigment{ color rgb< 0.95, 0.95, 0.95>} 
          normal { bumps 0.75 scale <0.025,0.075,0.025> }
          finish { phong 0.2 reflection 0.00}         
        } // end of texture 
//------------------------------------------------------- 
//winter:

#declare Leaves_Texture_1 =
texture{ pigment{ bozo
                  color_map{
                  [0.0 color rgbt<1,0.1,0,1>]
                  [1.0 color rgbt<1,0.7,0,1>]
                           }
                } 
         normal { bumps 0.15 scale 0.05 }
         finish { phong 1 reflection 0.00}
       } // end of texture
//-------------------------------------------------
#declare Leaves_Texture_2 =
texture{ pigment{ color rgbt<1,0.9,0.9,1>}
         normal { bumps 0.15 scale 0.05 }
        finish {phong 0.2}}


union { 
         object { sassafras_13_stems
                 texture{ Stem_Texture }}
         object { sassafras_13_leaves
                double_illuminate
                  texture{ Leaves_Texture_1 }   
                  interior_texture{ Leaves_Texture_2 }   
                } rotate <0,-20,0> translate<8,0,-124>}

union { 
         object { sassafras_13_stems
                 texture{ Stem_Texture }}
         object { sassafras_13_leaves
                double_illuminate
                  texture{ Leaves_Texture_1 }   
                  interior_texture{ Leaves_Texture_2 }   
                } rotate <0,6,0> translate<67,0,-129>}
                
//Black Oak - Schwarzeiche
#declare RINDE = texture {
	pigment {
		granite
		cubic_wave
		color_map {[0 color rgb 1][1 color rgb 0.8]}
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
			[0 color rgb 0.9]
			[0.35 color rgb 0.8]
			[0.50 color rgb 1]
			[0.65 color rgb 1]
			[1 color rgb 0.5]
		}
		
		scale <1.0, 10.0, 1.0>*3
	}
	finish {
		phong 1.0 phong_size 4
	}
}

#declare BOZO1 = pigment {
	bozo
	color_map {
		[0 color rgb<0.17, 0.58, 0.0>]
		[1 color rgb<0.17, 0.58, 0.0>]
	}
	scale 0.04
}
#declare BOZO2 = pigment {
	bozo
	color_map {
		[0 color rgb<0.17, 0.58, 0.0>]
		[1 color rgb<0.17, 0.58, 0.0>]
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
//Schwarzeiche Textur
#declare Stem_Texture = 
 texture{ pigment{ color rgb< 0.70, 0.8, 0.9>*0.9 } 
          normal { bumps 1.00 scale <0.025,0.075,0.025> }
          finish { phong 0.2 reflection 0.00}         
        } // end of texture 
//-------------------------------------------------------- 
#declare Leaves_Texture_1 = 
 texture{ pigment{ color rgbf<1,1, 0.9, 0.1>*1.0 }   
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

   union{ 
          object{ ca_black_oak_13_stems
                  texture{ Stem_Texture }
}                
          object{ ca_black_oak_13_leaves  
                  double_illuminate
                  texture{ Leaves_Texture_1 }   
                  interior_texture{ Leaves_Texture_2 }   
            }
      scale <2,3,2> translate<80,0,-30>}
//Ahorn===============================================
#include "ahorn.inc"

object{WOOD

		scale 30
       translate<60,0,-22>}

object{WOOD

		scale 30
       translate<50,0,-45>
        
      }
object{WOOD

		scale 30
       translate<30,0,-36>
        
      }
object{WOOD

		scale 30
       translate<25,0,-49>
       rotate y*34
        
      }

//Bodenplatte
object {bodenplatte texture { pigment{ image_map { png "schnee_ground.png" map_type 0 interpolate 2}} rotate <90,0,0> scale 5 finish {ambient 0.6}}}
//Ende Bodenplatte
//schnee

object {schnee scale <37,6,17> rotate <-34.5,0,0> translate <17,19.5,-114>}
object {schnee scale <49,6,12> rotate <-34.5,0,0> translate <9,19.5,-114>}
object {schnee scale <45,6,12> rotate <34.5,0,0> translate <16,28.5,-78.9>}
object {schnee scale <40,6,17> rotate <34.5,0,0> translate <16,28.5,-78.9>}

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
