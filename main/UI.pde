//UTILITY MODULE - GUI 
//-------------------
//This module creates a GUI for this image glitching app. 

//This adds the top bar

int headerHeight = 10 + 44 + 15; // Top Padding + button height + Bottom Padding
float headerPos = 0; 
boolean headerInFull = true;
PGraphics headerBar; //NOTE: This MUST be declared in setup 

int sidebarWidth = 300; 
float sidebarPos; 
boolean sidebarInFull = true; 
PGraphics sidebar; 

//Elements for header
Btn importBtn;
Btn resetBtn; 
Btn pauseBtn; 
Btn exportBtn; 

//Elements for drift glitch
ToggleBtn driftToggle; 

//Elements for square glitch
ToggleBtn squareGlitchOnOff; 
Slider squareGlitchSize; 
Slider squareGlitchAspect; 

void drawUI(){
	addHeader();
	addSidebar();
}




//This adds the top bar
void addHeader(){
	if (headerBar == null){
		headerInit();
	}
	headerBar.beginDraw();
	headerBar.fill(50, 50, 50);
	headerBar.rect(0, 0, width, headerHeight); 
	headerBar.rect(10,5, 300, 38); //Holder for logo
	
	//Import btn
	headerBar.image(importBtn.show(), width - importBtn.state1.width - 20 - resetBtn.state1.width - 20 - pauseBtn.state1.width - 20 - exportBtn.state1.width - 10, 10);
	importBtn.setCanvasLoc(width - importBtn.state1.width - 20 - resetBtn.state1.width - 20 - pauseBtn.state1.width - 20 - exportBtn.state1.width - 10, headerPos + 10);

	//Reset btn
	headerBar.image(resetBtn.show(), width - resetBtn.state1.width - 20 - pauseBtn.state1.width - 20 - exportBtn.state1.width - 10, 10);
	resetBtn.setCanvasLoc(width - resetBtn.state1.width - 20 - pauseBtn.state1.width - 20 - exportBtn.state1.width - 10, headerPos + 10);

	//Pause btn
	headerBar.image(pauseBtn.show(), width - pauseBtn.state1.width - 20 - exportBtn.state1.width - 10, 10);
	pauseBtn.setCanvasLoc(width - pauseBtn.state1.width - 20 - exportBtn.state1.width - 10, headerPos - 10);
	
	//Export btn
	headerBar.image(exportBtn.show(), width - exportBtn.state1.width - 10, 10);
	exportBtn.setCanvasLoc(width - exportBtn.state1.width - 10, headerPos - 10);
	
	headerBar.endDraw();
	displayHeader();
}

void headerInit(){
	headerBar = createGraphics(width, headerHeight); //Set up header canvas
	importBtn = new Btn("btn_import.png");
	resetBtn = new Btn("btn_reset.png");
	pauseBtn = new Btn("btn_pause.png");
	exportBtn = new Btn("btn_export.png");
}

//This hides / unhides the header
void toggleHeader(){
	if (headerInFull == true) {
		headerInFull = false;
		println("Header is now gonna be hiding.");
		return;
	}
	if (headerInFull == false) {
		headerInFull = true; 
		println("Header is now gonna be in full.");
		return;
	}
}

void displayHeader(){
	//Make the header hide
	if (headerInFull == false){
		if (headerPos > -48){
			headerPos-= 5 + ( abs(headerPos) - 48 / 10); 
			constrain(headerPos, 0, -48);
		}
		image(headerBar, 0, headerPos, width, headerHeight);
		return;
	}
	//Made the header show
	if (headerInFull == true){
		if (headerPos < 0){
			headerPos += 5 + ( abs(headerPos) / 10); 
			constrain(headerPos, 0, -48);
		}
		image(headerBar, 0, headerPos, width, headerHeight);
		return;
	}
}


//This adds the sidebar control panel 
void addSidebar(){
	if (sidebar == null){
		initSidebar();
	}
	sidebar.beginDraw();
	sidebar.fill(255, 0, 0);
	sidebar.rect( 0, 0, sidebarWidth, sidebar.height);
	sidebar.fill( 0, 0, 255); //Holder for filter settings
	sidebar.rect( 10, 20, sidebarWidth-20, 400);

	//Adding squareGlitchToggle
	sidebar.image(squareGlitchOnOff.show(), 0, 40);
	squareGlitchOnOff.setCanvasLoc( 0 + sidebarPos , 40 + headerHeight + 10);

	//Adding squareGlitchAspect slider
	sidebar.image(squareGlitchAspect.show(),20, 90);
	squareGlitchAspect.setCanvasLoc( 20 + sidebarPos , 90 + headerHeight + 10);
	

	//Adding squareGlitchSize slider
	sidebar.image(squareGlitchSize.show(), 20, 130);
	squareGlitchSize.setCanvasLoc( 20 + sidebarPos , 130 + headerHeight + 10); 
	
	//Adding driftGlitch toggle
	sidebar.image(driftToggle.show(), 0, 200);
	driftToggle.setCanvasLoc( 0 + sidebarPos , 200 + headerHeight + 10);


	sidebar.rect( 10, 20 + 400 + 10, sidebarWidth-20, 400);
	sidebar.endDraw();
	displaySidebar();
	
}

void initSidebar() { //sets up sidebar
	//set up sidebar canvas
	sidebar = createGraphics(sidebarWidth, height - headerHeight - 20); 
	sidebarPos = width - sidebarWidth;

	//set up all the control elements
	//Elements for Drift Glitch
	driftToggle = new ToggleBtn(true, 0, 0);

	//Elements for Square Glitch
	squareGlitchOnOff = new ToggleBtn(true, 0, 0);
	squareGlitchSize = new Slider(100, 0, 0); //Make sure slider inits with right button position
	squareGlitchAspect = new Slider(50, 0, 0);

}

void toggleSidebar() {
	if (sidebarInFull == true) {
		sidebarInFull = false;
		println("Sidebar is now gonna be hiding.");
		return;
	}
	if (sidebarInFull == false) {
		sidebarInFull = true; 
		println("Sidebar is now gonna be in full.");
		return;
	}
}

void displaySidebar() {
	//Make the sidebar hide
	if (sidebarInFull == false){
		if (sidebarPos < width){
			sidebarPos+= 5 + (abs(width - sidebarPos) / 10);
			constrain(sidebarPos, width - sidebarWidth, width);
		}
		image(sidebar, sidebarPos, headerHeight + 10);
		return;
	}
	//Made the sidebar show | decrease width to width-sidebarWidth
	if (sidebarInFull == true){
		if (sidebarPos > (width - sidebarWidth) ){
			sidebarPos -= 5 + (abs((width - sidebarWidth) - sidebarPos) / 10);
			constrain(sidebarPos, width - sidebarWidth, width);
		}
		image(sidebar, sidebarPos, headerHeight + 10);
		return;
	}
}


