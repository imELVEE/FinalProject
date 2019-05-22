void bulletpattern(int r) {
  float x1 = 100;
  float y1 = 100;
  for (int i = 0; i < 360; i++) {
    for (int j = 1; j < 100; j++) {
      if (frameCount % 100 == j) {
        x1 += r * cos(i);
        y1 += r * sin(i);
        ellipse(x1,y1,20,20);
      }
    }
  }
}

void setup() {
  size(200, 200);
  background(150);
  frameRate(30);
}

void draw() {
  bulletpattern(6);
}