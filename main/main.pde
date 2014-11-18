// GLITCH 
// ICM 2014 Final Project by 
// Tommy Payne & Pat Shiu
// tommypayne.org | obsesstheprocess.com

import gifAnimation.*;
import processing.opengl.*;

import controlP5.*;

PFont ProximaNova;
PFont ProximaNovaBold;
PFont ProximaNovaLight;

//ControlP5 cp5;


PImage testImg; 
PGraphics sketchPad; 
DisplacementCloud imgCloud; 
CheGlitch cheGlitchObject;
GifMaker gifExport;
boolean GIFEXPORTMODE = false ;

//For the UI stuff
Toggle disperseToggler;
PImage vignette; 

boolean toggleDisperse = true;




void setup() {
	
	background(#222222);
	testImg = loadImage("data/face.jpg");
	vignette = loadImage("slice_vignette.png");
	size(1380, 850, OPENGL); //absolute dimension
	//size(testImg.width+100, testImg.height+100, OPENGL);
	//size(displayWidth, displayHeight, OPENGL);
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


	//Setup fonts
	ProximaNovaLight = loadFont("ProximaNova-Light-12.vlw");
	ProximaNova = loadFont("ProximaNova-Regular-12.vlw");
	ProximaNovaBold = loadFont("ProximaNova-Semibold-20.vlw");
}

void draw() {

	background(#222222);
	image(vignette, 0, 0, width, height);
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

/*	if (mousePressed == true) {
		if (squareGlitchSize.isUnderCursor() == true){
			squareGlitchSize.setValue(mouseX);
			//println("Setting squareGlitchSize value to " + mouseX );
		}

		if (squareGlitchAspect.isUnderCursor() == true){
			squareGlitchAspect.setValue(mouseX);
			//println("Setting squareGlitchAspect value to " + mouseX );
		}

	} */
}

void mouseDragged() {
	if (squareGlitchSize.isUnderCursor() == true){
			squareGlitchSize.setValue(mouseX);
			//println("Setting squareGlitchSize value to " + mouseX );
		}

		if (squareGlitchAspect.isUnderCursor() == true){
			squareGlitchAspect.setValue(mouseX);
			//println("Setting squareGlitchAspect value to " + mouseX );
		}
}

void mousePressed(){

	if (squareGlitchOnOff.isUnderCursor() == true){
		squareGlitchOnOff.toggle();
			if( squareGlitchOnOff.isOn == false){
				cheGlitchObject.isOn = false; 
			}
			else {
				cheGlitchObject.isOn = true;
			}
	}

	if (driftToggle.isUnderCursor() == true){
		driftToggle.toggle();
			if( driftToggle.isOn == false){
				imgCloud.goHome(true);
			}
			else {
				imgCloud.flockToField(true);
				imgCloud.goHome(false);
			}
	}

	if (importBtn.isUnderCursor() == true){
		println("Import button was pressed");
	}

	if (resetBtn.isUnderCursor() == true){
		println("Reset button was pressed");
	}

	if ( pauseBtn.isUnderCursor() == true){
		println("Pause button was pressed");
	}

	if (exportBtn.isUnderCursor() == true){
		println("Export button was pressed");
		saveFrame("exportedImage_##.jpg");
	}

}

void mouseMoved() {
	cheGlitchObject.updateGlitchParams();
}


void keyPressed() {
	println(keyCode); 

	if (keyCode == 9){ //If "tab" is hit, toggle the UI
		toggleHeader();
		toggleSidebar();
	}

	if (keyCode == 80){ //If "p" is hit, "print" gif
		if ( GIFEXPORTMODE == true){
				gifExport.finish();
				println("gif saved");
			}
	}

}




