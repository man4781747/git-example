
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
  
  Ball(String S_Ball_status_input='normal') {
    Ball_x_speed = Ball_speed_base;
    Ball_y_speed = Ball_speed_base;
    x = F_Racket_x_position_mid;
    y = F_Racket_y_position_mid - F_Racket_hight - 10 ;
    Ball_number = I_ball_num;
    S_Ball_status = S_Ball_status_input;
  }
  
  void Ball_update() {
    x = x - Ball_x_speed;
    y = y - Ball_y_speed;

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
