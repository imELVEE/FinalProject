float posX;
float posY;

void drive() { 
  posX += random(-4, 4);
  posY += random(-3, 3);
}

void setup() {
  size(200, 200);
}

void draw() {
  drive();
  ellipse(posX + 100, posY + 100, 20, 20);
}