


class PixelParticle {
	PVector home; //Original location in the image
	PVector location; 
	PVector velocity; 
	PVector friction; 
	float mass; 

	float maxForce;
	float maxSpeed;

	color c; 
	boolean isDead;

	//Constructor
	PixelParticle( PImage motherImg, int x, int y) {
		home = new PVector(x, y);
		location = home; 
		velocity = new PVector(0,0); 
		friction = new PVector(0,0); 
		mass = 1; 

		maxForce = 8; 
		maxSpeed = 0.2; 

		c =  motherImg.get(x, y);
		isDead = false;
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

	void display(){
		set(int(location.x), int(location.y), c);
		updatePixels();
	}

	void offScreenCheck(){
		if (location.x < 0 || location.y < 0 || location.x > width || location.y > height){
			isDead = true;
		}
	}

	void steerHome(){
		PVector desired = PVector.sub(home, location);
		desired.limit(2);
		PVector steer = PVector.sub(desired, velocity);
		steer.limit(maxForce);
		applyForce(steer);
	}

	void disperse(){
		randoWalk();
		offScreenCheck();
		display();
	}

	void goHome(){
		steerHome();
		offScreenCheck();
		display();
	}

	//THESE FUNCTION STEER THE PARTICLE DEPENDING ON FILTER STATUS
	void flockToField(FlowField flowField){
		PVector desired = flowField.lookup(location);
		desired.mult(maxSpeed);

		PVector steer = PVector.sub(desired, velocity);
		steer.limit(maxForce);
		applyForce(steer);
	}

	void updateParticle(boolean lavaLamp, boolean flockToField, FlowField flowField, boolean randoWalk, boolean disperse){
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

	void run(boolean lavaLamp, boolean flockToField, FlowField flowField, boolean randoWalk, boolean disperse){
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

	void oldRun(){ //THIS NEEDS TO BE REMOVED
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
	void run(boolean lavaLamp, boolean flockToField, boolean randoWalk, boolean disperse){
		for (int i = pixelCloud.size()-1; i > 0 ; i--){
			PixelParticle currentPixel = pixelCloud.get(i);
			currentPixel.run( lavaLamp, flockToField, flowField, randoWalk, disperse);
		}
	}
}











