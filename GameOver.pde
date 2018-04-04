void gameOverScreen() {
  background(0);
  textAlign(CENTER);
  fill(255);
  textSize(70);
  text("Game Over", height/2, width/2 -800);
}

void restart() {
  score = 0;
  ballX=width/4;
  ballY=height/5;
  lastAddTime = 0;
  walls.clear();
  gameScreen = 0;
}
