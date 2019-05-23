void bulletpattern(int r) {
  float x1 = 200;
  float y1 = 200;
  for (int i = 0; i < 360; i+=10) {
     if (frameCount % 10 == 0) {
       ellipse(x1 + r * cos(i),y1 + r * sin(i),10,10);
    }
  }
}

void setup() {
  size(400, 400);
  background(150);
  frameRate(30);
}

void draw() {
  clear();
  bulletpattern(80);
}