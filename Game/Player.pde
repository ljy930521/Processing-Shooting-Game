class Player{
  PVector pos;
  PVector acc;
  PVector vel;
  
  Player(){
    pos = new PVector(width/2, height - 100);
    acc = new PVector(0.2, 0.2);
    vel = new PVector(0,0);
  }
  
  void display(){
    image(starship, pos.x, pos.y); 
  }
  
  void remove() //remove player
  {
  }
  
  void move(){ // Arrow keys setting
    acc.normalize();
    vel.mult(5);
    vel.limit(10); 
    vel = vel.add(acc);
    //pos.add(vel);
    
    if(keys[LEFT])
      pos.x -= vel.x;
    if(keys[RIGHT])
      pos.x += vel.x;
    if(keys[UP])
      pos.y -= vel.y;
    if(keys[DOWN])
      pos.y += vel.y;
      
    if(pos.x < -50){
      pos.x = width; 
    }
    if(pos.x > width){
      pos.x = -50;  
    }
    if(pos.y > height){
      pos.y = -59; 
    }
    if(pos.y < -59){
      pos.y = height; 
    }
  }
  boolean checkCollision(Target p){ // player collide with target
    float p1 = pos.x-25;
    float p2 = pos.x + 25;
    if((p.position.y + p.npoint) > pos.y && (p.position.y + p.npoint) <=pos.y + 20){
      if(p.position.x >= p1 && p.position.x <= p2){
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
