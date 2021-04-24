final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

final int SPACING = 80;
final int SOIL_H = SPACING*2;
final int SOIL_COL = 8;
final int SOIL_ROW = 24;
final int STONE_COL = 8;
final int STONE_ROW = 8;
final int PH_MAX = 5;

PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage groundhogIdle, groundhogDown, groundhogLeft, groundhogRight;
PImage bg,life;
PImage [] soil = new PImage[6];
PImage [] stone = new PImage[2];

float soilX;
float soilY;
float stoneX;
float stoneY;

float groundhogX = 320;
float groundhogY = 80;
float groundhogSpeed = 4;
float down = 0;
float right = 0;
float left = 0;
float step = 80.0;
int frames = 15;
int floorSpeed = 0;

float SD = 0;

int lifeNum = 2;
float PH_X;
float PH_Y;
float PH_START = 10;
float PH_SPACING = 20;

boolean rightPressed = false;
boolean downPressed  = false;
boolean leftPressed  = false;
boolean upPressed  = false;
// For debug function; DO NOT edit or remove this!
int playerHealth = 0;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
	size(640, 480, P2D);
	bg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
	gameover = loadImage("img/gameover.jpg");
	startNormal = loadImage("img/startNormal.png");
	startHovered = loadImage("img/startHovered.png");
	restartNormal = loadImage("img/restartNormal.png");
	restartHovered = loadImage("img/restartHovered.png");
  groundhogIdle = loadImage("img/groundhogIdle.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogRight = loadImage("img/groundhogRight.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  life = loadImage("img/life.png");

  //soil
  for(int i = 0; i < soil.length; i++){
    soil[i] = loadImage("img/soil"+i+".png");
  }  
  
  //stone
  for(int i = 0; i < stone.length; i++){
    stone[i] = loadImage("img/stone"+(i+1)+".png");
  }


  //player health **
  playerHealth = int(lifeNum);
  constrain(playerHealth,0 ,PH_MAX);
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
    for(int i = 0; i < SOIL_COL; i++){      
        for(int j = 0; j < SOIL_ROW; j++){
          soilX = i * SPACING;
          soilY = SOIL_H + SD + j * SPACING;
          if((j/4)< 1){
            image(soil[0], soilX, soilY);
          }else if((j/4) < 2){
            image(soil[1], soilX, soilY);
          }else if((j/4) < 3){
            image(soil[2], soilX, soilY);
          }else if((j/4) < 4){
            image(soil[3], soilX, soilY);
          }else if((j/4) < 5){
            image(soil[4], soilX, soilY);
          }else{image(soil[5], soilX, soilY);}         
        }
      }
     
     //Stone1
     //1~8
     for(int i = 0; i < STONE_COL; i++){
       stoneX = i * SPACING;
       stoneY = SOIL_H + SD + i * SPACING;
       image(stone[0], stoneX, stoneY);
     }
     //9~16
     for(int i = 0; i < STONE_ROW; i++){
       if(i == 0||i == 3|| i == 4||i == 7){
         for(int j = 0; j < 2; j++){
             stoneX = SPACING * (j*4 + 1);
             stoneY = SOIL_H + SD + (8+i)*SPACING;
             image(stone[0], stoneX, stoneY);
             image(stone[0], stoneX + SPACING, stoneY);
         }
       }else{
         for(int j = 0; j < 2; j++){
             stoneX = SPACING * (j*4);
             stoneY = SOIL_H + SD + (8+i)*SPACING;
             image(stone[0], stoneX, stoneY);
             image(stone[0], stoneX + 3*SPACING, stoneY);
         }
       }
     }
    //17~24
    for(int i = 0; i < STONE_ROW; i++){
         if(i == 0||i == 3|| i == 6){
           for(int j = 0; j < 3; j++){
             stoneX = SPACING * (j*3 + 1);
             stoneY = SOIL_H + SD + (16+i) * SPACING;
             image(stone[0], stoneX, stoneY);
             image(stone[0], stoneX + SPACING, stoneY);
           }
         }else if(i == 1||i == 4|| i == 7){
           for(int j = 0; j < 3; j++){
             stoneX = SPACING * (j*3);
             stoneY = SOIL_H + SD + (16+i) * SPACING;
             image(stone[0], stoneX, stoneY);
             image(stone[0], stoneX + SPACING, stoneY);
           }         
         }else{
           for(int j = 0; j < 3; j++){
             stoneX = SPACING * (j*3);
             stoneY = SOIL_H + SD + (16+i) * SPACING;
             image(stone[0], stoneX, stoneY);
             image(stone[0], stoneX + 2 * SPACING, stoneY);
           }       
         }     
       }
    //Stone2
    for(int i = 0; i < STONE_ROW; i++){
         if(i == 0||i == 3|| i == 6){
           for(int j = 0; j < 2; j++){
             stoneX = SPACING * (j*3 + 2);
             stoneY = SOIL_H + SD + (16+i) * SPACING;
             image(stone[1], stoneX, stoneY);
             
           }
         }else if(i == 1||i == 4|| i == 7){
           for(int j = 0; j < 3; j++){
             stoneX = SPACING * (j*3 + 1);
             stoneY = SOIL_H + SD + (16+i) * SPACING;
             image(stone[1], stoneX, stoneY);
             
           }         
         }else{
           for(int j = 0; j < 3; j++){
             stoneX = SPACING * (j*3);
             stoneY = SOIL_H + SD + (16+i) * SPACING;
             image(stone[1], stoneX, stoneY);
             
           }       
         }     
       }
    
		// Player
//groundhog move
    //soil and stone down
    if (down > 0 && SD > SPACING * -20) {
      floorSpeed -=1;
      if (down == 1) {
        SD = round(step/frames * floorSpeed);
        image(groundhogIdle, groundhogX, groundhogY);
      } else {
        SD = step/frames * floorSpeed;
        image(groundhogDown, groundhogX, groundhogY);
      }
      down -=1;
    }

  //groundhug down
    if (down > 0 && SD == SPACING * -20) {
      if (down == 1) {
        groundhogY = round(groundhogY + step/frames);
        image(groundhogIdle, groundhogX, groundhogY);
      } else {
        groundhogY = groundhogY + step/frames;
        image(groundhogDown, groundhogX, groundhogY);
      }
      down -=1;
    }

    //left
    if (left > 0) {
      if (left == 1) {
        groundhogX = round(groundhogX - step/frames);
        image(groundhogIdle, groundhogX, groundhogY);
      } else {
        groundhogX = groundhogX - step/frames;
        image(groundhogLeft, groundhogX, groundhogY);
      }
      left -=1;
    }

    //right
    if (right > 0) {
      if (right == 1) {
        groundhogX = round(groundhogX + step/frames);
        image(groundhogIdle, groundhogX, groundhogY);
      } else {
        groundhogX = groundhogX + step/frames;
        image(groundhogRight, groundhogX, groundhogY);
      }
      right -=1;
    }

    //no move
    if (down == 0 && left == 0 && right == 0 ) {
      image(groundhogIdle, groundhogX, groundhogY);
    }
		// Health UI
    for(int i = 0; i < playerHealth; i++){
      PH_X = PH_START + i * (PH_SPACING + life.width);
      PH_Y = PH_START;
      image(life, PH_X, PH_Y);
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
        groundhogX = SPACING * 4;
        groundhogY = SPACING * 1; 
        playerHealth = int(lifeNum);
        constrain(playerHealth,0 ,PH_MAX);
        down = 0;
        left = 0;
        right = 0;
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
  if (down>0 || left>0 || right>0) {
    return;
  }
  if (key == CODED) {
    switch(keyCode) {
    case DOWN:
      if (groundhogY < 25*SPACING) {
        downPressed = true;
        down = 15;
      }
      break;
    case LEFT:
      if (groundhogX > 0) {
        leftPressed = true;
        left = 15;
      }
      break;
    case RIGHT:
      if (groundhogX < 560) {
        rightPressed = true;
        right = 15;
      }
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

//void keyReleased(){
//}
