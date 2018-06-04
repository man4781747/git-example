import ddf.minim.*;
AudioPlayer background_player;
AudioPlayer fire_player;
AudioPlayer hit_player;
Minim minim_hit;
Minim minim_fire;
Minim minim;//audio context


Racket[] racket = new Racket[1];
Ball[] ball = new Ball[0];
Brick[] brick = new Brick[0];

float F_keybord_press=0;
float F_Racket_x_position_mid;      
float F_Racket_long;
float F_Racket_hight;
float F_Racket_y_position_mid;
float Ball_speed_base = 12;
int I_ball_num;



void setup() {
  minim = new Minim(this);
  background_player = minim.loadFile("background.mp3", 2048);
  //background_player.loop();
  
  
  size(1000, 1000);
  //fullScreen();
  
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

void keyPressed() {
  if (key==' '){
    
    /*
    minim_fire = new Minim(this);
    fire_player = minim.loadFile("fire.mp3", 2048);
    fire_player.play();
    */
    
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
    brick_[brick.length] = new Brick(mouseX,mouseY,0);
    brick = brick_;
  }
  
  
}

void draw() {
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

    racket[0].Racket_ball_distand(ball[i].x,ball[i].y,
                                  ball[i].Ball_x_speed,ball[i].Ball_y_speed);
    ball[i].Ball_y_speed = racket[0].ball_speed_y_Racket;
    ball[i].Ball_x_speed = racket[0].ball_speed_x_Racket;
  }
  for (int j=0; j < brick.length;j++) {
     brick[j].Brick_build();
     for (int i=0; i < ball.length;i++) {
         brick[j].Brick_ball_distand(ball[i].x,ball[i].y,
                                     ball[i].x_,ball[i].y_,
                                     ball[i].Ball_x_speed,ball[i].Ball_y_speed);
         ball[i].Ball_y_speed = brick[j].ball_speed_y_Brick;
         ball[i].Ball_x_speed = brick[j].ball_speed_x_Brick;
         ball[i].x = brick[j].F_fix_x_position;
         ball[i].y = brick[j].F_fix_y_position;
     }
  }
  
  BrickDistroy();
  BallDistroy();
  
}
