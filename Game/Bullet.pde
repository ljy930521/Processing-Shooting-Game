class Bullet{
  PVector pos;
  PVector acc;
  PVector vel;
  int w, h;
  
  Bullet(float tx, float ty){
     pos = new PVector(tx, ty);
     acc = new PVector(0,-0.2);
     vel = new PVector(0, -2.5);
     w = 3;
     h = 10;
  }
  
  void display(){
     stroke(#FFDB0A);
     //point(x, y);
     rect(pos.x, pos.y, w, h);
  }
    
  
  void move(){
    vel.add(acc);
    pos.add(vel);
     //pos.y -= 2.5;
    
  }
}
