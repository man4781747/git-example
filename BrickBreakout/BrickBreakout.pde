Racket[] racket = new Racket[1];
Ball[] ball = new Ball[1];

float F_keybord_press=0;
float F_Racket_location=250;
float F_Racket_long = 50;
float F_Racket_hight = 100;
float F_Racket_y_position = 150;
float Ball_speed = 8;

void setup() {
  size(500,700);
  racket[0] = new Racket();
  ball[0] = new Ball();
}

void keyPressed() {
  if (key=='z'||key=='Z'){
    F_keybord_press = -15;
  }
  if (key=='x'||key=='X'){
    F_keybord_press = 15;
  }
  
  
}

void draw() {
  background(0);

  racket[0].Racket_update();
  racket[0].Racket_show();
  F_Racket_location = racket[0].F_Racket_x;
  ball[0].Ball_update();
  ball[0].Ball_show();

  F_keybord_press = 0;
  //println(F_Racket_location);
}
