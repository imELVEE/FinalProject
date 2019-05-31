import java.util.List;
import java.util.ArrayList;

ArrayList<bullet> bullets;
ArrayList<enemy> enemies;
ArrayList<boss> bosses;
player p;
//-1 = paused, 0 = start menu, 1 = basic game, 2 = level selection
int mode;
int level;
PImage starting;
PImage pause;
PImage cursor;
PImage clicked;

//world size, playerbullets, player
void setup(){
  size(600,1000);
  bullets =  new ArrayList<bullet>();
  enemies = new ArrayList<enemy>();
  bosses = new ArrayList<boss>();
  p = new player();
  mode = 0;
  starting = loadImage("spriteThanos.png");
  pause = loadImage("pause.png");
  cursor = loadImage("cursor.png");
  clicked = loadImage("clicked.png");
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
  
  if (mode == 2){
    mode2();
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
      if (!hit && isTouching(b.getX(), b.getY(), b.getRad(), m.getX(), m.getY(), m.getHitbox()[0], m.getHitbox()[1])){
        bullets.remove(i);
        m.getHurt();
        hit = true;
      }
    }
    for (boss m: bosses){
      if (!hit && isTouching(b.getX(), b.getY(), b.getRad(), m.getX(), m.getY(), m.getHitbox()[0], m.getHitbox()[1])){
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
  
  for (int i = 0 ; i < bosses.size() ;){
    boss b = bosses.get(i);
    if(b.getX() <= 0 || b.getX() >= width || b.getHealth() <= 0){
      bosses.remove(i);
    }
    else{
      if (frameCount % 60 == 0){
        b.move();
      }
      b.show();
      i++;
    }
  }
  
  if (level == 1){level1();}
}

void level1(){
  //print(" " + enemies.size());
  print(" " + bosses.size());
  if (frameCount % 260 == 0 && frameCount > 0 && bosses.size() == 0){
    float var = random(100);
    enemies.add(new sevenUp(200+var,0,5,1,200+var));
    enemies.add(new sevenUp(width-200-var,0,5,-1,width-200-var));
  }
  if (frameCount % 360 == 0 && frameCount > 0 && bosses.size() == 0){
    float var = random(150);
    enemies.add(new sevenUp(300+var,0,5,1,300+var));;;
    enemies.add(new sevenUp(width-300-var,0,5,-1,width-300-var));
  }
  if (enemies.size() == 0 && frameCount > 360){
    bosses.add(new cola(width/2,100,30,width/2,1,width/2 - 100, width/2 + 100));
  }
}

void startMenu(){
  background(242,163,244);
  image(starting,150,0,300,300);
  
  //levels button: size (460.40)
  fill(0);
  stroke(255);
  rect(70,370,460,40);
  fill(255);
  textSize(20);
  text("Levels",270,400);
  
  
  if (mousePressed){
    image(clicked,mouseX-20,mouseY-10,40,40);
  }
  else{
    image(cursor,mouseX-20,mouseY-10,40,40);
  }
}

void pause(){
  background(255);
  image(pause,150,0,275,300);
  textSize(15);
  text("Press P to unpause the game.",175,400);
}

void mode2(){
  background(242,163,244);
  
  //level 1 button: size(460,40)
  fill(0);
  stroke(255);
  rect(70,100,460,40);
  fill(255);
  textSize(20);
  text("1",290,130);
  
  
  if (mousePressed){
    image(clicked,mouseX-20,mouseY-10,40,40);
  }
  else{
    image(cursor,mouseX-20,mouseY-10,40,40);
  }
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
    else if (mode == -1)
      mode = 1;
  }
}

void mouseClicked(){
    boolean buttonX = mouseX <= 70 + 460 && mouseX >= 70;
  
    if (mode == 0){
     if (buttonX && mouseY <= 370+40 && mouseY >= 370){
       mode = 2;
       level = 1;
     }
    }
    else if (mode == 2){
      if (buttonX && mouseY <= 100+40 && mouseY >= 100){
        mode = 1;
      }
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



  
