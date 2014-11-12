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
	boolean goHome; 


	//CONSTRUCTOR
	DisplacementCloud(PImage inputImage){
		imageCloud = new PixelParticleSystem(inputImage, 2);
		lavaLamp = false; 
		flockToField = false; 
		randoWalk = false; 
		disperse = false;
	}

	//Utility functions to set the disperse mode

	//LAVA LAMP
	void lavaLamp(boolean state){
		if(state == true){
			lavaLamp = true; 
		}
		if(state == false){
			lavaLamp = false; 
		}
		else {
			println("ERROR: Input must be true / false. lavaLamp mode is currently " + lavaLamp + ".");
		}
	}

	void flockToField(boolean state){
		if(state == true ){
			flockToField = true; 
			println("This was executed.");
		}
		if(state == false ){
			flockToField = false;
		}
		else {
			println("ERROR: Input must be true / false. flockToField mode is currently " + flockToField + ".");
		}
	}

	void randoWalk(boolean state){
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

	void disperse(boolean state){
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

	void goHome(boolean state){
		if(state == true){
			goHome = true;
			lavaLamp = false; 
			flockToField = false; 
			randoWalk = false; 
			disperse = false; 
		}
		if(state == false){
			goHome = false;
		}
		else{
			println("ERROR: Input must be true / false. goHome mode is currently " + goHome + ".");
		}
	}

	void run() {
		imageCloud.run(lavaLamp, flockToField, randoWalk, disperse, goHome);
	}

	//UTILITY FUNCTION TO HELP TRANSLATE WORK
	void translate(float x, float y){
		imageCloud.translate(x, y);

	}




}












