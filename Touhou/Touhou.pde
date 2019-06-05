import java.util.List;
import java.util.ArrayList;

ArrayList<bullet> bullets;
ArrayList<enemy> enemies;
ArrayList<boss> bosses;
ArrayList<eBullet> eBullets;
player p;
//02 = game over, -1 = paused, 0 = start menu, 1 = basic game, 2 = level selection
int mode;
int level;
PImage starting;
PImage pause;
PImage cursor;
PImage clicked;
PImage gover;
boolean first = true;
boolean second = false;
int counter;

//world size, playerbullets, player
void setup(){
  size(600,1000);
  bullets =  new ArrayList<bullet>();
  enemies = new ArrayList<enemy>();
  bosses = new ArrayList<boss>();
  eBullets = new ArrayList<eBullet>();
  counter = 0;
  p = new player();
  mode = 0;
  starting = loadImage("spriteThanos.png");
  pause = loadImage("pause.png");
  cursor = loadImage("cursor.png");
  clicked = loadImage("clicked.png");
  gover = loadImage("gameover.png");
}

void draw(){
  //print(frameCount+ " ");
  //print(bullets.size() + " ");
  
  if (p.getHealth() <= 0){mode = -2;}
  
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
  
  if (mode == -2){
    gameOver();
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
    b.move();
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
      i++;
    }
  
  }
  
  for (int i = 0 ;i < enemies.size() ;){
    enemy e = enemies.get(i);
    if(e.getX() <= 0 || e.getX() >= width || e.getHealth() <= 0 || e.getY() <= 0){
      enemies.remove(i);
    }
    else{
      //if (Math.min(e.getX(),width-e.getX()) > Math.min(e.getStartX(),width-e.getStartX())/2){
      if (e.getY() < e.getStartX()){ //getStartX is just a limiter for now, too lazy to make a new variable
        //print("[" + Math.min(e.getX(),width-e.getX()) + ", " + Math.min(e.getX(),width-e.getX())/2 + "]");
        e.move();
      } else {
        if (frameCount % 20 == 0) {
          if (counter % 2 ==0) {
            pattern1(e.getX(), e.getY(), 1);
            
          }else {
            pattern1(e.getX(), e.getY(), 2);
          }
          counter++;  
        }
        for (int z = 0; z < eBullets.size();) {
          boolean hit = false;
          eBullet b = eBullets.get(z);
          b.moveD();
          if (!hit && isTouching(b.getX(), b.getY(), b.getRad(), p.getX(), p.getY(), p.getHitbox()[0], p.getHitbox()[1])){
          }
          if(!hit &&  (b.getY() <= 0 || b.getX() <= 0 || b.getY() >= height || b.getX() >= width)){
            eBullets.remove(z); 
           }else if (!hit){
             z++;
           }
        }
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
  
  if (level == 1 && bosses.size() == 0){level1();}
  if (level == 2 && bosses.size() == 0){mode = 2; frameCount = 0;}
}

void level1(){
  //print(" " + enemies.size());
  //print(" " + bosses.size());
  if (frameCount % 80 == 0 && frameCount > 0 && bosses.size() == 0 && enemies.size() < 2){
    float var = random(100,200);
    int vel = -1;
    /*
    if (random(1) > 0.5){vel = 1;}
    else{vel = -1;}
    */
    //enemies.add(new sevenUp(200+var,1,5,1,200+var));
    //enemies.add(new sevenUp(width-200-var,1,5,-1,width-200-var));
    enemies.add(new sevenUp(width/2-150+var,1,5,vel,Math.abs(var)));
  }
  /*
  if (frameCount % 160 == 0 && frameCount > 0 && bosses.size() == 0 && enemies.size() < 2 ){
    float var = random(150);
    enemies.add(new sevenUp(100+var,1,5,-1,100+var));
    enemies.add(new sevenUp(width-100-var,1,5,1,width-100-var));
  }
  */
  if (enemies.size() == 0 && frameCount > 300){
    bosses.add(new cola(width/2,100,50,width/2,20,width/2 - 100, width/2 + 100));
    level = 2;
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

void gameOver(){
  background(183,33,33);
  image(gover,150,0,275,300);
  textSize(15);
  text("You died. How sad. Click to restart.",175,400);
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
  int health;
  
  player(){
    health = 1;
    x = mouseX;
    y = mouseY;
    hitbox = new float[]{40, 50};
    noCursor();
  }
  
  void getHurt(){
    health--;
  }
  
  int getHealth(){return health;}
  
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
       frameCount = 0;
     }
    }
    else if (mode == 2){
      if (buttonX && mouseY <= 100+40 && mouseY >= 100){
        mode = 1;
        frameCount = 0;
      }
    }
    else if (mode == -2){
      setup();
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

void pattern1(float x, float  y, int mode){
  //x and y are enemy coordinates
     if (mode == 1) {
        
        eBullets.add(new eBullet(x + 5 * cos(0), y + 5 * sin(0), 3, 0));
        eBullets.add(new eBullet(x + 5 * cos(72), y + 5 * sin(72), 3, 72));
        eBullets.add(new eBullet(x + 5 * cos(144), y + 5 * sin(144), 3, 144));
        eBullets.add(new eBullet(x + 5 * cos(216), y + 5 * sin(216), 3, 216));
        eBullets.add(new eBullet(x + 5 * cos(288), y + 5 * sin(288), 3, 288));
        eBullets.add(new eBullet(x + 5 * cos(0 + 36), y + 5 * sin(0 + 36), 3, 36));
        eBullets.add(new eBullet(x + 5 * cos(72 + 36), y + 5 * sin(72 + 36), 3, 108));
        eBullets.add(new eBullet(x + 5 * cos(144 + 36), y + 5 * sin(144 + 36), 3, 180));
        eBullets.add(new eBullet(x + 5 * cos(216 + 36), y + 5 * sin(216 + 36), 3, 252));
        eBullets.add(new eBullet(x + 5 * cos(288 + 36), y + 5 * sin(288 + 36), 3, 324));
        
     } else if (mode == 2) {
       eBullets.add(new eBullet(x + 5 * cos(0 + 18), y + 5 * sin(0 + 18), 8, 18));
        eBullets.add(new eBullet(x + 5 * cos(72 + 18), y + 5 * sin(72 + 18), 8, 90));
        eBullets.add(new eBullet(x + 5 * cos(144 + 18), y + 5 * sin(144 + 18), 8, 162));
        eBullets.add(new eBullet(x + 5 * cos(216 + 18), y + 5 * sin(216 + 18), 8, 234));
        eBullets.add(new eBullet(x + 5 * cos(288 + 18), y + 5 * sin(288 + 18), 8, 306));
       eBullets.add(new eBullet(x + 5 * cos(0 + 36 + 18), y + 5 * sin(0 + 36 + 18), 8, 54));
        eBullets.add(new eBullet(x + 5 * cos(72 + 36 + 18), y + 5 * sin(72 + 36 + 18), 8, 126));
        eBullets.add(new eBullet(x + 5 * cos(144 + 36 + 18), y + 5 * sin(144 + 36 + 18), 8, 198));
        eBullets.add(new eBullet(x + 5 * cos(216 + 36 + 18), y + 5 * sin(216 + 36 + 18), 8, 270));
        eBullets.add(new eBullet(x + 5 * cos(288 + 36 + 18), y + 5 * sin(288 + 36 + 18), 8, 342));
     }
  }



  
