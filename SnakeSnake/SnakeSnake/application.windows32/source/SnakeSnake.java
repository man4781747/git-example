import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class SnakeSnake extends PApplet {

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

public void setup() {
  
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

public void keyPressed() {
  if (key=='+'){
    Segment next = new Segment(tentacle, 10, 1);
    tentacle.child = next;
    tentacle = next;
  }
  
}
public void draw() {
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
// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Video: https://youtu.be/hbgDqyy8bIw

class Segment {
  PVector a;
  float angle = 0;
  float len;
  PVector b = new PVector();
  Segment parent = null;
  Segment child = null;
  float sw = 0;
  
  float R = random(1)*255;
  float G = random(1)*255;
  float B = random(1)*255;

  int I_snake = 1;
  
  float F_random = random(1)*2*PI;
  float F_died_speed_x = 5*sin(F_random);
  float F_died_speed_y = 5*cos(F_random);

  Segment(float x, float y, float len_, float i) {
    a = new PVector(x, y);
    //sw = map(i, 0, 20, 1, 10);
    sw = 2;
    len = len_;
    calculateB();
  }

  Segment(Segment parent_, float len_, float i) {
    parent = parent_;
    //sw = map(i, 0, 20, 1, 10);
    sw = 2;
    a = parent.b.copy();
    len = len_;
    calculateB();
  }

  public void follow() {
    float targetX = child.a.x;
    float targetY = child.a.y;
    follow(targetX, targetY);
  }

  public void follow(float tx, float ty) {
    PVector target = new PVector(tx, ty);
    PVector dir = PVector.sub(target, a);
    angle = dir.heading();
    dir.setMag(len);
    dir.mult(-1);
    a = PVector.add(target, dir);
  }

  public void calculateB() {
    float dx = len * cos(angle);
    float dy = len * sin(angle);
    b.set(a.x+dx, a.y+dy);
  }

  public void check(float x, float y) {
    if (sqrt(pow(b.x-x,2)+pow(b.y-y,2)) <len/2) {
      //parent = null;
      I_snake = 0;
    }
  }

  public void update() {
    calculateB();
  }

  public void ball_died() {
    b.x = b.x+F_died_speed_x;
    b.y = b.y+F_died_speed_y;
  }

  public void check_died() {
    if (child.I_snake == 0) {
      I_snake = 0;
    }
    
    if (I_snake == 0 & parent== null &(b.x < 0 || b.x>width || b.y < 0 ||  b.y > height)) {
      child.parent.parent = null;
    }
    
  }
  
  public void show() {
    stroke(R,G,B);
    fill(B,R,G);
    //strokeWeight(sw);
    ellipse(b.x, b.y,len,len);
    //line(a.x, a.y, b.x, b.y);
  }
}
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--stop-color=#cccccc", "SnakeSnake" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
