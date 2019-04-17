final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

int groundhogX, groundhogY, groundhogSpeed;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

final int SQUARE_UNIT=80;
 
PImage life, title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage bg, soil0, soil1, soil2, soil3, soil4, soil5;
PImage GroundhogIdle, groundhogLeft, groundhogRight, groundhogDown;

// For debug function; DO NOT edit or remove this!
int playerHealth = 0;
float cameraOffsetY = 0;
boolean debugMode = false;

// moving
boolean downPressed=false;
boolean leftPressed=false;
boolean rightPressed=false;

// grounghog image
boolean groundhogIdle=true;

void setup() {
	size(640, 480, P2D);
	// Enter your setup code here (please put loadImage() here or your game will lag like crazy)
	bg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
	gameover = loadImage("img/gameover.jpg");
	startNormal = loadImage("img/startNormal.png");
	startHovered = loadImage("img/startHovered.png");
	restartNormal = loadImage("img/restartNormal.png");
	restartHovered = loadImage("img/restartHovered.png");
soil0 = loadImage("img/soil0.png");
soil1 = loadImage("img/soil1.png");
soil2 = loadImage("img/soil2.png");
soil3 = loadImage("img/soil3.png");
soil4 = loadImage("img/soil4.png");
soil5 = loadImage("img/soil5.png");
life = loadImage("img/life.png");
GroundhogIdle = loadImage("img/groundhogIdle.png");
groundhogLeft =loadImage("img/groundhogLeft.png");
groundhogRight =loadImage("img/groundhogRight.png");
groundhogDown = loadImage("img/groundhogDown.png");

 //groundhog
  groundhogX=SQUARE_UNIT*4;
  groundhogY=SQUARE_UNIT;
  groundhogSpeed+=80/16; 
}

void draw() {
    /* ------ Debug Function ------ 

      Please DO NOT edit the code here.
      It's for reviewing other requirements when you fail to complete the camera moving requirement.

    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    /* ------ End of Debug Function ------ */

    
	switch (gameState) {

		case GAME_START: // Start Screen
		image(title, 0, 0);

		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(startHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
			}

		}else{

			image(startNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;

		case GAME_RUN: // In-Game

		// Background
		image(bg, 0, 0);

		// Sun
	    stroke(255,255,0);
	    strokeWeight(5);
	    fill(253,184,19);
	    ellipse(590,50,120,120);

		// Grass
		fill(124, 204, 25);
		noStroke();
		rect(0, 160 - GRASS_HEIGHT, width, GRASS_HEIGHT);

		// Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
		float spacing =80;

int x = 0;
while(x<4){
for(float soil0X=0; soil0X< width; soil0X+=spacing){
  image(soil0,soil0X,spacing*2);
 x++;}}

while(x<4){
for(float soil1X=0; soil1X<width; soil1X+=spacing){
  image(soil1,soil1X,spacing*6);
 x++;}}

while(x<4){
for(float soil2X=0; soil2X<width; soil2X+=spacing){
  image(soil2,soil2X,spacing*10);
 x++;}}

while(x<4){
for(float soil3X=0; soil3X<width; soil3X+=spacing){
  image(soil1,soil3X,spacing*14);
 x++;}}

while(x<4){
for(float soil4X=0; soil4X<width; soil4X+=spacing){
  image(soil1,soil4X,spacing*18);
 x++;}}

while(x<4){
for(float soil5X=0; soil5X<width; soil5X+=spacing){
  image(soil1,soil5X,spacing*22);
 x++;}}
		
// Grounghog movement
    
    if(groundhogIdle){
      image(GroundhogIdle,groundhogX,groundhogY);
    }
    
    if(downPressed){
      groundhogIdle=false;
      image(groundhogDown,groundhogX,groundhogY);
      leftPressed= false;
      rightPressed= false;
      groundhogY+=groundhogSpeed;
      if(groundhogY%80==0){
        downPressed= false;
        groundhogIdle=true;
        }
    }
    if(leftPressed){
      groundhogIdle=false;
      image(groundhogLeft,groundhogX,groundhogY);
      downPressed= false;
      rightPressed= false;
      groundhogX-=groundhogSpeed;
      if(groundhogX%80==0){
        leftPressed= false;
        groundhogIdle=true;
        }
    }
    if(rightPressed){
      groundhogIdle=false;
      image(groundhogRight,groundhogX,groundhogY);
      leftPressed= false;
      downPressed= false;
      groundhogX+=groundhogSpeed;
      if(groundhogX%80==0){
        rightPressed= false;
        groundhogIdle=true;
        }
    }
    
    // Grounghog boundary detection
    if(groundhogX<0){
      leftPressed= false;
      groundhogIdle=true;
      groundhogX=0;
    }
    if(groundhogX>width-SQUARE_UNIT){
      rightPressed= false;
      groundhogIdle=true;
      groundhogX=width-SQUARE_UNIT;
    }
    if(groundhogY>height-SQUARE_UNIT){
      downPressed= false;
      groundhogIdle=true;
      groundhogY=height-SQUARE_UNIT;
    }

// Player

		// Health UI
float lifeBlankSpace = 70;
for(float i=0; i<2; i+=lifeBlankSpace){
  image(life,10,10);
}
		break;

		case GAME_OVER: // Gameover Screen
		image(gameover, 0, 0);
		
		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
				// Remember to initialize the game here!
			}
		}else{

			image(restartNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;
		
	}

    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
        popMatrix();
    }
}

void keyPressed(){
	// Add your moving input code here

   if (key == CODED) {
    switch (keyCode) {
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
    }
  }

	// DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){
      case 'w':
      debugMode = true;
      cameraOffsetY += 25;
      break;

      case 's':
      debugMode = true;
      cameraOffsetY -= 25;
      break;

      case 'a':
      if(playerHealth > 0) playerHealth --;
      break;

      case 'd':
      if(playerHealth < 5) playerHealth ++;
      break;
    }
}

void keyReleased(){
   
}
