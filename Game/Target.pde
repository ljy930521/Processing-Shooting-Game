class Target{
  PVector position;
  PVector acceleration;
  PVector velocity;
  int npoint;
  float radius;
  color c;

  Target(){
    position = new PVector(random(width), random(-height, 0));
    acceleration = new PVector(0, 0.01);
    velocity = new PVector(0, 0);
    npoint = int(random(4,4));//몇각형 도형을 그릴래?
    radius = random(10, 40);
  }
  
  void update(){
    velocity.add(acceleration);
    velocity.limit(1);
    position.add(velocity);
    if (position.y > height + radius){
      position.y = random(-height, 0);
    }
  }
  
  void display(){
    pushMatrix();
    translate(position.x, position.y);
    rotate(frameCount / 5);
    target(0, 0, radius, npoint);
    popMatrix();
  
  }
  
  //bullet과의 충돌을 체크하고 결과를 리턴
  boolean checkCollision(Bullet b){ //bullet hit target
    float p1 = position.x-25;
    float p2 = position.x + 25;
    if((b.pos.y + b.w) > position.y && (b.pos.y + b.w) <=position.y + 20){
      if(b.pos.x >= p1 && b.pos.x <= p2){
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
