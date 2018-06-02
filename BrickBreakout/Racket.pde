

class Racket {
   float F_Racket_x;
   float F_rt_circle;
   float F_Ball_distand;
   float F_Racket_y = F_Racket_y_position_mid;
   
   Racket() {
     F_Racket_x = F_Racket_x_position_mid;
   }
   
   void Racket_update() {
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
     stroke(255);
     line(0,F_Racket_y_position_mid-F_Racket_hight,width,F_Racket_y_position_mid-F_Racket_hight); //face-up
     line(0,F_Racket_y_position_mid+F_Racket_hight,width,F_Racket_y_position_mid+F_Racket_hight); //face-up
     
     
   }
   
  void Racket_ball_distand(float F_Ball_x,float F_Ball_y,float F_Ball_speed_x,float F_Ball_speed_y) {
     F_Ball_distand =  sqrt(pow(F_Racket_x-F_Ball_x,2)+pow(F_Racket_y-F_Ball_y,2));
     F_rt_circle = sqrt(pow(F_Racket_hight,2)+pow(F_Racket_long,2));
     if (F_Ball_distand <= 3*(F_rt_circle+10) ){   
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
       stroke(255,0,255);
       line(F_Ball_x,F_Ball_y,F_close_position_x,F_close_position_y); 
       
       
       
       
     }
  }
  
   
   
}
