int racketBounceRate = 100;

color racketColor = color(0);
float racketWidth = 250;
float racketHeight = 40;

float gravity = 1.2;
float ballSpeedVert = .9;
float airfriction = 0.0001;
float friction = 0.1;

float ballSpeedHorizon = 5;

int ballX, ballY;
int ballSize = 80;
int ballColor = color(0,255,0);

void drawBall() {
  fill(ballColor);
  ellipse(ballX, ballY, ballSize, ballSize);
}
