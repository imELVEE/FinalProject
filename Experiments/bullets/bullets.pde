void bulletpattern(int r) {
  float x1 = 100;
  float y1 = 100;
  for (int i = 0; i < 360; i++) {
    for (int j = 0; j < 5; j++) {
      if (frameRate % j == 0) {
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