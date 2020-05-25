import ddf.minim.*; //sound library

ArrayList <Bullet> bullets; //Bullet class
Player player; //Player class
PImage starship;//Call Image of the Starship

ArrayList<Target> targets;

Minim minim;
AudioPlayer sound;
AudioPlayer sound2;
AudioPlayer sound3;

boolean [] keys = new boolean[128];
int[] land;
int enemy;
int health;

String message;


// Setting up everything
void setup(){
  size(800, 800);
  bullets = new ArrayList();
  enemy = 500;
  health = 50;
  
  //sounds load
  minim = new Minim(this);
  sound = minim.loadFile("popping.mp3");
  sound2 = minim.loadFile("bullet.mp3");
  sound3 = minim.loadFile("SAD.mp3");
  
  sound.setGain(-15);
  sound2.setGain(-15);
  sound3.setGain(-15);
  
  
  player = new Player();
  targets = new ArrayList<Target>();
  for (int i=0; i < enemy; i++){
    targets.add(new Target());
  }
  
  
  starship = loadImage("Starship.png");
  
  land = new int [width/10+1];
  for (int i = 0; i < land.length; i++) {
    land[i] = int(random(100)); 
  }
   message = "";
}


void draw() {
  background(0);
  textSize(32);
  fill(255);
  float w = textWidth(message);
  text(message, width/2-w/2, 100);
  
  drawland();

  for (int i= targets.size() -1; i >= 0; i--){
    Target p = targets.get(i);
    p.update();
    p.display();
    if(player.checkCollision(p)){
      if(health > 0){
        health -= 5;
      }
      p.position.x = 0;
    }
    
    for (Bullet temp : bullets){ //bullet hit target! Check collision with bullet and return result
      if((p.position.y > 0) && (p.checkCollision(temp))){
        message = "";
        if(targets.size()>0){
          targets.remove(i);
          enemy = targets.size();
          if(health>0 && health<100){
            health += 1;
          }
          sound.rewind();
          sound.play();
          print(targets.size()+ "\n");
        }
        //print(true);
        
      }
    }
  }
  
  if(health <=0){// when you die! you can't control starship
            sound3.play();
            message = "Game over! Try again!";
            player.remove();
            sound.setGain(-50);
            sound2.setGain(-50);
            
  }
  else // play on
  {
  player.display();
  player.move();
  }
  
  for(Bullet temp : bullets){
    temp.move();
    temp.display(); 
  }
  //bullet 제한
  removeToLimit(5);
  if(targets.size() <= 0){
    message = "You Win!";
    delay(500);
    //setup();
  }
  textSize(32);
  if(health > 0){
    fill(0, 200, 200);
    text(health, width-100, 50);
  } else {
    text(0, width-100, 50);
  }
  
  fill(255, 0, 0);
  text(enemy, 100, 50);

}

void target(float x, float y, float radius, int npoints){
  float angle = TWO_PI/npoints;
  float t = map(radius, 0, 40, 50,255);//스케일 매핑하기
  color c = color(t/2, t/3, 100);//색상의 변화
  beginShape();
  for(float a = 0; a < TWO_PI; a += angle){
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    fill(c);
    noStroke();
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

void removeToLimit(int maxLength){
    while(bullets.size() > maxLength){
       bullets.remove(0); 
    }
}
void drawland() {
 
  stroke(0);
  fill(250, 150, 0, 60); 
  //Creates the land using beginShape and endShape
  beginShape();
  vertex(0, height);
  for ( int i=0; i < land.length; i++) {
    vertex( i *50, height - 100 - land[i] );
  } 
  vertex(width, height);
  endShape(CLOSE);
}
void mousePressed(){ //not used
   //Bullet temp = new Bullet(mouseX, mouseY);
   //bullets.add(temp);
}
void keyPressed(){ //when you push space bar
  keys[keyCode] = true;
  if(keys[32]){
     Bullet temp = new Bullet(player.pos.x+25, player.pos.y);
     Bullet temp2 = new Bullet(player.pos.x+175, player.pos.y);
     bullets.add(temp);
     bullets.add(temp2);
     sound2.rewind();
     sound2.play();
  }
  message = "START!";
}

void keyReleased(){
  keys[keyCode] = false;
}
