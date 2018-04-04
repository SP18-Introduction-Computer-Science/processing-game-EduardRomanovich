int gameScreen = 0;
int wallSpeed = 3;
int wallInterval = 7000;
float lastAddTime = 0;
int minGapHeight = 500;
int maxGapHeight = 1000;
int wallWidth = 150;
color wallColors = color(204, 0, 0);
int score = 0;
ArrayList<int[]> walls = new ArrayList<int[]>();

void setup() {
  size(3000,1500);
  ballX=width/30;
  ballY=height/30;
}

void draw() {
  if (gameScreen == 0){
    initScreen();
  } else if (gameScreen == 1) {
    gameScreen();
  }else if (gameScreen == 2) {
    gameOverScreen();
  }
  textSize(25);
  textAlign(RIGHT);
  text("Score", 80, 390);
  textAlign(LEFT);
  text(score, 90, 390);
}

void initScreen() {
  background(0);
  textSize(50);
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
