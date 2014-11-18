	


class PixelParticle {
	PVector home; //Original location in the image
	PVector location; 
	PVector velocity; 
	PVector friction; 
	
	float mass; 

	float maxForce;
	float maxSpeed;
	float maxForceGoHome;
	float maxSpeedGoHome;
	
	color c; 
	boolean isOffCanvas;

	//Constructor
	PixelParticle( PImage motherImg, int x, int y) {

		home = new PVector(x, y);
		location = home; 
		velocity = new PVector(0,0); 
		friction = new PVector(0,0); 
		mass = 1; 

		maxForce = 8; 
		maxForceGoHome = 80; 
		maxSpeed = 0.6; 
		maxSpeedGoHome = 12.0; 

		c =  motherImg.get(x, y);
		isOffCanvas = false;
	}

	void randoWalk(){
		PVector randoV = PVector.random2D();
		randoV.limit(0.3);
		applyForce(randoV);
	}

	void applyForce(PVector acceleration){
		velocity = PVector.add(velocity, acceleration, friction);
		velocity.limit(maxSpeed);
		location = PVector.add(location, velocity); 
	}

	void applyForceGoHome(PVector acceleration){
		velocity = PVector.add(velocity, acceleration, friction);
		velocity.limit(maxSpeedGoHome);
		location = PVector.add(location, velocity); 
	}

	void display( float translateX, float translateY ){
		loopScreenEdges(translateX, translateY);
		//loopScreenEdges();

		//x @ 0 - translateX ; then set x to width - translateX
		//x @ at width - translateX ; then set x to 0 - translateX 
		//y @ - translateY ; then set y to height - translateY

		set(int(location.x + translateX), int(location.y + translateY), c);
		//set(int(location.x ), int(location.y ), c);
		updatePixels();
	}

	void offScreenCheck(){
		if (location.x < 0 || location.y < 0 || location.x > width || location.y > height){
			isOffCanvas = true;
		}
	}

	void loopScreenEdges( float translateX, float translateY ){

		if (location.x < 0 - translateX + 100 ){
			location.x = width - translateX - 100;
			return;
		}

		if (location.x > width - translateX -100){
			location.x = 0 - translateX + 100;
			return;
		}
		if (location.y < 0 - translateY + 100){
			location.y = height / 2 - translateY;
			return;
		}
		if (location.y > height - translateY - 100){
			location.y = height / 2 - translateY;
			return;
		}
	}

	void steerHome(){
		PVector desired = PVector.sub(home, location);
		desired.limit(2);
		PVector steer = PVector.sub(desired, velocity);
		steer.limit(maxForceGoHome);
		applyForceGoHome(steer);
	}

	void disperse(){
		randoWalk();
		offScreenCheck();
	}

	void goHome(){
		steerHome();
		offScreenCheck();
	}

	//THESE FUNCTION STEER THE PARTICLE DEPENDING ON FILTER STATUS
	void flockToField(FlowField flowField){
		PVector desired = flowField.lookup(location);
		desired.mult(maxSpeed);

		PVector steer = PVector.sub(desired, velocity);
		steer.limit(maxForce);
		applyForce(steer);
	}

	void updateParticle(boolean lavaLamp, boolean flockToField, FlowField flowField, boolean randoWalk, boolean disperse, boolean goHome){
		//Apply forces depending on which filters have been applied
		if (goHome == true){
			goHome();
		}
		else {
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
		}
		//THIS DOES NOT DISPLAY THE PARTICLE
	}

	void run(boolean lavaLamp, boolean flockToField, FlowField flowField, boolean randoWalk, boolean disperse, boolean goHome){
		updateParticle( lavaLamp, flockToField, flowField, randoWalk, disperse, goHome);
	}

}

class PixelParticleSystem {
	ArrayList<PixelParticle> pixelCloud; 
	PGraphics sketchPad; //Particles get "set()" here then drawn to canvas, so that "translate()" in the main canvas works
	boolean disperse; //If true, particle disperse, if false, particle return home.

	//TO MAKE TRANSLATE COMPATIBLE 
	float translateX; 
	float translateY; 

	//These support flockToField 
	FlowField flowField; 


	PixelParticleSystem(PImage inputImage, float resolution){
		float resConstrain = constrain(resolution, 1, inputImage.width/2);
		sketchPad = createGraphics(width, height);
		pixelCloud = new ArrayList<PixelParticle>(); 
		disperse = false;
		flowField = new FlowField(); 
		inputImage.loadPixels();

		translateX = 0; 
		translateY = 0; 

		for (int i = 0; i < inputImage.pixels.length; i++){
			
			int x; 
			int y;
			if (i < inputImage.width){
				x = i;
				y = 1;
			}
			else {
				x = i % inputImage.width;
				y = int(i / inputImage.width);
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

	void goHome(){
		for (int i = pixelCloud.size()-1; i > 0 ; i--){
			PixelParticle currentPixel = pixelCloud.get(i);
			currentPixel.goHome();
		}
	}	

	void run(boolean lavaLamp, boolean flockToField, boolean randoWalk, boolean disperse, boolean goHome){
		for (int i = pixelCloud.size()-1; i > 0 ; i--){
			PixelParticle currentPixel = pixelCloud.get(i);
			currentPixel.run( lavaLamp, flockToField, flowField, randoWalk, disperse, goHome);
			currentPixel.display( translateX, translateY );
		}
		//image(sketchPad, 0, 0);
	}

	void translate(float x, float y){
		translateX = x; 
		translateY = y; 
	}
}











