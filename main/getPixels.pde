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
	color[] imgPixels;

	//CONSTRUCTOR
	GetPixels(PImage inputImage){
		numOfPixels = inputImage.width * inputImage.height; 
		imgPixels = new color[numOfPixels];

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