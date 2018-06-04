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
     //stroke(255);
     //line(0,F_Racket_y_position_mid-F_Racket_hight,width,F_Racket_y_position_mid-F_Racket_hight); //face-up
     //line(0,F_Racket_y_position_mid+F_Racket_hight,width,F_Racket_y_position_mid+F_Racket_hight); //face-up
     
     
   }
   
  void Racket_ball_distand(float F_Ball_x,float F_Ball_y,float F_ball_speed_x,float F_ball_speed_y) {
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
       
       stroke(255,0,255);
       line(F_Ball_x,F_Ball_y,F_close_position_x,F_close_position_y); 
       stroke(255,255,125);
       line(F_Ball_x,F_Ball_y,F_Ball_x-ball_speed_x_Racket*10,F_Ball_y-ball_speed_y_Racket*10); 
       
       float RandR_distance = sqrt(pow(F_close_position_x-F_Ball_x,2)+pow(F_close_position_y-F_Ball_y,2));
       
       float[] F_unit_vector;
       F_unit_vector = new float[2];
       F_unit_vector[0] = (F_close_position_x-F_Ball_x)/RandR_distance;
       F_unit_vector[1] = (F_close_position_y-F_Ball_y)/RandR_distance;
       
       float[] F_Normal_vector;
       F_Normal_vector = new float[2];
       F_Normal_vector[0] = (F_unit_vector[0]*ball_speed_x_Racket+F_unit_vector[1]*ball_speed_y_Racket)*F_unit_vector[0];
       F_Normal_vector[1] = (F_unit_vector[0]*ball_speed_x_Racket+F_unit_vector[1]*ball_speed_y_Racket)*F_unit_vector[1];
       
       
       stroke(255,125,125);
       line(F_Ball_x,F_Ball_y,
            F_Ball_x+5*F_Normal_vector[0],F_Ball_y+5*F_Normal_vector[1]); 
       
       
       float[] F_Tangent_vector;
       F_Tangent_vector = new float[2];
       F_Tangent_vector[0] = -ball_speed_x_Racket+F_Normal_vector[0];
       F_Tangent_vector[1] = -ball_speed_y_Racket+F_Normal_vector[1];
       
       
       stroke(255,125,125);
       line(F_Ball_x-5*F_Tangent_vector[0],F_Ball_y-5*F_Tangent_vector[1],
            F_Ball_x+5*F_Tangent_vector[0],F_Ball_y+5*F_Tangent_vector[1]); 
            
       if (
         RandR_distance < 9
       ) {

          ball_speed_x_Racket = ball_speed_x_Racket - 2*F_Normal_vector[0];
          ball_speed_y_Racket = ball_speed_y_Racket - 2*F_Normal_vector[1];
       }
       
     }
  }

}
