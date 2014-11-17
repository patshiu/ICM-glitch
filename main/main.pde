// GLITCH 
// ICM 2014 Final Project by 
// Tommy Payne & Pat Shiu
// tommypayne.org | obsesstheprocess.com

import gifAnimation.*;
import processing.opengl.*;

import controlP5.*;

PFont ProximaNova;
PFont ProximaNovaBold;

ControlP5 cp5;


PImage testImg; 
PGraphics sketchPad; 
DisplacementCloud imgCloud; 
CheGlitch cheGlitchObject;
GifMaker gifExport;
boolean GIFEXPORTMODE = false ;

//For the UI stuff
Toggle disperseToggler;

Slider xSlider; 
Slider ySlider;
int sliderMinSize = 100;
int sliderAspect = 100;
boolean toggleDisperse = true;


void setup() {
	
	background(0);
	testImg = loadImage("data/palette.png");
	//size(testImg.width, testImg.height, OPENGL);
	size(displayWidth, displayHeight, OPENGL);
	imgCloud = new DisplacementCloud(testImg);
	sketchPad = createGraphics(testImg.width, testImg.height);
	cheGlitchObject = new CheGlitch();
	imgCloud.flockToField(true);
	if ( GIFEXPORTMODE == true){
		frameRate(5);
		gifExport = new GifMaker(this, "export.gif");
		gifExport.setRepeat(0); // make it an "endless" animation
		//gifExport.setTransparent(0,0,0); // make black the transparent color. every black pixel in the animation will be transparent
		// GIF doesn't know have alpha values like processing. a pixel can only be totally transparent or totally opaque.
		// set the processing background and the transparent gif color to the same value as the gifs destination background color 
		// (e.g. the website bg-color). Like this you can have the antialiasing from processing in the gif.
	}

	//UIsetup();

	cp5 = new ControlP5(this);

	xSlider = cp5.addSlider("sliderMinSize")
	.setPosition(100,50)
	.setSize(100, 20)
	.setRange(0,255)
	.setColorBackground(color(255,0,0))
	.setColorForeground(color(0,0,255))
	.setColorActive(color(0,0,255));	
	//.setNumberOfTickMarks(5)
	;

	ySlider = cp5.addSlider("sliderAspect")
	.setPosition(100,100)
	.setSize( 20, 100)
	.setRange(255, 0)
	.setColorBackground(color(255,0,0))
	.setColorForeground(color(0,0,255))
	.setColorActive(color(0,0,255));	
	;

	// create a toggle
	disperseToggler = cp5.addToggle("toggleDisperse")
	.setPosition(100,250)
	.setSize(50,20)
	.setColorBackground(color(255,0,0))
	.setColorForeground(color(0,0,255))
	.setColorActive(color(0,255,0));	
	;


	//Setup fonts
	ProximaNova = loadFont("ProximaNova-Regular-12.vlw");
	ProximaNovaBold = loadFont("ProximaNova-Semibold-20.vlw");
}

void draw() {

	background(0);
 	float x = (width - testImg.width)/2;
 	float y = (height - testImg.height)/2;
 	pushMatrix();
	translate( x, y );
	imgCloud.translate( x, y );

	//rect(0,0, height, width); //draw a background of random color picked from original imaged
	imgCloud.run();
	
	cheGlitchObject.splitImage(0, 0, testImg.width, testImg.height);

	popMatrix();

	if ( GIFEXPORTMODE == true){	
		gifExport.setDelay(1);
	  	gifExport.addFrame();
  	}

  	//DRAW UI
  	drawUI();
}

void mousePressed(){
	if( imgCloud.goHome == false){
		imgCloud.goHome(true);
		disperseToggler.toggle();
		println(toggleDisperse);

	}
	else {
		imgCloud.flockToField(true);
		imgCloud.goHome(false);
		disperseToggler.toggle();
		println(toggleDisperse);

	}
/*	toggleHeader();	
	toggleSidebar();*/
}

void mouseMoved() {
	cheGlitchObject.updateGlitchParams();
	sliderMinSize = int(map(mouseX, 0, width, 0, 255));
	xSlider.setValue(sliderMinSize);

	sliderAspect = int(map(mouseY, 0, height, 0, 255));
	ySlider.setValue(sliderAspect);
	println("sliderMinSize : " + sliderMinSize + "   sliderAspect : " + sliderAspect);
}


void keyPressed() {
	if ( GIFEXPORTMODE == true){
  		gifExport.finish();
  		println("gif saved");
  	}
}




