acceleration acc;
class acceleration {
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector point;
  PVector startingLocation;
  float topspeed;
  acceleration() {
    startingLocation = new PVector(width, height);
    location = new PVector(width/2,height/2);
    point = new PVector(width/2 - 100,height/2 + 100);
    velocity = new PVector(0,0);
    topspeed = 50;
  }
  
  void update() {
    PVector acceleration = PVector.sub(point,location);
    acceleration.setMag(0.2);
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
  }
  
  void display() {
    stroke(255);
    strokeWeight(2);
    fill(127);
    ellipse(location.x,location.y,48,48);
  }
}

void setup() {
  size(500,500);
  acc = new acceleration();
}
void draw() {
  background(0);
  acc.update();
  acc.display();
}