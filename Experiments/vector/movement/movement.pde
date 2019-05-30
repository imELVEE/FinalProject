float posX;
float posY;

void drive() { 
  float tempX = random(-100,100) % 20;
  float tempY = random(-100,100) %20;
  posX += tempX;
  posY += tempY;
}

void setup() {
  size(200, 200);
}

void draw() {
  if (frameCount % 10 == 0) {
    clear();
    drive();
    ellipse(posX + 100, posY + 100, 20, 20);
  }
}