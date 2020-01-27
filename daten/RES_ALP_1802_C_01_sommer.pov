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
union{
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
         rotate y*37 translate<60,0,-32>}
union { object { weeping_willow_13_stems texture{Rinde}}
         object { weeping_willow_13_leaves  double_illuminate
                  texture{ Blaetter_3 }   
                  interior_texture{ Blaetter_4 }}
         scale 3 rotate y*37 translate <46,0,-31>}
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
         scale 4 rotate y*5 translate<85,0,-65>}
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
 translate<90,0,-38>
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
object {bodenplatte texture{pigment{image_map{jpeg "grasstex1.jpg" map_type 0 interpolate 2}} rotate x*90 rotate y*45 scale 50}}

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
