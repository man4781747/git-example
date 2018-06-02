Racket[] racket = new Racket[1];
Ball[] ball = new Ball[1];
Brick[] brick = new Brick[1];

//ArrayList Ball_num_list=new ArrayList();

float F_keybord_press=0;
float F_Racket_x_position_mid;      
float F_Racket_long = 50.0;
float F_Racket_hight = 10.0;
float F_Racket_y_position_mid = 500.0;
float Ball_speed_base = 1;
int I_ball_num;

void setup() {
  size(500,1000);
  F_Racket_y_position_mid = height - F_Racket_y_position_mid;
  F_Racket_x_position_mid = width/2;
  racket[0] = new Racket();
  ball[0] = new Ball();
  //Ball_num_list.add(I_ball_num);
  I_ball_num = 1;
  float k = 50;
  float l = 50;
  brick[0] = new Brick(k,l);
  brick[0].Brick_build();
}

void keyPressed() {
  
  
  if (key==' '){
    //print(Ball_speed_base);

    Ball[] ball_ = new Ball[ball.length + 1];
    for (int i=0; i < ball.length;i++) {
       ball_[i] = ball[i];
    }
    ball_[ball.length] = new Ball();
    ball = ball_;
    I_ball_num = I_ball_num + 1;
  }
  
  if (key=='A'||key=='a'){
    print(mouseX);
    Brick[] brick_ = new Brick[brick.length + 1];
    for (int i=0; i < brick.length;i++) {
       brick_[i] = brick[i];
    }
    brick_[brick.length] = new Brick(mouseX,mouseY);
    brick = brick_;
  }
  
  
}

void draw() {
  background(0);
  
  racket[0].Racket_update();
  F_Racket_x_position_mid = racket[0].F_Racket_x;
  
  for (int i=0; i < ball.length;i++) {
    ball[i].Ball_update();
    racket[0].Racket_ball_distand(ball[i].x,ball[i].y);
  }

  for (int j=0; j < brick.length;j++) {
     brick[j].Brick_build();
     for (int i=0; i < ball.length;i++) {
         brick[j].Brick_ball_distand(ball[i].x,ball[i],ball[i].Ball_x_speed,ball[i].Ball_y_speed);
    //ball[i].Ball_show();
     }
  }
  
  BallDistroy();
  
}
