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
  background(255);
  image(me,x-15,y-15,30,40);
  
  bullets.add(new pBullet(x,y-15,15));
  for (int i = 0 ; i < bullets.size() ; ){
    bullet b = bullets.get(i);
    if(b.getY() <= 0){
      bullets.remove(i); 
    }
    else{
      fill(190,41,91);
      ellipse(b.getX(),b.getY(),10,10);
      b.move();
      i++;
    }
  }
}

abstract class bullet{
  float x,y,speed;
  
  bullet(float ex, float why, float sped){
    x = ex;
    y = why;
    speed = sped;
  }
  
  void move(){
    y -= speed;
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
