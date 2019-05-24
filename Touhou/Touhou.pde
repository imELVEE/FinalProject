import java.util.List;
import java.util.ArrayList;

ArrayList<bullet> bullets;
ArrayList<enemy> enemies;
player p;

//world size, playerbullets, player
void setup(){
  size(600,1000);
  bullets =  new ArrayList<bullet>();
  enemies = new ArrayList<enemy>();
  p = new player();
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
  
  //1.2% chance to spawn this one random enemy
  if (Math.random() < 0.012){
    enemies.add(new sevenUp(200,0,5,1,200));
    enemies.add(new sevenUp(width-200,0,5,-1,200));
  }
  for (int i = 0 ;i < enemies.size() ;){
    enemy e = enemies.get(i);
    if(e.getX() <= 0 || e.getX() >= width){
      enemies.remove(i);
    }
    else{
      e.move();
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
  PImage me = loadImage("sprite.png");
  
  player(){
    x = mouseX;
    y = mouseY;
    noCursor();
  }
  
  void move(){
    image(me,x-20,y-20,40,50);
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

abstract class enemy extends thing{
  float health;
  float startingX;
  float startingY;
  enemy(float x, float y, float health){
    this.x = x;
    this.y = y;
    this.health = health;
  }
  abstract void move();
}

class sevenUp extends enemy{
  PImage me = loadImage("sevenUp.png");
  float velocity;
  
  sevenUp(float x, float y, float health, float velocity, float startX){
    super(x,y,health);
    this.velocity = velocity;
    startingX = startX;
  }  
  
  void move(){
    String rad = ("" + (-(Math.min(x,width-x)*Math.min(x,width-x)) + 200*200));
    double uRad = Double.parseDouble(rad);
    double root = Math.sqrt(uRad);
    y = (float)root;
    x -= velocity;
    //print("(",x,",",y,") ");
    image(me,x-10,y-20,20,40);
  }
}
