// GLITCH 
// ICM 2014 Final Project by 
// Tommy Payne & Pat Shiu
// tommypayne.org | obsesstheprocess.com

import gifAnimation.*;
import processing.opengl.*;


PImage testImg; 
PGraphics sketchPad; 
DisplacementCloud imgCloud; 
CheGlitch cheGlitchObject;
GifMaker gifExport;
boolean GIFEXPORTMODE = false ;

void setup() {
	
	background(0);
	testImg = loadImage("data/gilmore.jpg");
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

}

void draw() {
	background(0);
	int x = displayWidth - testImg.width/2; 
	int y = displayHeight - testImg.height/2; 
	translate( x, y );

	//rect(0,0, height, width); //draw a background of random color picked from original imaged
	imgCloud.run();
	
	cheGlitchObject.splitImage(0, 0, testImg.width, testImg.height);

	if ( GIFEXPORTMODE == true){	
		gifExport.setDelay(1);
	  	gifExport.addFrame();
  	}
}

void mousePressed(){
	if( imgCloud.goHome == false){
		imgCloud.goHome(true);
	}
	else {
		imgCloud.flockToField(true);
		imgCloud.goHome(false);

	}
}

void mouseMoved() {
  cheGlitchObject.updateGlitchParams();
}


void keyPressed() {
	if ( GIFEXPORTMODE == true){
  		gifExport.finish();
  		println("gif saved");
  	}
}




