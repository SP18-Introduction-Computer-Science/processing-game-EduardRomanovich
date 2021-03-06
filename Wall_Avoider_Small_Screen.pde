int gameScreen = 0;
int wallSpeed = 1;
int wallInterval = 2000;
float lastAddTime = 0;
int minGapHeight = 50;
int maxGapHeight = 100;
int wallWidth = 15;
color wallColors = color(204, 0, 0);
int score = 0;
ArrayList<int[]> walls = new ArrayList<int[]>();

void setup() {
  size(300,150);
  ballX=width/5;
  ballY=height/5;
}

void draw() {
  if (gameScreen == 0){
    initScreen();
  } else if (gameScreen == 1) {
    gameScreen();
  }else if (gameScreen == 2) {
    gameOverScreen();
  }
  textSize(5);
  textAlign(RIGHT);
  text("Score", 80, 390);
  textAlign(LEFT);
  text(score, 90, 390);
}

void initScreen() {
  background(0);
  textSize(5);
  textAlign(CENTER);
  text("Shall we Begin", width/2, height/2);
}

public void mousePressed() {
  if (gameScreen==0) {
    startGame();
  }

}

void startGame() {
  gameScreen=1;
}

//ball

color racketColor = color(0);
float racketWidth = 25;
float racketHeight = 4;

float gravity = 1.2;
float ballSpeedVert = .9;
float airfriction = 0.01;
float friction = 0.1;

float ballSpeedHorizon = 5;

int ballX, ballY;
int ballSize = 5;
int ballColor = color(0,255,0);

void drawBall() {
  fill(ballColor);
  ellipse(ballX, ballY, ballSize, ballSize);
}

//GameOver

void gameOverScreen() {
  background(0);
  textAlign(CENTER);
  fill(255);
  textSize(7);
  text("Game Over", height/2, width/2 -80);
}

void restart() {
  score = 0;
  ballX=width/5;
  ballY=height/5;
  lastAddTime = 0;
  walls.clear();
  gameScreen = 0;
}

//Game_Screen

void gameScreen() {
  background(250);
  drawBall();
  applyGravity();
  keepInScreen();
  drawRacket();
  watchRacketBounce();
  applyHorizontalSpeed();
  wallAdder();
  wallHandler();
}

void applyHorizontalSpeed(){
  ballX += ballSpeedHorizon;
  ballSpeedHorizon -= (ballSpeedHorizon * airfriction);
}

void applyGravity() {
  ballSpeedVert += gravity;
  ballY += ballSpeedVert;
  ballSpeedVert -= (ballSpeedVert * airfriction);
}
void makeBounceBottom(int surface) {
  ballY = surface-(ballSize/2);
  ballSpeedVert*=-1;
  ballSpeedVert -= (ballSpeedVert * friction);
}
void makeBounceTop(int surface) {
  ballY = surface+(ballSize/2);
  ballSpeedVert*=-.5;
  ballSpeedVert -= (ballSpeedVert * friction);
}
void makeBounceLeft(int surface){
  ballX = surface+(ballSize/2);
  ballSpeedHorizon*=-1;
  ballSpeedHorizon -= (ballSpeedHorizon * friction);
}
void makeBounceRight(int surface){
  ballX = surface-(ballSize/2);
  ballSpeedHorizon*=-1;
  ballSpeedHorizon -= (ballSpeedHorizon * friction);
}
void keepInScreen() {
  if (ballY+(ballSize/2) > height) { 
    makeBounceBottom(height);
  }
  if (ballY-(ballSize/2) < 2) {
    makeBounceTop(0);
  }
  if (ballX-(ballSize/2) < 0){
    makeBounceLeft(0);
  }
  if (ballX+(ballSize/2) > width){
    makeBounceRight(width);
  }
}

//Racket

void gameScreen() {
  background(250);
  drawBall();
  applyGravity();
  keepInScreen();
  drawRacket();
  watchRacketBounce();
  applyHorizontalSpeed();
  wallAdder();
  wallHandler();
}

void applyHorizontalSpeed(){
  ballX += ballSpeedHorizon;
  ballSpeedHorizon -= (ballSpeedHorizon * airfriction);
}

void applyGravity() {
  ballSpeedVert += gravity;
  ballY += ballSpeedVert;
  ballSpeedVert -= (ballSpeedVert * airfriction);
}
void makeBounceBottom(int surface) {
  ballY = surface-(ballSize/2);
  ballSpeedVert*=-1;
  ballSpeedVert -= (ballSpeedVert * friction);
}
void makeBounceTop(int surface) {
  ballY = surface+(ballSize/2);
  ballSpeedVert*=-.5;
  ballSpeedVert -= (ballSpeedVert * friction);
}
void makeBounceLeft(int surface){
  ballX = surface+(ballSize/2);
  ballSpeedHorizon*=-1;
  ballSpeedHorizon -= (ballSpeedHorizon * friction);
}
void makeBounceRight(int surface){
  ballX = surface-(ballSize/2);
  ballSpeedHorizon*=-1;
  ballSpeedHorizon -= (ballSpeedHorizon * friction);
}
void keepInScreen() {
  if (ballY+(ballSize/2) > height) { 
    makeBounceBottom(height);
  }
  if (ballY-(ballSize/2) < 2) {
    makeBounceTop(0);
  }
  if (ballX-(ballSize/2) < 0){
    makeBounceLeft(0);
  }
  if (ballX+(ballSize/2) > width){
    makeBounceRight(width);
  }
}

//Walls

void wallAdder() {
  if (millis()-lastAddTime > wallInterval) {
    int randHeight = round(random(minGapHeight, maxGapHeight));
    int randY = round(random(0, height-randHeight));
    int[] randWall = {width, randY, wallWidth, randHeight, 0}; 
    walls.add(randWall);
    lastAddTime = millis();
  }
}
void wallHandler() {
  for (int i = 0; i < walls.size(); i++) {
    wallRemover(i);
    wallMover(i);
    wallDrawer(i);
    watchWallCollision(i);
  }
}
void wallDrawer(int index) {
int[] wall = walls.get(index);
int gapWallX = wall[0];
int gapWallY = wall[1];
int gapWallWidth = wall[2];
int gapWallHeight = wall[3];
rectMode(CORNER);
fill(wallColors);
rect(gapWallX, 0, gapWallWidth, gapWallY);
rect(gapWallX, gapWallY+gapWallHeight, gapWallWidth, height-(gapWallY+gapWallHeight));
}
void wallMover(int index) {
  int[] wall = walls.get(index);
  wall[0] -= wallSpeed;
}
void wallRemover(int index) {
  int[] wall = walls.get(index);
  if (wall[0]+wall[2] <= 0) {
    walls.remove(index);
  }
}
void watchWallCollision(int index) {
int[] wall = walls.get(index);
int gapWallX = wall[0];
int gapWallY = wall[1];
int gapWallWidth = wall[2];
int gapWallHeight = wall[3];
int wallTopX = gapWallX;
int wallTopY = 0;
int wallTopWidth = gapWallWidth;
int wallTopHeight = gapWallY;
int wallBottomX = gapWallX;
int wallBottomY = gapWallY+gapWallHeight;
int wallBottomWidth = gapWallWidth;
int wallBottomHeight = height-(gapWallY+gapWallHeight);


  if (
    (ballX+(ballSize/2)>wallTopX) &&
    (ballX-(ballSize/2)<wallTopX+wallTopWidth) &&
    (ballY+(ballSize/2)>wallTopY) &&
    (ballY-(ballSize/2)<wallTopY+wallTopHeight))
    score = score -1; {
  }
  
  if (
    (ballX+(ballSize/2)>wallBottomX) &&
    (ballX-(ballSize/2)<wallBottomX+wallBottomWidth) &&
    (ballY+(ballSize/2)>wallBottomY) &&
    (ballY-(ballSize/2)<wallBottomY+wallBottomHeight))
    score = score - 1;{
  }
  if (score <= 0){
    gameOverScreen();
  }
}
