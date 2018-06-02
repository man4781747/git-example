

class Racket {
   float F_Racket_x;
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
     
     
   }
   
   void Racket_show() {
     
      fill(255);
      rect(F_Racket_x-F_Racket_long,F_Racket_y_position_mid-F_Racket_hight ,
           2*F_Racket_long,2*F_Racket_hight,7);
      
      //ellipse(F_Racket_x-F_Racket_long,height-F_Racket_y_position+F_Racket_hight, 10, 10);
      stroke(255);
      line(0,F_Racket_y_position_mid-F_Racket_hight,width,F_Racket_y_position_mid-F_Racket_hight); //face-up
      line(0,F_Racket_y_position_mid+F_Racket_hight,width,F_Racket_y_position_mid+F_Racket_hight); //face-up
   }
   
   
}
