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

public class BrickBreakout extends PApplet {

Racket[] racket = new Racket[1];
Ball[] ball = new Ball[0];
Brick[] brick = new Brick[0];

float F_keybord_press=0;
float F_Racket_x_position_mid;      
float F_Racket_long;
float F_Racket_hight;
float F_Racket_y_position_mid;
float Ball_speed_base = 3;
int I_ball_num;



public void setup() {
  //size(displayWidth, displayHeight);
  
  
  F_Racket_long = width/20;
  F_Racket_hight = height/100;
  F_Racket_y_position_mid = height/100;
  
  F_Racket_y_position_mid = height - F_Racket_y_position_mid;
  F_Racket_x_position_mid = width/2;
  racket[0] = new Racket();
  
  float[][] Base_Brick_x;
  float[][] Base_Brick_y;
  Base_Brick_x = new float[5][8];
  Base_Brick_y = new float[5][8];
  for (int i = 0;i<Base_Brick_x.length;i++) {
    for (int j = 0;j<Base_Brick_x[i].length;j++) {
      Base_Brick_x[i][j] = width/16+width/8*j;
      Base_Brick_y[i][j] = height/100+height/20*(i+1);
    }
  }
  Brick[] brick_ = new Brick[Base_Brick_x.length*Base_Brick_x[0].length];
  I_ball_num = 1;
  
  for (int i=0;i<Base_Brick_x.length;i++){

    for (int j=0;j<Base_Brick_x[i].length;j++){
      brick_[i*Base_Brick_x[i].length+j] = new Brick(Base_Brick_x[i][j],Base_Brick_y[i][j],0);
    }
  }
  
  brick = brick_;
}

public void keyPressed() {
  if (key==' '){
    
    if (ball.length==1 & ball[0].S_Ball_status == "Stuck") {
      ball[0].S_Ball_status = "normal";
    }
    else {
      Ball[] ball_ = new Ball[ball.length + 1];
      for (int i=0; i < ball.length;i++) {
         ball_[i] = ball[i];
      }
      ball_[ball.length] = new Ball("normal");
      ball = ball_;
      I_ball_num = I_ball_num + 1;
    }
  }
  
  if (key=='A'||key=='a'){
    Brick[] brick_ = new Brick[brick.length + 1];
    for (int i=0; i < brick.length;i++) {
       brick_[i] = brick[i];
    }
    brick_[brick.length] = new Brick(mouseX,mouseY,random(1)*360);
    brick = brick_;
  }
  
  
}

public void draw() {
  background(0);

  if (ball.length==0) {
    Ball[] ball_ = new Ball[1];
    ball_[0] = new Ball("Stuck");
    ball = ball_;

  }
  
  if (ball.length==1 & ball[0].S_Ball_status=="Stuck") {
    textFont(createFont("Arial", 50, true));
    textAlign(CENTER);
    text("Press the SPACE to start", width/2, height/2);
  }
  
  
  racket[0].Racket_update();
  F_Racket_x_position_mid = racket[0].F_Racket_x;
  
  for (int i=0; i < ball.length;i++) {
    ball[i].Ball_update();

    racket[0].Racket_ball_distand(ball[i].x,ball[i].y,ball[i].Ball_x_speed,ball[i].Ball_y_speed);
    ball[i].Ball_y_speed = racket[0].ball_speed_y_Racket;
    ball[i].Ball_x_speed = racket[0].ball_speed_x_Racket;
  }
  for (int j=0; j < brick.length;j++) {
     brick[j].Brick_build();
     for (int i=0; i < ball.length;i++) {
         brick[j].Brick_ball_distand(ball[i].x,ball[i].y,ball[i].Ball_x_speed,ball[i].Ball_y_speed);
         ball[i].Ball_y_speed = brick[j].ball_speed_y_Brick;
         ball[i].Ball_x_speed = brick[j].ball_speed_x_Brick;
     }
  }
  
  BrickDistroy();
  BallDistroy();
  
}

class Ball {
  float x;
  float y;
  float Ball_x_speed;
  float Ball_y_speed;
  int Ball_color;
  int Ball_number;
  int Ball_died=1;
  String S_Ball_status;
  //float F_Racket_location;
  
  Ball(String S_Ball_status_input) {
    Ball_x_speed = Ball_speed_base;
    Ball_y_speed = Ball_speed_base;
    x = F_Racket_x_position_mid;
    y = F_Racket_y_position_mid - F_Racket_hight-10;
    Ball_number = I_ball_num;
    S_Ball_status = S_Ball_status_input;
  }
  
  public void Ball_update() {
    x = x - Ball_x_speed;
    y = y - Ball_y_speed;

    if (S_Ball_status=="Stuck") {
       x = mouseX;
       y = F_Racket_y_position_mid - F_Racket_hight-9;
    }

    if (x+10 > width||x-10 < 0) {
      Ball_x_speed = -Ball_x_speed;
    }
    if (y-10 < 0) {
      Ball_y_speed = -Ball_y_speed;
    }
    
    fill(Ball_color,0,0);
    noStroke();
    ellipse(x, y, 10, 10);
    Ball_color = 255;
    
    
    
    if (y+10 > height) {
       Ball_died=0;
    }
  }
}
public void BallDistroy() {
  ArrayList Ball_num_list=new ArrayList();
  int[] Check = new int[ball.length];
  for (int i=0; i < ball.length;i++) {
    Check[i] = ball[i].Ball_died;
    if (Check[i]==1) {
      Ball_num_list.add(i);
    }
  }
  
  //println(Ball_num_list.size());
  Ball[] ball_ = new Ball[Ball_num_list.size()];
  int j = 0;
  for (int i=0 ; i < ball.length ;i++) {
    if (ball[i].Ball_died == 1) {
       ball_[j] = ball[i];
       j = j +1;
    }
  }
  
  ball = ball_;
}
class Brick {
  private float ball_speed_x_Brick;
  private float ball_speed_y_Brick;
  float F_Bk_x;
  float F_Bk_y;
  float F_Ball_distand;
  float F_bk_circle;
  float F_bk_H = height/50;
  float F_bk_L = width*0.9f/16;
  int I_brick_died=1;
  float F_ele;
  int I_color_r=round(156*random(1)+100);
  int I_color_g=round(156*random(1)+100);
  int I_color_b=round(156*random(1)+100);
  
  
  public Brick(float F_Bk_x,float F_Bk_y,float F_ele) {
    this.F_Bk_x = F_Bk_x;
    this.F_Bk_y = F_Bk_y;
    this.F_ele = F_ele*PI/180;
  }
  
  public void Brick_build() {
    fill(I_color_r,I_color_g,I_color_b);
         
    quad(F_Bk_x+F_bk_L*cos(F_ele)-F_bk_H*sin(F_ele), F_Bk_y+F_bk_L*sin(F_ele)+F_bk_H*cos(F_ele),
         F_Bk_x-F_bk_L*cos(F_ele)-F_bk_H*sin(F_ele), F_Bk_y-F_bk_L*sin(F_ele)+F_bk_H*cos(F_ele),
         F_Bk_x-F_bk_L*cos(F_ele)+F_bk_H*sin(F_ele), F_Bk_y-F_bk_L*sin(F_ele)-F_bk_H*cos(F_ele),
         F_Bk_x+F_bk_L*cos(F_ele)+F_bk_H*sin(F_ele), F_Bk_y+F_bk_L*sin(F_ele)-F_bk_H*cos(F_ele));
  }
  
  public void Brick_ball_distand(float F_Ball_x,float F_Ball_y,float F_ball_speed_x,float F_ball_speed_y) {
     F_Ball_distand =  sqrt(pow(F_Bk_x-F_Ball_x,2)+pow(F_Bk_y-F_Ball_y,2));
     F_bk_circle = sqrt(pow(F_bk_H,2)+pow(F_bk_L,2));
     
     float F_Ball_x_tran = F_Bk_x + (F_Ball_x-F_Bk_x)*cos(-F_ele) - (F_Ball_y-F_Bk_y)*sin(-F_ele);
     float F_Ball_y_tran = F_Bk_y + (F_Ball_x-F_Bk_x)*sin(-F_ele) + (F_Ball_y-F_Bk_y)*cos(-F_ele);
     
     ball_speed_x_Brick = F_ball_speed_x;
     ball_speed_y_Brick = F_ball_speed_y;
     
     if (F_Ball_distand <= 1.5f*(F_bk_circle+10) ){   
       float F_close_position_y;
       float F_close_position_x;
       int I_x_case;
       int I_y_case;
       
       //fill(255,255,0);
       //noStroke();
       //ellipse(F_Ball_x_tran, F_Ball_y_tran, 10, 10);
       
       if (F_Ball_y_tran >= F_Bk_y+F_bk_H)  {
          F_close_position_y = F_Bk_y+F_bk_H;
          I_y_case = 1;
       } 
       else if (F_Ball_y_tran <= F_Bk_y-F_bk_H) {
          F_close_position_y = F_Bk_y-F_bk_H;
          I_y_case = 1;
       }
       else {
          F_close_position_y = F_Ball_y_tran;
          I_y_case = 0;
       }
       
       if (F_Ball_x_tran >= F_Bk_x+F_bk_L)  {
          F_close_position_x = F_Bk_x+F_bk_L;
          I_x_case = 1;
       } 
       else if (F_Ball_x_tran <= F_Bk_x-F_bk_L) {
          F_close_position_x = F_Bk_x-F_bk_L;
          I_x_case = 1;
       }
       else {
          F_close_position_x = F_Ball_x_tran;
          I_x_case = 0;
       }
       float F_close_position_x_;
       float F_close_position_y_;
       F_close_position_x_ = F_Bk_x + (F_close_position_x-F_Bk_x)*cos(F_ele) - (F_close_position_y-F_Bk_y)*sin(F_ele);
       F_close_position_y_ = F_Bk_y + (F_close_position_x-F_Bk_x)*sin(F_ele) + (F_close_position_y-F_Bk_y)*cos(F_ele);
       
       F_close_position_x = F_close_position_x_;
       F_close_position_y = F_close_position_y_;
       
       
       //stroke(255,0,255);
       //line(F_Ball_x,F_Ball_y,F_close_position_x,F_close_position_y); 
       
       float RandB_distance = sqrt(pow(F_close_position_x-F_Ball_x,2)+pow(F_close_position_y-F_Ball_y,2));
       
       float[] F_unit_vector;
       F_unit_vector = new float[2];
       F_unit_vector[0] = (F_close_position_x-F_Ball_x)/RandB_distance;
       F_unit_vector[1] = (F_close_position_y-F_Ball_y)/RandB_distance;
       
       float[] F_Normal_vector;
       F_Normal_vector = new float[2];
       F_Normal_vector[0] = (F_unit_vector[0]*ball_speed_x_Brick+F_unit_vector[1]*ball_speed_y_Brick)*F_unit_vector[0];
       F_Normal_vector[1] = (F_unit_vector[0]*ball_speed_x_Brick+F_unit_vector[1]*ball_speed_y_Brick)*F_unit_vector[1];
       
       //stroke(255,125,125);
       //line(F_Ball_x,F_Ball_y,
       //     F_Ball_x+5*F_Normal_vector[0],F_Ball_y+5*F_Normal_vector[1]); 
       
       float[] F_Tangent_vector;
       F_Tangent_vector = new float[2];
       F_Tangent_vector[0] = -ball_speed_x_Brick+F_Normal_vector[0];
       F_Tangent_vector[1] = -ball_speed_y_Brick+F_Normal_vector[1];
       
       /*
       stroke(255,125,125);
       line(F_Ball_x-5*F_Tangent_vector[0],F_Ball_y-5*F_Tangent_vector[1],
            F_Ball_x+5*F_Tangent_vector[0],F_Ball_y+5*F_Tangent_vector[1]); 
       */
       
       
       
       
       
       if (
         RandB_distance <= 10
       ) {
          I_brick_died=0;
          ball_speed_x_Brick = ball_speed_x_Brick - 2*F_Normal_vector[0];
          ball_speed_y_Brick = ball_speed_y_Brick - 2*F_Normal_vector[1];
          
       }
    }
  }
  
}
public void BrickDistroy() {
  if (brick.length > 0) {
    ArrayList Brick_num_list=new ArrayList();
    int[] Brick_Check = new int[brick.length];
    for (int i=0; i < brick.length;i++) {
      Brick_Check[i] = brick[i].I_brick_died;
      if (Brick_Check[i]==1) {
        Brick_num_list.add(i);
      }
    }
    
    Brick[] brick_ = new Brick[Brick_num_list.size()];
    int j = 0;
    for (int i=0 ; i < brick.length ;i++) {
      if (brick[i].I_brick_died == 1) {
         brick_[j] = brick[i];
         j = j +1;
      }
    }
    
    brick = brick_;
  }
}
class Racket {
   private float ball_speed_x_Racket;
   private float ball_speed_y_Racket;
   float F_Racket_x;
   float F_rt_circle;
   float F_Ball_distand;
   float F_Racket_y = F_Racket_y_position_mid;
   
   Racket() {
     F_Racket_x = F_Racket_x_position_mid;
   }
   
   public void Racket_update() {
     F_Racket_x = F_Racket_x + F_keybord_press;
     F_Racket_x = mouseX;
     if (F_Racket_x-F_Racket_long < 0) {
        F_Racket_x = F_Racket_long;
     }
     
     if (F_Racket_x+F_Racket_long > width) {
       F_Racket_x =  width - F_Racket_long;
     }
     
     fill(255);
     rect(F_Racket_x-F_Racket_long,F_Racket_y_position_mid-F_Racket_hight ,
           2*F_Racket_long,2*F_Racket_hight,7);
      
     //ellipse(F_Racket_x-F_Racket_long,height-F_Racket_y_position+F_Racket_hight, 10, 10);
     //stroke(255);
     //line(0,F_Racket_y_position_mid-F_Racket_hight,width,F_Racket_y_position_mid-F_Racket_hight); //face-up
     //line(0,F_Racket_y_position_mid+F_Racket_hight,width,F_Racket_y_position_mid+F_Racket_hight); //face-up
     
     
   }
   
  public void Racket_ball_distand(float F_Ball_x,float F_Ball_y,float F_ball_speed_x,float F_ball_speed_y) {
     F_Ball_distand =  sqrt(pow(F_Racket_x-F_Ball_x,2)+pow(F_Racket_y-F_Ball_y,2));
     F_rt_circle = sqrt(pow(F_Racket_hight,2)+pow(F_Racket_long,2));
     ball_speed_x_Racket = F_ball_speed_x;
     ball_speed_y_Racket = F_ball_speed_y;
     if (F_Ball_distand <= 5*(F_rt_circle+10) ){   
       float F_close_position_y;
       float F_close_position_x;
       int I_x_case;
       int I_y_case;
       if (F_Ball_y >= F_Racket_y+F_Racket_hight)  {
          F_close_position_y = F_Racket_y+F_Racket_hight;
          I_y_case = 1;
       } 
       else if (F_Ball_y <= F_Racket_y-F_Racket_hight) {
          F_close_position_y = F_Racket_y-F_Racket_hight;
          I_y_case = 1;
       }
       else {
          F_close_position_y = F_Ball_y;
          I_y_case = 0;
       }
       
       if (F_Ball_x >= F_Racket_x+F_Racket_long)  {
          F_close_position_x = F_Racket_x+F_Racket_long;
          I_x_case = 1;
       } 
       else if (F_Ball_x <= F_Racket_x-F_Racket_long) {
          F_close_position_x = F_Racket_x-F_Racket_long;
          I_x_case = 1;
       }
       else {
          F_close_position_x = F_Ball_x;
          I_x_case = 0;
       }
       /*
       stroke(255,0,255);
       line(F_Ball_x,F_Ball_y,F_close_position_x,F_close_position_y); 
       stroke(255,255,125);
       line(F_Ball_x,F_Ball_y,F_Ball_x-ball_speed_x_Racket*10,F_Ball_y-ball_speed_y_Racket*10); 
       */
       float RandR_distance = sqrt(pow(F_close_position_x-F_Ball_x,2)+pow(F_close_position_y-F_Ball_y,2));
       
       float[] F_unit_vector;
       F_unit_vector = new float[2];
       F_unit_vector[0] = (F_close_position_x-F_Ball_x)/RandR_distance;
       F_unit_vector[1] = (F_close_position_y-F_Ball_y)/RandR_distance;
       
       float[] F_Normal_vector;
       F_Normal_vector = new float[2];
       F_Normal_vector[0] = (F_unit_vector[0]*ball_speed_x_Racket+F_unit_vector[1]*ball_speed_y_Racket)*F_unit_vector[0];
       F_Normal_vector[1] = (F_unit_vector[0]*ball_speed_x_Racket+F_unit_vector[1]*ball_speed_y_Racket)*F_unit_vector[1];
       
       /*
       stroke(255,125,125);
       line(F_Ball_x,F_Ball_y,
            F_Ball_x+5*F_Normal_vector[0],F_Ball_y+5*F_Normal_vector[1]); 
       */
       
       float[] F_Tangent_vector;
       F_Tangent_vector = new float[2];
       F_Tangent_vector[0] = -ball_speed_x_Racket+F_Normal_vector[0];
       F_Tangent_vector[1] = -ball_speed_y_Racket+F_Normal_vector[1];
       
       /*
       stroke(255,125,125);
       line(F_Ball_x-5*F_Tangent_vector[0],F_Ball_y-5*F_Tangent_vector[1],
            F_Ball_x+5*F_Tangent_vector[0],F_Ball_y+5*F_Tangent_vector[1]); 
            */
       
       if (
         RandR_distance < 9
       ) {

          ball_speed_x_Racket = ball_speed_x_Racket - 2*F_Normal_vector[0];
          ball_speed_y_Racket = ball_speed_y_Racket - 2*F_Normal_vector[1];
       }
       
     }
  }

}
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--stop-color=#cccccc", "BrickBreakout" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
