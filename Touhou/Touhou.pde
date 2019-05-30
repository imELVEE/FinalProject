import java.util.List;
import java.util.ArrayList;

ArrayList<bullet> bullets;
ArrayList<enemy> enemies;
player p;
//-1 = paused, 0 = start menu, 1 = basic game
int mode;
PImage starting;
PImage pause;

//world size, playerbullets, player
void setup(){
  size(600,1000);
  bullets =  new ArrayList<bullet>();
  enemies = new ArrayList<enemy>();
  p = new player();
  mode = 0;
  starting = loadImage("spriteThanos.png");
  pause = loadImage("pause.png");
}

void draw(){
  
  if (mode == 0){
    startMenu();
  }
  
  if (mode == 1){
    mode1();
  }
  
  if (mode == -1){
    pause();
  }
}

void mode1(){
  // x and y refer to player x and y
  background(255);
  //move player with mouse
  p.move();
  float x = p.getX();
  float y = p.getY();
  
  //shoot a bullet every time bullet is called and remove it at edge of world
  if (frameCount % 5 == 0) {
    bullets.add(new pBullet(x,y-30,15));
  }
  for (int i = 0 ; i < bullets.size() ; ){
    boolean hit = false;
    bullet b = bullets.get(i);
    for (enemy m: enemies){
      if (isTouching(b.getX(), b.getY(), b.getRad(), m.getX(), m.getY(), m.getHitbox()[0], m.getHitbox()[1])){
        bullets.remove(i);
        m.getHurt();
        hit = true;
      }
    }
    if(!hit && b.getY() <= 0){
      bullets.remove(i); 
    }
    else if (!hit){
      b.move();
      i++;
    }
  
  }
  
  //1.2% chance to spawn this one random enemy
  if (Math.random() < 0.012 && enemies.size() < 11){
    float var = random(100);
    enemies.add(new sevenUp(200+var,0,5,1,200+var));
    enemies.add(new sevenUp(width-200-var,0,5,-1,width-200-var));
  }
  for (int i = 0 ;i < enemies.size() ;){
    enemy e = enemies.get(i);
    if(e.getX() <= 0 || e.getX() >= width || e.getHealth() <= 0){
      enemies.remove(i);
    }
    else{
      if (Math.min(e.getX(),width-e.getX()) > Math.min(e.getStartX(),width-e.getStartX())/2){
        //print("[" + Math.min(e.getX(),width-e.getX()) + ", " + Math.min(e.getX(),width-e.getX())/2 + "]");
        e.move();
      }
      e.show();
      i++;
    }
  }
}

void startMenu(){
  image(starting,150,0,300,300);
  textSize(30);
  text("CLICK MOUSE TO START GAME",80,400);
}

void pause(){
  image(pause,150,0,300,300);
  textSize(15);
  text("Press P to unpause the game.",100,400);
}

abstract class thing{
  float x,y;
  float[] hitbox;
  float getX(){return x;}
  float getY(){return y;}
  float[] getHitbox() {return hitbox;}
}

class player extends thing{
  PImage me = loadImage("sprite.png");
  
  player(){
    x = mouseX;
    y = mouseY;
    hitbox = new float[]{40, 50};
    noCursor();
  }
  
  void move(){
    image(me,x-20,y-20,40,50);
    x = mouseX;
    y = mouseY;
  }
}


void keyPressed(){
  if (key == 'p' || key == 'P'){
    if (mode == 1)
      mode = -1;
    else
      mode = 1;
  }
}

void mouseClicked(){
    if (mode == 0){
      mode = 1;
    }
}

boolean isTouching(float cx, float cy, float radius, float rx, float ry, float rw, float rh) {
  float testX = cx;
  float testY = cy;

  if (cx < rx)         testX = rx;     
  else if (cx > rx+rw) testX = rx+rw;   
  if (cy < ry)         testY = ry;      
  else if (cy > ry+rh) testY = ry+rh;   

  float distX = cx-testX;
  float distY = cy-testY;
  float distance = sqrt( (distX*distX) + (distY*distY) );

  if (distance <= radius) {
    return true;
  }
  return false;
}

interface damageable{
  void getHurt();
  float getHealth();
}



  
