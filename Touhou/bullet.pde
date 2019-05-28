abstract class bullet extends thing{
  float velocity;
  
  bullet(float ex, float why, float speed){
    x = ex;
    y = why;
    velocity = speed;
  }
  
  void move(){
    y -= velocity;
  }
}

class pBullet extends bullet{
  pBullet(float ex, float why, float sped){
    super(ex,why,sped);
  }
  void move(){
    fill(190,41,91);
    ellipse(x,y,10,10);
    super.move();
  }
}