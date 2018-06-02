class Ball {
  float x;
  float y;
  float Ball_x_speed = Ball_speed;
  float Ball_y_speed = Ball_speed;
  //float F_Racket_location;
  
  Ball() {

    x = F_Racket_location;
    y = F_Racket_y_position ;
  }
  
  void Ball_update() {
    x = x + Ball_x_speed;
    y = y + Ball_y_speed;

      
    if (x+10 > width||x-10 < 0) {
      Ball_x_speed = -Ball_x_speed;
    }
    if (y+10 > height) {
      Ball_y_speed = -Ball_y_speed;
    }
    
    if (y-10 < 0) {
      ball = new Ball[1];
      ball[0] = new Ball();
    }
    
  }
  
  void Ball_show() {
    fill(255,0,0);
    noStroke();
    //println(x);
    ellipse(x, height-y, 10, 10);
  }
}
