//UTILITY MODULE - GUI 
//-------------------
//This module creates a GUI for this image glitching app. 

//This adds the top bar

int headerHeight = 10 + 44 + 15; // Top Padding + button height + Bottom Padding
float headerPos = 0; 
boolean headerInFull = true;
PGraphics headerBar; //NOTE: This MUST be declared in setup 

int sidebarWidth = 320; 
float sidebarPos; 
boolean sidebarInFull = true; 
PGraphics sidebar; 

//Elements for header
PImage logo; 
PImage headerBg; 
Btn importBtn;
Btn resetBtn; 
Btn pauseBtn; 
Btn exportBtn; 

//Elements for sidebar
PImage sidebarBg; 
PImage sidebarDiv; 
PImage toggleInstructions; 


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
	headerBar.rect(0, 0, width, headerHeight); //Draw header background color, in case background image does not loga
	headerBar.image(headerBg, 0, 0, width, headerHeight);
	headerBar.image(logo, 100, 15);
	//headerBar.rect(10,5, 300, 38); //Holder for logo

	//Notification
/*	headerBar.textSize(12);//Setting text for label. Proxima Nova Semibold 16px
	headerBar.textAlign(RIGHT, TOP);
	headerBar.textFont(ProximaNovaLight);
	headerBar.text(notification, 20 + squareGlitchOnOff.btnOn.width + 10 + 200, 220 + 2);//Label; 4px added to 2 to adjust label baseline
	headerBar.image(driftToggle.show(), 20, 220);*/
	
	//Import btn
	headerBar.image(importBtn.show(), width - importBtn.state1.width - 20 - resetBtn.state1.width - 20 - pauseBtn.state1.width - 20 - exportBtn.state1.width - 45, 10);
	importBtn.setCanvasLoc(width - importBtn.state1.width - 20 - resetBtn.state1.width - 20 - pauseBtn.state1.width - 20 - exportBtn.state1.width - 45, headerPos + 10);

	//Reset btn
	headerBar.image(resetBtn.show(), width - resetBtn.state1.width - 20 - pauseBtn.state1.width - 20 - exportBtn.state1.width - 45, 10);
	resetBtn.setCanvasLoc(width - resetBtn.state1.width - 20 - pauseBtn.state1.width - 20 - exportBtn.state1.width - 45, headerPos + 10);

	//Pause btn
	headerBar.image(pauseBtn.show(), width - pauseBtn.state1.width - 20 - exportBtn.state1.width - 45, 10);
	pauseBtn.setCanvasLoc(width - pauseBtn.state1.width - 20 - exportBtn.state1.width - 45, headerPos - 10);
	
	//Export btn
	headerBar.image(exportBtn.show(), width - exportBtn.state1.width - 45, 10);
	exportBtn.setCanvasLoc(width - exportBtn.state1.width - 45, headerPos - 10);
	
	headerBar.endDraw();
	displayHeader();
}

void headerInit(){
	headerBar = createGraphics(width, headerHeight); //Set up header canvas
	logo = loadImage("slice_logo.png");
	headerBg = loadImage("slice_header_background.png");
	importBtn = new Btn("slice_btn_import.png");
	resetBtn = new Btn("slice_btn_reset.png");
	pauseBtn = new Btn("slice_btn_pause.png");
	exportBtn = new Btn("slice_btn_export.png");
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
	sidebar.fill(#2b2b2b);
	sidebar.stroke(#ff00e6); //Magenta stroke
	sidebar.rect( 1, 1, sidebarBg.width -1, sidebarBg.height -10); //Draw a background in case sidebarBg image does not load
	sidebar.image(sidebarBg, 0, 0, sidebarBg.width, sidebarBg.height);
	
	///Add background
	sidebar.fill(255, 25);
	sidebar.noStroke();
	sidebar.rect(10,15, sidebarBg.width - 10*2, 20 + 90);

	//Adding squareGlitchToggle
	sidebar.fill(255);
	sidebar.textSize(16);//Setting text for label. Proxima Nova Semibold 16px
	sidebar.textAlign(LEFT, TOP);
	sidebar.textFont(ProximaNovaBold);
	sidebar.text("PIXELITE", 20 + squareGlitchOnOff.btnOn.width + 10, 40 + 2);//Label; 4px added to 2 to adjust label baseline
	sidebar.image(squareGlitchOnOff.show(), 20, 40);
	squareGlitchOnOff.setCanvasLoc( 20 + sidebarPos , 40 + headerHeight + 10);

	//Adding squareGlitchAspect slider
	// sidebar.fill(255);
	// sidebar.textAlign(LEFT, TOP);
	// sidebar.textFont(ProximaNovaLight);
	// sidebar.textSize(10);//Setting text for label. Proxima Nova Semibold 16px
	// sidebar.text("GLITCH ASPECT RATIO", 20 + squareGlitchOnOff.btnOn.width + 10 , 100 - 20);//Label; 4px added to 2 to adjust label baseline
	// sidebar.image(squareGlitchAspect.show(),20 + squareGlitchOnOff.btnOn.width + 10 , 100);
	// squareGlitchAspect.setCanvasLoc( 20 + squareGlitchOnOff.btnOn.width + 10 + sidebarPos , 100 + headerHeight + 10);
	

	//Adding squareGlitchSize slider
	// sidebar.fill(255);
	// sidebar.textAlign(LEFT, TOP);
	// sidebar.textFont(ProximaNovaLight);
	// sidebar.textSize(10);//Setting text for label. Proxima Nova Semibold 16px
	// sidebar.text("GLITCH MIN SIZE", 20 + squareGlitchOnOff.btnOn.width + 10 , 80 - 20);//Label; 4px added to 2 to adjust label baseline
	sidebar.image(squareGlitchSize.show(), 20 + squareGlitchOnOff.btnOn.width + 10 , 80);
	squareGlitchSize.setCanvasLoc( 20 + squareGlitchOnOff.btnOn.width + 10  + sidebarPos , 80 + headerHeight + 10); 

	//Adding a divider
	sidebar.image(sidebarDiv, 20, 200);
	
	//Adding driftGlitch toggle
	sidebar.textSize(16);//Setting text for label. Proxima Nova Semibold 16px
	sidebar.textAlign(LEFT, TOP);
	sidebar.textFont(ProximaNovaBold);
	sidebar.text("DRIFT", 20 + squareGlitchOnOff.btnOn.width + 10, 220 + 2);//Label; 4px added to 2 to adjust label baseline
	sidebar.image(driftToggle.show(), 20, 220);
	driftToggle.setCanvasLoc( 20 + sidebarPos , 220 + headerHeight + 10);

	//Adding a divider
	sidebar.image(sidebarDiv, 20, 260);

	//Adding the instructions to toggle control panel hiding
	sidebar.image(toggleInstructions, 20, 280);

	//More filters coming soon notice
	sidebar.fill(#5a5a5a);
	sidebar.textSize(12);//Setting text for label. Proxima Nova Light 12px
	sidebar.textAlign(LEFT, BOTTOM);
	sidebar.textFont(ProximaNovaLight);
	sidebar.text("MORE FILTERS COMING SOON", 20, sidebarBg.height - 30);//Label aligned to bottom, to be 30px away from bottom of sidebar
	sidebar.endDraw();
	displaySidebar();
	
}

void initSidebar() { //sets up sidebar

	//set up sidebar PImages
	sidebarBg = loadImage("slide_sidebar_background.png");
	sidebarDiv = loadImage("slice_sidebar_divider.png");
	toggleInstructions = loadImage("slice_toggle_instructions.png");

	//set up sidebar canvas
	//sidebar = createGraphics(sidebarWidth, height - headerHeight - 20); //Set height dynamically to canvas height
	sidebar = createGraphics(sidebarBg.width, sidebarBg.height);
	sidebarPos = width - sidebarWidth;

	//set up all the control elements
	//Elements for Drift Glitch
	driftToggle = new ToggleBtn(true, 0, 0);

	//Elements for Square Glitch
	squareGlitchOnOff = new ToggleBtn(true, 0, 0);
	squareGlitchSize = new Slider(0, 0, 0); //Make sure slider inits with right button position
	squareGlitchAspect = new Slider(0, 0, 0);

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


