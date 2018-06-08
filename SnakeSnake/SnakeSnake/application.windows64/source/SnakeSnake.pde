// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Video: https://youtu.be/hbgDqyy8bIw

Segment tentacle;

float F_x = 300;
float F_y = 200;

float F_r = 10;

int old_sec=0;
int new_sec;

import ddf.minim.*;
AudioPlayer background_player;
AudioPlayer died_player;
AudioPlayer eat_player;
Minim minim_eat;
Minim minim_died;
Minim minim_background;//audio context

float F_speed = 8;
PVector V_speed = new PVector();

float Food_x = random(1)*(width-20)+10;
float Food_y = random(1)*(height-20)+10;

void setup() {
  fullScreen();
  //size(600, 400);
  minim_background = new Minim(this);
  background_player = minim_background.loadFile("background.mp3", 2048);
  
  background_player.loop();
  Segment current = new Segment(300, 200, F_r, 0);

  for (int i = 0; i < 10; i++) {
    Segment next = new Segment(current, F_r, i);
    current.child = next;
    current = next;

  }
  tentacle = current;
}

void keyPressed() {
  if (key=='+'){
    Segment next = new Segment(tentacle, 10, 1);
    tentacle.child = next;
    tentacle = next;
  }
  
}
void draw() {
  background(0);
  //V_speed.set(mouseX-width/2,mouseY-height/2);
  V_speed.set(mouseX-F_x,mouseY-F_y);
  V_speed.setMag(F_speed);
  F_x = F_x + V_speed.x;
  F_y = F_y + V_speed.y;

  if (sqrt(pow(Food_x-F_x,2)+pow(Food_y-F_y,2)) < F_r) {
    minim_eat = new Minim(this);
    eat_player = minim_eat.loadFile("eat.mp3", 2048);
    eat_player.play();
    
    Segment next_ = new Segment(tentacle, 10, 1);
    tentacle.child = next_;
    tentacle = next_;
    Food_x = random(1)*(width-20)+10;
    Food_y = random(1)*(height-20)+10;
  }
  
  stroke(255);
  fill(255);
  //line();
  ellipse(Food_x, Food_y,F_r ,F_r );
  
  tentacle.follow(F_x, F_y);
  //tentacle.follow(F_x, F_y);
  tentacle.update();
  tentacle.show();
  
  Segment next = tentacle.parent;
  
  if (F_x<0+F_r || F_x>width-F_r || F_y<0+F_r || F_y>height-F_r){
    next.parent.I_snake = 0;
  }

  int i = 1;
  while (next != null) {
    next.check_died();
    if (next.I_snake == 1) {
      next.follow();
      next.update();
      next.show();
      next.check(F_x, F_y);
    }
    else {
      next.ball_died();
      next.show();
    }
    next = next.parent;
    i = i+1;
  }

  
}
