
class Ball {
  float x;
  float y;
  float Ball_x_speed = Ball_speed_base;
  float Ball_y_speed = Ball_speed_base;
  int Ball_color;
  int Ball_number;
  int Ball_died=1;
  //float F_Racket_location;
  
  Ball() {

    x = F_Racket_x_position_mid;
    y = F_Racket_y_position_mid - F_Racket_hight - 10 ;
    Ball_number = I_ball_num;
  }
  
  void Ball_update() {
    x = x - Ball_x_speed;
    y = y - Ball_y_speed;
    
    
    if (  sqrt(pow(F_Racket_x_position_mid-x,2)+pow(F_Racket_y_position_mid-y,2)) <= (10+sqrt(
                  pow(F_Racket_long,2) + pow(F_Racket_hight,2)))*3
    ) {
       float F_close_position_y=0;
       float F_close_position_x;
       int I_x_case;
       int I_y_case;
       Ball_color = 100;
       if (y >= F_Racket_y_position_mid+F_Racket_hight)  {
          F_close_position_y = F_Racket_y_position_mid+F_Racket_hight;
          I_y_case = 1;
       } 
       else if (y <= F_Racket_y_position_mid-F_Racket_hight) {
          F_close_position_y = F_Racket_y_position_mid-F_Racket_hight;
          I_y_case = 1;
       }
       else {
          F_close_position_y = y;
          I_y_case = 0;
       }
       //stroke(255,0,0);
       //line(0,F_close_position_y ,width,F_close_position_y ); 
       
       if (x >= F_Racket_x_position_mid+F_Racket_long)  {
          F_close_position_x = F_Racket_x_position_mid+F_Racket_long;
          I_x_case = 1;
       } 
       else if (x <= F_Racket_x_position_mid-F_Racket_long) {
          F_close_position_x = F_Racket_x_position_mid-F_Racket_long;
          I_x_case = 1;
       }
       else {
          F_close_position_x = x;
          I_x_case = 0;
       }
       //stroke(255,0,0);
       //line(F_close_position_x,0,F_close_position_x,height); 
       stroke(255,255,0);
       line(x,y,F_close_position_x,F_close_position_y); 
       if (
         sqrt(pow(F_close_position_x-x,2)+pow(F_close_position_y-y,2)) <= 10
       ) {
          switch(I_x_case) {
            case 1:
              Ball_x_speed = -Ball_x_speed;
          }
          switch(I_y_case) {
            case 1:
              Ball_y_speed = -Ball_y_speed;
          }
       }
       
    }

      
    if (x+10 > width||x-10 < 0) {
      Ball_x_speed = -Ball_x_speed;
    }
    if (y-10 < 0) {
      Ball_y_speed = -Ball_y_speed;
    }
    if (y+10 > height) {
       Ball_died=0;
       Ball_y_speed = -Ball_y_speed;
    }
    
    
  }
  
  
  void Ball_show() {
    fill(Ball_color,0,0);
    noStroke();
    ellipse(x, y, 10, 10);
    Ball_color = 255;
    
    //ellipse(F_Racket_location, height-F_Racket_y_position+F_Racket_hight/2, 10, 10);
  }
}
