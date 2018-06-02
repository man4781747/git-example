class Brick {
  float F_Bk_x;
  float F_Bk_y;
  float F_Ball_distand;
  float F_bk_circle;
  float F_bk_H = 20;
  float F_bk_L = 50;
  
  
  public Brick(float F_Bk_x,float F_Bk_y) {
    this.F_Bk_x = F_Bk_x;
    this.F_Bk_y = F_Bk_y;
    
  }
  
  void Brick_build() {
    fill(255);
    rect(F_Bk_x-F_bk_L,F_Bk_y-F_bk_H ,
         2*F_bk_L,2*F_bk_H);
  }
  
  void Brick_ball_distand(float F_Ball_x,float F_Ball_y) {
     F_Ball_distand =  sqrt(pow(F_Bk_x-F_Ball_x,2)+pow(F_Bk_y-F_Ball_y,2));
     F_bk_circle = sqrt(pow(F_bk_H,2)+pow(F_bk_L,2));
     if (F_Ball_distand <= 3*(F_bk_circle+10) ){   
       float F_close_position_y;
       float F_close_position_x;
       int I_x_case;
       int I_y_case;
       if (F_Ball_y >= F_Bk_y+F_bk_H)  {
          F_close_position_y = F_Bk_y+F_bk_H;
          I_y_case = 1;
       } 
       else if (F_Ball_y <= F_Bk_y-F_bk_H) {
          F_close_position_y = F_Bk_y-F_bk_H;
          I_y_case = 1;
       }
       else {
          F_close_position_y = F_Ball_y;
          I_y_case = 0;
       }
       
       if (F_Ball_x >= F_Bk_x+F_bk_L)  {
          F_close_position_x = F_Bk_x+F_bk_L;
          I_x_case = 1;
       } 
       else if (F_Ball_x <= F_Bk_x-F_bk_L) {
          F_close_position_x = F_Bk_x-F_bk_L;
          I_x_case = 1;
       }
       else {
          F_close_position_x = F_Ball_x;
          I_x_case = 0;
       }
       stroke(255,0,255);
       line(F_Ball_x,F_Ball_y,F_close_position_x,F_close_position_y); 
       /*
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
     */
    }
  }
}
