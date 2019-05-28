interface damageable{
  void getHurt();
  float getHealth();
}

abstract class enemy extends thing implements damageable{
  PImage me;
  float health;
  float startX;
  enemy(float x, float y, float health, float startX){
    this.x = x;
    this.y = y;
    this.health = health;
    this.startX = startX;
  }
  abstract void move();
  
  float getHealth(){return health;}
  float getStartX(){return startX;}
  abstract void show();
  void getHurt(){
    health -= 1;
  }
}

class sevenUp extends enemy{
  PImage me = loadImage("sevenUp.png");
  float velocity;
  
  sevenUp(float x, float y, float health, float velocity, float startX){
    super(x,y,health,startX);
    this.velocity = velocity;
  }  
  
  void move(){
    //move in a circle
    String rad = ("" + (-(Math.min(x,width-x)*Math.min(x,width-x)) + 200*200));
    double uRad = Double.parseDouble(rad);
    double root = Math.sqrt(uRad);
    y = (float)root;
    
    x -= velocity;
    //print("(",x,",",y,") ");
  }
  void show(){image(me,x-10,y-20,20,40);}
}