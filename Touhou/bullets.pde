float hw = width / 2;
float hh = height / 2;
float d = 5;
abstract class bullet extends thing{
  float velocity;
  float radius;
  
  bullet(float ex, float why, float speed){
    x = ex;
    y = why;
    velocity = speed;
  }
  
  float getRad() {
    return radius;
  }
  
  void move(){
    y -= velocity;
  }
}

class pBullet extends bullet{
  pBullet(float ex, float why, float sped){
    super(ex,why,sped);
    radius = 10;
  }
  void move(){
      super.move();
      fill(190,41,91);
      ellipse(x,y,radius,radius);
    
  }
}



class eBullet extends bullet {
  int degree;
  float velox;
  float veloy;
  PVector mouse;
  PVector location;
  PVector ve;
  int lifespan = 0;
  eBullet(float ex, float why, float vx, float vy){
    super(ex,why,sqrt(pow(vx,2) + pow(vy,2)));
    radius= 10;
    velox = vx;
    veloy = vy;
    mouse = new PVector(mouseX, mouseY);
    location = new PVector(ex,why);
    ve = new PVector(0,0);
  }
  eBullet(float ex, float why, float speed, int deg){
    super(ex,why,speed);
    radius= 10;
    degree = deg;
    mouse = new PVector(mouseX, mouseY);
    location = new PVector(ex,why);
    ve = new PVector(0,0);
  }
  
  void setVelo(int v) {
    velocity = v;
  }
  
  String toString() {
    return "" + radius + " " + degree;
  }
  
  void moveD(int r) {
    ellipse(x + velocity * cos(r), y + velocity * sin(r), 10,10);
  }
  
  void follow() {
    location = new PVector(x,y);
    mouse = new PVector(mouseX, mouseY);
    PVector acceleration = PVector.sub(mouse,location);
    acceleration.setMag(50);
    ve.add(acceleration);
    location.add(ve);
    x= location.x;
    y= location.y;
  }
  
  void slowDown() {
    ellipse(x + velox, y + veloy, 10,10);
    velox *= 0.95;
    veloy *= 0.95;
    lifespan++;
  }
  void moveD() {
    ellipse(x + velocity * cos(degree), y + velocity * sin(degree), 10,10);
    x += velocity * cos(degree);
    y += velocity * sin(degree);
  }
  void show() {ellipse(x,y,10,10);}
}
