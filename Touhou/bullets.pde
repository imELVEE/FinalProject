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
      ellipse(x,y,10,10);
    
  }
}
<<<<<<< HEAD
=======

class eBullet extends bullet {
  int degree;
  eBullet(float ex, float why, float speed, int deg){
    super(ex,why,speed);
    radius= 10;
    degree = deg;
  }
  
  void moveD(int r) {
    ellipse(x + velocity * cos(r), y + velocity * sin(r), 10,10);
  }
}
>>>>>>> 5e0b20b7f1e09ef84b4d5aae25973dea488636aa
