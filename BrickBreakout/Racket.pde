

class Racket {
   float F_Racket_x;
   Racket() {
     F_Racket_x = width/2;
   }
   
   void Racket_update() {
     F_Racket_x = F_Racket_x + F_keybord_press;
     if (F_Racket_x-F_Racket_long < 0) {
        F_Racket_x = F_Racket_long;
     }
     
     if (F_Racket_x+F_Racket_long > width) {
       F_Racket_x =  width - F_Racket_long;
     }
     
   }
   
   void Racket_show() {
     
      fill(255);
      rect(F_Racket_x-F_Racket_long,height-F_Racket_y_position ,2*F_Racket_long,F_Racket_hight,7);
      
      //ellipse(F_Racket_x-F_Racket_long,height-F_Racket_y_position+F_Racket_hight, 10, 10);
      stroke(255);
      line(0,height-F_Racket_y_position,width,height-F_Racket_y_position); //face-up
      //line(0,height-F_Racket_y_position+F_Racket_hight,width,height-F_Racket_y_position+F_Racket_hight);
   }
   
   
}
