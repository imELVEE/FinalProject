import java.util.List;
import java.util.ArrayList;

ArrayList<bullet> bullets;
player p;

//world size, playerbullets, player
void setup(){
  size(1200,1000);
  bullets =  new ArrayList<bullet>();
  p = new player("sprite.png");
}

void draw(){
  // x and y refer to player x and y
  background(255);
  //move player with mouse
  p.move();
  float x = p.getX();
  float y = p.getY();
  
  //shoot a bullet every time bullet is called and remove it at edge of world
  bullets.add(new pBullet(x,y-30,15));
  for (int i = 0 ; i < bullets.size() ; ){
    bullet b = bullets.get(i);
    if(b.getY() <= 0){
      bullets.remove(i); 
    }
    else{
      b.move();
      i++;
    }
  }
}

abstract class thing{
  float x,y;
  float getX(){return x;}
  float getY(){return y;}
}

class player extends thing{
  PImage me;
  
  player(String image){
    me = loadImage(image);
    x = mouseX;
    y = mouseY;
    noCursor();
  }
  
  void move(){
    image(me,x-15,y-15,30,40);
    x = mouseX;
    y = mouseY;
  }
}

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
