final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;
int SQUARE_UNIT=80; 
float groundhogX=SQUARE_UNIT*4, groundhogY=SQUARE_UNIT;
float soilOffset=0;
float soldierX=-80; float soldierY;
float cabbageX, cabbageY;
final int grassHeight = 15;

final int START_BUTTON_W = 144,START_BUTTON_H = 60,START_BUTTON_X = 248, START_BUTTON_Y = 360;
final int STOP=0; final int LEFTWARD=1;final int DOWNWARD=2; final int RIGHTWARD=3;
int movement=STOP;

PImage bg, life, soil8x24, soldier, cabbage;
PImage groundhog;
PImage title, GameOver, StartNormal, StartHovered;
PImage RestartNormal, RestartHovered;
PImage soilImage[] = new PImage[6];
PImage stone1, stone2;

// For debug function; DO NOT edit or remove this!
int initialLife = 0;
float cameraOffsetY = 0;
boolean debugMode = false;
boolean rollup=false;

void setup() {
  size(640, 480, P2D);
  // Enter your setup code here (please put loadImage() here or your game will lag like crazy)
  bg = loadImage("img/bg.jpg");
  title = loadImage("img/title.jpg");
  GameOver = loadImage("img/gameover.jpg");
  StartNormal = loadImage("img/startNormal.png");
  StartHovered = loadImage("img/startHovered.png");
  RestartNormal = loadImage("img/restartNormal.png");
  RestartHovered = loadImage("img/restartHovered.png");
  soil8x24 = loadImage("img/soil8x24.png");
  groundhog = loadImage("img/groundhogIdle.png");
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");
  life = loadImage("img/life.png");
  soldier = loadImage("img/soldier.png");
  cabbage = loadImage("img/cabbage.png");
  
for(int i=0;i<soilImage.length;i++){soilImage[i] = loadImage("img/soil"+i+".png");}
  initialLife =2;
  
  //set soldierY randomly
  soldierY =SQUARE_UNIT*2+SQUARE_UNIT*floor(random(0,4));
  
  //set cabbage position radomly
  cabbageX =SQUARE_UNIT*floor(random(0,8));
  cabbageY =SQUARE_UNIT*2+SQUARE_UNIT*floor(random(0,4));
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

      image(StartHovered, START_BUTTON_X, START_BUTTON_Y);
      if(mousePressed){
        gameState = GAME_RUN;
        mousePressed = false;
      }

    }else{

      image(StartNormal, START_BUTTON_X, START_BUTTON_Y);

    }
    break;

    case GAME_RUN:
    
    // background
    image(bg, 0, 0);

    // Sun
      stroke(255,255,0);
      strokeWeight(5);
      fill(253,184,19);
      ellipse(590,50,120,120);

    //rolluptranslate
    pushMatrix();
    translate(0,soilOffset);    
    
    // grass
    fill(124, 204, 25);
    noStroke();
    rect(0, 160 - grassHeight, width, grassHeight);
    
    // Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
    for(int y=0;y<24;y++){
    for(int x=0;x<8;x++){
    image(soilImage[floor(y/4)],SQUARE_UNIT*x,SQUARE_UNIT*2+SQUARE_UNIT*y);}}
    
    //1-8
    for(int i=0;i<8;i++){
      image(stone1,i*SQUARE_UNIT,(i+2)*SQUARE_UNIT);
    }
    
    //9-16  
    for(int y=10;y<18;y++){
      for(int x=0;x<10;x++){         
      if(floor((y+1)/2)%2==0){
        if(floor(x/2)%2==0 ){image(stone1,(x-1)*SQUARE_UNIT,y*SQUARE_UNIT);}}
      else{if(floor(x/2)%2==0 ){image(stone1,(x+1)*SQUARE_UNIT,y*SQUARE_UNIT);}}
    }
    }
    
    //17-24
    for(int x=0;x<8;x++){
    for(int y=0;y<8;y++){
     if((x+y)%3==1){image(stone1,SQUARE_UNIT*x,SQUARE_UNIT*y+18*SQUARE_UNIT);}
     if((x+y)%3==2){image(stone1,SQUARE_UNIT*x,SQUARE_UNIT*y+18*SQUARE_UNIT);
     image(stone2,SQUARE_UNIT*x,SQUARE_UNIT*y+18*SQUARE_UNIT);}
     if((x+y)%3==0){}
    }
    }
   
   //draw cabbage
   image(cabbage,cabbageX,cabbageY);
   
   //soldier
   soldierX+=5;
   if(soldierX>640+soldier.width){
   soldierX=-80;}//loop from left to right
   image(soldier,soldierX,soldierY);
    popMatrix();
    
    // player
      //movement
      switch(movement){
        case STOP:
          groundhog = loadImage("img/groundhogIdle.png");
          groundhogY+=0;
        break;
        case DOWNWARD:  
        groundhog = loadImage("img/groundhogDown.png");
        if(soilOffset<=-20*SQUARE_UNIT){         
          groundhogY+=5;
          if(groundhogY%SQUARE_UNIT==0){movement=STOP;}  
        }
        else{
        soilOffset-=5;
        if(soilOffset%SQUARE_UNIT==0){movement=STOP;}
        }
        break;
        case LEFTWARD:
          groundhogX-=5;
          groundhog = loadImage("img/groundhogLeft.png");
          if(groundhogX%SQUARE_UNIT==0){movement=STOP;}
        break;
        case RIGHTWARD:
          groundhogX+=5;
          groundhog = loadImage("img/groundhogRight.png");
          if(groundhogX%SQUARE_UNIT==0){movement=STOP;}
        break;
          
        
        }
          //draw groundhog
          image(groundhog,groundhogX,groundhogY);
    
    // Health UI
      for(int i=0;i<initialLife;i++){
      image(life,10+(life.width+20)*i,10);  
      }
    
    //collision
      //groundhog & soldier
      if(groundhogX<soldierX+soldier.width && groundhogX+groundhog.width>soldierX
      &&groundhogY<soldierY+soldier.height+soilOffset 
      && groundhogY+groundhog.height>soldierY+soilOffset){
      movement=STOP;
      groundhogX=SQUARE_UNIT*4;
      groundhogY=SQUARE_UNIT;
      soilOffset=0;
      initialLife = initialLife-1;}
     //groundhog & cabbage
      if(groundhogX==cabbageX && groundhogY==cabbageY+soilOffset){
        cabbageX=width;
        cabbageY=height;
        if(initialLife<5){initialLife = initialLife+1;}
      }
        //lose
          if(initialLife<=0){gameState=GAME_OVER;}
    break;

    case GAME_OVER: // Gameover Screen
    image(GameOver, 0, 0);
    
    if(START_BUTTON_X + START_BUTTON_W > mouseX
      && START_BUTTON_X < mouseX
      && START_BUTTON_Y + START_BUTTON_H > mouseY
      && START_BUTTON_Y < mouseY) {

      image(RestartHovered, START_BUTTON_X, START_BUTTON_Y);
      if(mousePressed){
        gameState = GAME_RUN;
        mousePressed = false;
        // Remember to initialize the game here!
        movement=STOP;
        initialLife=2;
        groundhogX=SQUARE_UNIT*4; groundhogY=SQUARE_UNIT;
        soilOffset=0;
        //set soldierY randomly
        soldierY =SQUARE_UNIT*2+SQUARE_UNIT*floor(random(0,4));
        //set cabbage position radomly
        cabbageX =SQUARE_UNIT*floor(random(0,8));
        cabbageY =SQUARE_UNIT*2+SQUARE_UNIT*floor(random(0,4));
      }
    }else{

      image(RestartNormal, START_BUTTON_X, START_BUTTON_Y);

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
    if(movement==STOP){
    switch(keyCode){
    case DOWN:
    if(groundhogY+SQUARE_UNIT<height){movement=DOWNWARD;}
    break;
    case RIGHT:
    if(groundhogX+SQUARE_UNIT<width){movement=RIGHTWARD;}
    break;
    case LEFT:
    if(groundhogX>0){movement=LEFTWARD;}
    break;
  }}
  
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
      if(initialLife > 0) initialLife --;
      break;

      case 'd':
      if(initialLife < 5) initialLife ++;
      break;
      

    }
}

void keyReleased(){
}
