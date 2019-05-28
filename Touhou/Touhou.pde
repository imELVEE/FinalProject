import java.util.List;
import java.util.ArrayList;

ArrayList<bullet> bullets;
ArrayList<enemy> enemies;
player p;
//0 = start menu, 1 = basic game
int mode;
PImage starting;

//world size, playerbullets, player
void setup(){
  size(600,1000);
  bullets =  new ArrayList<bullet>();
  enemies = new ArrayList<enemy>();
  p = new player();
  mode = 0;
  starting = loadImage("spriteThanos.png");
}

void mouseClicked(){
    if (mode == 0){
      mode = 1;
    }
}

void draw(){
  if (mode == 0){
    image(starting,150,0,300,300);
    textSize(30);
    text("CLICK MOUSE TO START GAME",80,400);
  }
  
  
  
  if (mode == 1){
  // x and y refer to player x and y
  background(255);
  //move player with mouse
  p.move();
  float x = p.getX();
  float y = p.getY();
  
  //shoot a bullet every time bullet is called and remove it at edge of world
  bullets.add(new pBullet(x,y-30,15));
  for (int i = 0 ; i < bullets.size() ; ){
    boolean hit = false;
    bullet b = bullets.get(i);
    for (enemy m: enemies){
      if (b.getX() + 5 <= m.getX()+10 && b.getX() - 5 >= m.getX() - 10 && b.getY() + 5 <= m.getY() + 20 && b.getY() - 5 >= m.getY() - 20){
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