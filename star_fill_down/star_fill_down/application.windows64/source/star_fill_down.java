import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class star_fill_down extends PApplet {

Aerolite[] aerolite;
float rotate_ang;
PVector day_1,day_2,day_3,day_4;
int Game_type;
PVector you_p = new PVector(0,-300);
float start_time_millis;
float start_time_sec;
float start_time_min;
float start_time_hr;
float time_total=0;
float time_max=0;
float time_test;
float time_test_ = second();

public void mouseClicked() {
  if (Game_type == 0) {
    Game_type = 1;
    start_time_millis = millis();
    start_time_sec = second();
    start_time_min = minute();
    start_time_hr = hour();
  }
}

public void Game_restart() {
  aerolite = new Aerolite[20];
  for (int i = 0;i<aerolite.length;i++){
    aerolite[i] = new Aerolite(random(0.02f,0.03f),
                               random(750,1000),
                               random(10,50),
                               random(-PI,PI));
  }
  Game_type = 0;
}

public void add_aerolite(){
  Aerolite[] aerolite_ = new Aerolite[aerolite.length+1];
  for (int i = 0;i<aerolite.length;i++){
    aerolite_[i] = aerolite[i];
  }
  aerolite_[aerolite.length] = new Aerolite(random(0.01f,0.03f),
                               random(750,1000),
                               random(10,50),
                               random(-PI,PI));
  aerolite = aerolite_;
}

public void setup() {
  //size(1000,1000);
  
  Game_restart();
}

public void draw() {
  background(0);
  translate(width/2,height);
  
  time_test = second();
  if (time_test_ != time_test && Game_type == 1){
    add_aerolite();
  }
  time_test_ = time_test;
  
  textFont(createFont("Arial", 50, true));
  textAlign(RIGHT);
  fill(255);
  text(aerolite.length, width/2, -height*9/10);
  textAlign(LEFT);
  text(time_max, -width/2, -height*9/10);
  
  rotate_ang = map(mouseX,0,width,-PI,PI);
  noStroke();
  fill(44,155,44);
  ellipse(0,0,500,500);
  fill(0);
  strokeWeight(3);
  stroke(255,0,0);
  ellipse(you_p.x,you_p.y,20,20);
  switch(Game_type) {
    case 0: 
      for (int i = 0;i<aerolite.length;i++){
        aerolite[i].Aerolite_show(rotate_ang);
      }
      textAlign(CENTER);
      fill(255);
      text("Press the MOUSE to start", 0, -height/2);
      text(time_total, 0, -height/10);
      break;
    case 1:
      for (int i = 0;i<aerolite.length;i++){
        aerolite[i].Aerolite_update();
        aerolite[i].Aerolite_show(rotate_ang);
        Game_type = aerolite[i].Aerolite_hit(you_p,rotate_ang);
        if (Game_type!=1){
          break;
        }
      }
      time_total = -((start_time_hr-hour())*3600+(start_time_min-minute())*60+(start_time_sec-second())+(start_time_millis-millis())*0.001f);
      textAlign(CENTER);
      fill(255);
      text(time_total, 0, -height/10);
      if (time_total > time_max) {
        time_max = time_total;
      }
      break;
    
    case 2:
      Game_restart();
  }
}
class Aerolite{
  float v = 0;
  float a;
  float distance;
  float r;
  float rotate_angle;
  PVector p;
  float R = random(100,255);
  float G = random(100,255);
  float B = random(100,255);
  
  Aerolite(float g,float distance_,float r_,float rotate_angle_) {
    a = g;
    distance = distance_;
    r = r_;
    rotate_angle = rotate_angle_;
    p = new PVector(0,distance).rotate(rotate_angle);
  }
  
  public void Aerolite_update(){
    v = v + a;
    distance = distance - v;
    p.set(0,distance).rotate(rotate_angle);
    Aerolite_re();
    
  }
  
  public void Aerolite_re(){
    if (distance <= r/2+250){
      a = random(0.01f,0.03f);
      distance = random(750,1000);
      r = random(10,50);
      rotate_angle = random(-PI,PI);
      p = new PVector(0,distance).rotate(rotate_angle);
      v = 0;
      R = random(100,255);
      G = random(100,255);
      B = random(100,255);
    }
  }
  
  public int Aerolite_hit(PVector you,float rotate_ang){
    float d = PVector.dist(p.copy().rotate(rotate_ang),you);
    if (d <= r/2+10) {
      return 2;
    } else {
      return 1;
    }
    
  }
  
  public void Aerolite_show(float rotate_ang){
    noStroke();
    fill(R,G,B);
    ellipse(p.copy().rotate(rotate_ang).x,
            p.copy().rotate(rotate_ang).y,r,r);
  }
}
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--stop-color=#cccccc", "star_fill_down" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
