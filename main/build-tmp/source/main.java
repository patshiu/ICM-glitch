import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class main extends PApplet {

// GLITCH 
// ICM 2014 Final Project by 
// Tommy Payne & Pat Shiu
// tommypayne.org | obsesstheprocess.com


PImage testImg; 
PGraphics sketchPad; 
DisplacementCloud imgCloud; 

public void setup() {
	size(900, 900);
	background(0);
	testImg = loadImage("data/gilmore.jpg");
	imgCloud = new DisplacementCloud(testImg);
	sketchPad = createGraphics(testImg.width, testImg.height);
	imgCloud.flockToField(PApplet.parseInt(1));

}

public void draw() {
	background(0);
	
	imgCloud.run();
	//image(testImg, 0, 0 );

}



class PixelParticle {
	PVector home; //Original location in the image
	PVector location; 
	PVector velocity; 
	PVector friction; 
	float mass; 

	float maxForce;
	float maxSpeed;

	int c; 
	boolean isDead;

	//Constructor
	PixelParticle( PImage motherImg, int x, int y) {
		home = new PVector(x, y);
		location = home; 
		velocity = new PVector(0,0); 
		friction = new PVector(0,0); 
		mass = 1; 

		maxForce = 8; 
		maxSpeed = 0.2f; 

		c =  motherImg.get(x, y);
		isDead = false;
	}

	public void randoWalk(){
		PVector randoV = PVector.random2D();
		randoV.limit(0.3f);
		applyForce(randoV);
	}

	public void applyForce(PVector acceleration){
		velocity = PVector.add(velocity, acceleration, friction);
		velocity.limit(maxSpeed);
		location = PVector.add(location, velocity); 
	}

	public void display(){
		set(PApplet.parseInt(location.x), PApplet.parseInt(location.y), c);
		updatePixels();
	}

	public void offScreenCheck(){
		if (location.x < 0 || location.y < 0 || location.x > width || location.y > height){
			isDead = true;
		}
	}

	public void steerHome(){
		PVector desired = PVector.sub(home, location);
		desired.limit(2);
		PVector steer = PVector.sub(desired, velocity);
		steer.limit(maxForce);
		applyForce(steer);
	}

	public void disperse(){
		randoWalk();
		offScreenCheck();
		display();
	}

	public void goHome(){
		steerHome();
		offScreenCheck();
		display();
	}

	//THESE FUNCTION STEER THE PARTICLE DEPENDING ON FILTER STATUS
	public void flockToField(FlowField flowField){
		PVector desired = flowField.lookup(location);
		desired.mult(maxSpeed);

		PVector steer = PVector.sub(desired, velocity);
		steer.limit(maxForce);
		applyForce(steer);
	}

	public void updateParticle(boolean lavaLamp, boolean flockToField, FlowField flowField, boolean randoWalk, boolean disperse){
		//Apply forces depending on which filters have been applied
		if( lavaLamp == true){
			//lavaLamp();
		}
		if ( flockToField == true){
			flockToField(flowField);
		}
		if ( randoWalk == true){
			//randoWalk();
		}
		if ( disperse == true){
			//disperse()
		}
		//THIS DOES NOT DISPLAY THE PARTICLE
	}

	public void run(boolean lavaLamp, boolean flockToField, FlowField flowField, boolean randoWalk, boolean disperse){
		updateParticle( lavaLamp, flockToField, flowField, randoWalk, disperse);
		display();
	}
}

class PixelParticleSystem {
	ArrayList<PixelParticle> pixelCloud; 
	boolean disperse; //If true, particle disperse, if false, particle return home.

	//These support flockToField 
	FlowField flowField; 


	PixelParticleSystem(PImage inputImage, float resolution){
		float resConstrain = constrain(resolution, 1, inputImage.width/2);
		pixelCloud = new ArrayList<PixelParticle>(); 
		disperse = false;
		flowField = new FlowField(); 
		inputImage.loadPixels();
		for (int i = 0; i < inputImage.pixels.length; i++){
			
			int x; 
			int y;
			if (i < inputImage.width){
				x = i;
				y = 1;
			}
			else {
				x = i % inputImage.width;
				y = PApplet.parseInt(i / inputImage.width);
			}
			if (x % resConstrain == 0 && y % resConstrain == 0){ //Just loading a quarter the pixels, for better performance. 
				pixelCloud.add(new PixelParticle(inputImage, x, y ));
			}
		}
		println("pixelCloud loaded, size is " + pixelCloud.size());
	}
	//In case user forgets to key in resolution para, default to 1
	PixelParticleSystem(PImage inputImage){
		this(inputImage, 1);
	}

	public void goHome(){
		for (int i = pixelCloud.size()-1; i > 0 ; i--){
			PixelParticle currentPixel = pixelCloud.get(i);
			currentPixel.goHome();
		}
	}	

	public void oldRun(){ //THIS NEEDS TO BE REMOVED
		for (int i = pixelCloud.size()-1; i > 0 ; i--){
			PixelParticle currentPixel = pixelCloud.get(i);
/*			if(currentPixel.isDead == true){
				pixelCloud.remove(i); 
				println("Particle removed, current size is " + pixelCloud.size() );
			}
			else {*/
				if(disperse == true){
					currentPixel.disperse();
				}
				else{
					currentPixel.goHome();
				}
/*			}*/
		}
	}
	public void run(boolean lavaLamp, boolean flockToField, boolean randoWalk, boolean disperse){
		for (int i = pixelCloud.size()-1; i > 0 ; i--){
			PixelParticle currentPixel = pixelCloud.get(i);
			currentPixel.run( lavaLamp, flockToField, flowField, randoWalk, disperse);
		}
	}
}











//UTILITY MODULE - GUI 
//-------------------
//This module creates a GUI for this image glitching app. 

//* * * * * * *
//1st
//Check out control p5 lib
//* * * * * * *

//Import button 

//Color Label
//Color controls

//Focus Label
//Focus controls

//Displace Label
//Displace controls

//Recursive Label
//Recursive controls

//Reset button 

//Export button 
//COLOR MODULE 
//-------------------
//This module controls the color palette of the image and 
//also controls pixel brightness, saturation and hue. 

//* * * * * * *
//1st
//----------
//Sets the color palette of the image to these modes: 
// 1. Hyper Real RGB
// 2. Monochrome
// 3. Color replacement mapping

//Adjust brightness of all pixels
//Adjust saturation of all pixels
//Adjust hue-shift of all pixels
//* * * * * * *


//2nd
//----------
//Tint Functions
// - Overlay of colored shapes
// - Color temperature correction
// - Selective tinting
//DISPLACEMENT MODULE 
//-------------------
//Example
//http://media-cache-ak0.pinimg.com/736x/77/8a/a9/778aa9ce5f9614eb5e373a63e3c74776.jpg
//

//* * * * * * *
//1st
//----------
//Turn alls image pixels into particles in system
//Apply force to particles 
// 1. "Random" force field
//On "reset", return pixels to home position

//2nd
//----------
// // 2. Lava lamp


//3rd
//----------
// 1. Magneto force field
// 2. Expand / Contract

//-----------------------------------------------------------------------------

//Create Pixel Particle system
//Apply force to particle
//Update and display

class DisplacementCloud{
	PixelParticleSystem imageCloud; 
	//Dispersement Mode
	boolean lavaLamp; 
	boolean flockToField; 
	boolean randoWalk; 
	boolean disperse; 


	//CONSTRUCTOR
	DisplacementCloud(PImage inputImage){
		imageCloud = new PixelParticleSystem(inputImage, 1);
		lavaLamp = false; 
		flockToField = false; 
		randoWalk = false; 
		disperse = false;
	}

	//Utility functions to set the disperse mode

	//LAVA LAMP
	public void lavaLamp(boolean state){
		if(state == true){
			lavaLamp = true; 
		}
		if(state == false){
			
		}
		else{
			println("ERROR: Input must be true / false. lavaLamp mode is currently " + lavaLamp + ".");
		}
	}

	public void flockToField(int state){
		if(state >=1){
			flockToField = true; 
		}
		if(state == 0){
			flockToField = false;
		}
		else {
			println("ERROR: Input must be true / false. flockToField mode is currently " + flockToField + ".");
		}
	}

	public void randoWalk(boolean state){
		if(state == true){
			randoWalk = true; 
		}
		if(state == false){
			randoWalk = false; 
		}
		else {
			println("ERROR: Input must be true / false. randoWalk mode is currently " + randoWalk + ".");
		}
	}

	public void disperse(boolean state){
		if(state == true){
			disperse = true; 
		}
		if(state == false){
			disperse = false; 
		}
		else{
			println("ERROR: Input must be true / false. disperse mode is currently " + disperse + ".");
		}
	}

	public void run() {
		imageCloud.run(lavaLamp, flockToField, randoWalk, disperse);
	}




}












//EXPORT UTILITY 
//-------------------
//Saves your artwork into /data. 

class FlowField {
	PVector [] [] field; 
	int cols, rows; 
	int resolution; 

	FlowField(){
		resolution = 10;
		cols = width/resolution; 
		rows = height/resolution; 
		field = new PVector [cols] [rows];

		float xoff = 0;

		init();
	}

	public PVector lookup(PVector lookup){
		int column = PApplet.parseInt(constrain(lookup.x/resolution,0,cols-1));
		int row = PApplet.parseInt(constrain(lookup.y/resolution,0,rows-1));

		return field[column][row].get();
	}


	public void init() {
		float xoff = 0;
		//Initialize force field directions
		for (int i = 0; i < cols; i++){
			float yoff = 0;
			for (int j = 0; j < rows; j++) {
				float theta = map(noise(xoff,yoff),0,1,0,TWO_PI);
				field[i][j] = new PVector(cos(theta),sin(theta));
				yoff += 0.1f;
			}
			xoff += 0.1f;
		}
	}


}
//FOCUS MODULE 
//-------------------
//This module adds gradients and vignettes to help users introduce a 
//point of focus in the image. 


//* * * * * * *
//1st
//----------
//Overlay one or more of these gradients on the iamge: 
// 1. Vignette
// 2. Gradient from bottom
// 3. Gradient from top
// 4. Gradient from left
// 5. Gradient from right

//* * * * * * *



//2nd
//----------
// Selective burn. 
//This utility class gets the pixels[] array of an image that is larger
//than the display window size

//1. Load the image 
//2. Go from left to right
//3. Go row by row
//4. At each point, get the color, 
//5. place into an array containing color info


//THIS IS TOTALLY USELESS
//To do this, just create a PImage, 
//then use pImageName.loadPixels(); 
//This will load the pixels[] array of the image regardless of canvas size!!!!!!!
//GR. 

class GetPixels {
	int numOfPixels;
	int[] imgPixels;

	//CONSTRUCTOR
	GetPixels(PImage inputImage){
		numOfPixels = inputImage.width * inputImage.height; 
		imgPixels = new int[numOfPixels];

		//row by row
		for (int y = 0; y < inputImage.height-1; y++ ){
			//column by column
			for (int x = 1; x < inputImage.width; x++){
				//Calculate current array number
				int currentPixelIndex = (y * testImg.width + x) - 1; //Note -1 for array index
				//Fill with color from image
				imgPixels[currentPixelIndex] = inputImage.get(x, y);
			}
		}

		println("Array initialized.");
	}
}
//IMPORT UTILITY 
//-------------------
//This module allows us to import images. 

//FUNCTIONALITY FOR NOW
//Assume JPG, PNG, TIFF
//Assume ALL sizes
//Assume default - 3264 x 2448
//4:3 


//3rd
//----------
//On user click "import",
// \u00bb Ask which file to import
// \u00bb Get the image and save to PImage object
// \u00bb Save "backup image" into another PImage object
// \u00bb create PGraphic canvas if necessary

//2nd
//----------
//Go to data folder, 
//list available images
//create a PImage object with the image that user has picked
//Save "backup image" into another PImage object
//create PGraphic canvas if necessary

//* * * * * * *
//1st
//----------
//Go get the specified file from /data
//create a PImage object with the image that user has picked
//Save "backup image" into another PImage object
//create PGraphic canvas if necessary

//Display options
// - Tile, repeat 
// - Tile, reflect
// - Stretch, retain aspect ratio
// - Stretch, fill screen
// - border 
//* * * * * * *
//RECURSIVE MODULE 
//-------------------
//Examples
//http://media-cache-ak0.pinimg.com/736x/dc/a5/4f/dca54fc9a861db35ab198ad37053b253.jpg
//http://media-cache-ec0.pinimg.com/736x/55/aa/1a/55aa1ae54d981291f0a2a4c7a72f4719.jpg

//* * * * * * *
//1st
//----------
//Copy the image,
//translate canvas (x, y) 
//rotate canvas 
//and paste image back on to the canvas

//exit condition < define later
//rotation, x & y decay conditions 

//Set blend mode and opacity to correlate to number of iteration
//RESET UTILITY 
//-------------------
//Removes all glitch effects and displays original image. 
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "main" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
