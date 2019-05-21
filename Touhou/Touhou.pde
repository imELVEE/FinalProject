import java.util.List;
import java.util.ArrayList;

PImage me;
ArrayList<bullet> bullets;

void setup(){
  size(1200,1000);
  me = loadImage("sprite.png");
  bullets =  new ArrayList<bullet>();
}

void draw(){
  int x = mouseX;
  int y = mouseY;
  noCursor();
  background(115);
  image(me,x-15,y-15,30,40);
}

abstract class bullet{
  float x,y,speed;
  
  bullet(float ex, float why, float sped){
    x = ex;
    y = why;
    speed = sped;
  }
  
  void move(){
    y += speed;
  }
  
  float getY(){
    return y;
  }
  
  float getX(){
    return x;
  }
}

class pBullet extends bullet{
  pBullet(float ex, float why, float sped){
    super(ex,why,sped);
  }
}
