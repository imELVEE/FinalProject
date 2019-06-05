int i = 0;
int counter = 0;
void bulletpattern(int r) {
  float x1 = 200;
  float y1 = 200;
  ellipse(x1 + r * cos(i),y1 + r * sin(i),10,10);
}

void setup() {
  size(400, 400);
  background(150);
  frameRate(30);
}

void draw() {
  if (frameCount % 2 == 0 && counter < 25) {
     i += 5;
     counter++;
    bulletpattern(80);
  }
  if (counter == 5) {
  }
}
