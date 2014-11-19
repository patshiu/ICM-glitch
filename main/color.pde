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

//NEW 1st
//--------- 
//Displace color wheel

class Huemixx {

	PImage originalImage; 
	PImage canvasImage; 
	PGraphics canvas; 
	boolean isOn;
	float hueDisplacement; 

	//constructor
	Huemixx(PImage inputImage){
		originalImage = inputImage; 
		canvasImage = inputImage; 
		isOn = true;
		canvas = createGraphics(inputImage.width, inputImage.height);
		hueDisplacement = 0; //init to zero 
	}

	void updateImg(PImage inputImage){
		originalImage = inputImage; 
		canvasImage = inputImage; 
		canvas = createGraphics(inputImage.width, inputImage.height);
	}

	void run(){
		if (isOn == true){
			canvasImage.updatePixels();
			canvas.image(canvasImage, 0, 0);
			//hue shift
			canvas.endDraw();
			image(canvas, 0, 0);
		}
	}

	void updateGlitchParams(){
		hueDisplacement = map(huemixxGlitchness.sliderValue, 0, 255, 0, 30); 
		canvas.beginDraw();
		canvasImage.loadPixels();
		colorMode(HSB, 360, 255, 255);
		for (int i = 0; i< canvasImage.pixels.length - 1; i++){
			float thisHue = hue(canvasImage.pixels[i]);
			float thisBrightness = brightness(canvasImage.pixels[i]);
			float thisSaturation = saturation(canvasImage.pixels[i]);
			float nextHue = (thisHue + hueDisplacement) % 360; 
			canvasImage.pixels[i] = color( nextHue, thisBrightness, thisSaturation );
		}
	}

}





