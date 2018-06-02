Racket[] racket = new Racket[1];
Ball[] ball = new Ball[1];

//ArrayList Ball_num_list=new ArrayList();

float F_keybord_press=0;
float F_Racket_x_position_mid;      
float F_Racket_long = 50.0;
float F_Racket_hight = 10.0;
float F_Racket_y_position_mid = 100.0;
float Ball_speed_base = 10;
int I_ball_num;

void setup() {
  size(500,1000);
  F_Racket_y_position_mid = height - F_Racket_y_position_mid;
  F_Racket_x_position_mid = width/2;
  racket[0] = new Racket();
  ball[0] = new Ball();
  //Ball_num_list.add(I_ball_num);
  I_ball_num = 1;
}

void keyPressed() {
  if (key=='z'||key=='Z'){
    F_keybord_press = -15;
  }
  if (key=='x'||key=='X'){
    F_keybord_press = 15;
  }
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
}

void draw() {
  background(0);

  racket[0].Racket_update();
  racket[0].Racket_show();
  F_Racket_x_position_mid = racket[0].F_Racket_x;
  
  for (int i=0; i < ball.length;i++) {
    ball[i].Ball_update();
    ball[i].Ball_show();
  }
  
  F_keybord_press = 0;
  BallDistroy();
  
  //println(F_Racket_location);
}
