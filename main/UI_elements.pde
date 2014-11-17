//GUI element classes
//-------------------
//Button & Slider class defined here



//TO FIX : YOUR LOGIC FOR move() IS FUCKED!!! FIX THIS

class Btn {
	PImage state1; 
	PImage state2; 
	PGraphics btnCanvas; 
	boolean isUnderCursor; 
	float locX; 
	float locY; 

	Btn(String stateALoc , String stateBLoc){
		state1 = loadImage(stateALoc); 
		state2 = loadImage(stateBLoc); 
		locX = 0; 
		locY = 0; 
		btnCanvas = createGraphics(state1.width, state1.height);
	}

	Btn(String stateALoc){
		state1 = loadImage(stateALoc); 
		state2 = loadImage(stateALoc); 
		locX = 0; 
		locY = 0; 
		btnCanvas = createGraphics(state1.width, state1.height);
	}

	PGraphics show(){
		btnCanvas.beginDraw();
		btnCanvas.image(state1, 0, 0);
		btnCanvas.endDraw();
		return btnCanvas; 
	}

	void setCanvasLoc(float x, float y) {
		locX = x; 
		locY = y;
	}

	boolean isUnderCursor() {
		if( mouseX >= locX && mouseX <= (locX + state1.width) && mouseY >= locY && mouseY <= (locY + state1.height)){
			return true; 
		} else {
			return false;
		}
	}
}

class ToggleBtn {
	boolean isOn; 
	PImage btnOn; 
	PImage btnOff;
	PGraphics toggleBtnCanvas;
	boolean isUnderCursor; 
	float locX; 
	float locY; 


	ToggleBtn(boolean initState, float x, float y) {
		isOn = initState; 
		btnOn = loadImage("btn_toggle_ON.png");
		btnOff = loadImage("btn_toggle_OFF.png");
		locX = x; 
		locY = y; 
		toggleBtnCanvas = createGraphics(btnOn.width, btnOn.height); 
		isUnderCursor = false; 
	}

	void toggle() {

		//Check if the mouse click is on the object. 
		if (isOn == true){
			isOn = false;
			return; 
		}
		if (isOn == false){
			isOn = true;
			return; 
		}
	}

	PGraphics show(){ //THIS RETURNS A PGRAPHICS
		toggleBtnCanvas.beginDraw();
		toggleBtnCanvas.clear();
		if( isOn == true){
			toggleBtnCanvas.image(btnOn, 0, 0);
		}
		else {
			toggleBtnCanvas.image(btnOff, 0, 0);
		}
		toggleBtnCanvas.endDraw();
		return toggleBtnCanvas;
	}


	void setCanvasLoc(float x, float y) {
		locX = x; 
		locY = y;
	}


	Boolean isUnderCursor() {
		if( mouseX >= locX && mouseX <= (locX + btnOn.width) && mouseY >= locY && mouseY <= (locY + btnOn.height)){
			return true; 
		} else {
			return false;
		}
	}
}

//SLIDER
//Have a value that is constrained to a range
//When user clicks and drags on the object, move the slider btn image, update the value stored

class Slider {
	float sliderValue; 
	PImage sliderBtn; 
	PImage sliderLine;
	PGraphics sliderCanvas;
	boolean isUnderCursor; 
	float locX; 
	float locY; 
	float locBtn;

	Slider(float initVal, float x, float y ){
		sliderValue = constrain(initVal, 0, 255); //This constrains the slider's value 0 - 255
		sliderBtn = loadImage("slider_btn.png");
		sliderLine = loadImage("slider_bg_black.png");
		locX = x; 
		locY = y; 
		locBtn = constrain(sliderValue, 15, sliderLine.width - sliderBtn.width - 15); 
		sliderCanvas = createGraphics(sliderLine.width, sliderLine.height);
		isUnderCursor = false; 
	}

	void setValue(float input){

		//If mouse press is valid, then move sliderBtn to the correct location on slider
		//Update "sliderValue" to match, using map on 
		float valueIn = input - locX; //convert MouseX to pos of mouse on slider
		locBtn = constrain(valueIn, 15, sliderLine.width - sliderBtn.width - 15); //Calculate the position of the sliderbutton (from edge of slider)
		sliderValue = map(locX + locBtn, locX + 15, locX + sliderLine.width - sliderBtn.width - 15, 0, 255);

	}

	void setCanvasLoc(float x, float y) {
		locX = x; 
		locY = y;
	}

	PGraphics show(){ //THIS RETURNS A PGRAPHICS
		sliderCanvas.beginDraw();
		sliderCanvas.clear();
		sliderCanvas.image(sliderLine, 0, 0);
		sliderCanvas.image(sliderBtn, locBtn, 0);
		sliderCanvas.endDraw();
		return sliderCanvas;
	}

	boolean isUnderCursor() {
		if( mouseX >= locX && mouseX <= (locX + sliderLine.width) && mouseY >= locY && mouseY <= (locY + sliderLine.height) ) {
			return true; 
		} else {
			return false;
		}
	}

}