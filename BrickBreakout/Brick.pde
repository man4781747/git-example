class Brick {
  private float ball_speed_x_Brick;
  private float ball_speed_y_Brick;
  float F_Bk_x;
  float F_Bk_y;
  float F_Ball_distand;
  float F_bk_circle;
  float F_bk_H = height/50;
  //float F_bk_H = height/10;
  float F_bk_L = width*0.9/16;
  int I_brick_died=1;
  float F_ele;
  int I_color_r=round(156*random(1)+100);
  int I_color_g=round(156*random(1)+100);
  int I_color_b=round(156*random(1)+100);
  int I_x_case_ = 0;
  int I_y_case_ = 0;
  float F_fix_y_position;
  float F_fix_x_position;
  
  public Brick(float F_Bk_x,float F_Bk_y,float F_ele) {
    this.F_Bk_x = F_Bk_x;
    this.F_Bk_y = F_Bk_y;
    this.F_ele = F_ele*PI/180;
  }
  
  void Brick_build() {
    fill(I_color_r,I_color_g,I_color_b);
         
    quad(F_Bk_x+F_bk_L*cos(F_ele)-F_bk_H*sin(F_ele), F_Bk_y+F_bk_L*sin(F_ele)+F_bk_H*cos(F_ele),
         F_Bk_x-F_bk_L*cos(F_ele)-F_bk_H*sin(F_ele), F_Bk_y-F_bk_L*sin(F_ele)+F_bk_H*cos(F_ele),
         F_Bk_x-F_bk_L*cos(F_ele)+F_bk_H*sin(F_ele), F_Bk_y-F_bk_L*sin(F_ele)-F_bk_H*cos(F_ele),
         F_Bk_x+F_bk_L*cos(F_ele)+F_bk_H*sin(F_ele), F_Bk_y+F_bk_L*sin(F_ele)-F_bk_H*cos(F_ele));
  }
  
  void Brick_ball_distand(float F_Ball_x,float F_Ball_y,
                          float F_Ball_x_,float F_Ball_y_,
                          float F_ball_speed_x,float F_ball_speed_y) {
                            
     F_Ball_distand =  sqrt(pow(F_Bk_x-F_Ball_x,2)+pow(F_Bk_y-F_Ball_y,2));
     F_bk_circle = sqrt(pow(F_bk_H,2)+pow(F_bk_L,2));
     
     float F_Ball_x_tran = F_Bk_x + (F_Ball_x-F_Bk_x)*cos(-F_ele) - (F_Ball_y-F_Bk_y)*sin(-F_ele);
     float F_Ball_y_tran = F_Bk_y + (F_Ball_x-F_Bk_x)*sin(-F_ele) + (F_Ball_y-F_Bk_y)*cos(-F_ele);
     
     float F_Ball_x_tran_ = F_Bk_x + (F_Ball_x_-F_Bk_x)*cos(-F_ele) - (F_Ball_y_-F_Bk_y)*sin(-F_ele);
     float F_Ball_y_tran_ = F_Bk_y + (F_Ball_x_-F_Bk_x)*sin(-F_ele) + (F_Ball_y_-F_Bk_y)*cos(-F_ele);
     
     float F_speed_x_tran = F_ball_speed_x*cos(-F_ele) - F_ball_speed_y*sin(-F_ele);
     float F_speed_y_tran = F_ball_speed_x*sin(-F_ele) + F_ball_speed_y*cos(-F_ele);
     
     stroke(255,125,125);
     line(F_Ball_x,F_Ball_y,
          F_Ball_x_,F_Ball_y_); 

     ball_speed_x_Brick = F_ball_speed_x;
     ball_speed_y_Brick = F_ball_speed_y;
     
     F_fix_y_position = F_Ball_y;
     F_fix_x_position = F_Ball_x;
     
     if (F_Ball_distand <= 1.5*(F_bk_circle+10) ){   
       float F_close_position_y;
       float F_close_position_x;
       float F_close_position_y_before;
       float F_close_position_x_before;
       int I_x_case;
       int I_y_case;
       /*
       new-point
       */
       if (F_Ball_y_tran >= F_Bk_y+F_bk_H)  {
          F_close_position_y = F_Bk_y+F_bk_H;
          I_y_case = 1;
       } 
       else if (F_Ball_y_tran <= F_Bk_y-F_bk_H) {
          F_close_position_y = F_Bk_y-F_bk_H;
          I_y_case = 1;
       }
       else {
          F_close_position_y = F_Ball_y_tran;
          I_y_case = 0;
       }
       
       if (F_Ball_x_tran >= F_Bk_x+F_bk_L)  {
          F_close_position_x = F_Bk_x+F_bk_L;
          I_x_case = 1;
       } 
       else if (F_Ball_x_tran <= F_Bk_x-F_bk_L) {
          F_close_position_x = F_Bk_x-F_bk_L;
          I_x_case = 1;
       }
       else {
          F_close_position_x = F_Ball_x_tran;
          I_x_case = 0;
       }
       /*
       old-point
       */
       if (F_Ball_y_tran_ >= F_Bk_y+F_bk_H)  {
          F_close_position_y_before = F_Bk_y+F_bk_H;
          I_y_case_ = 1;
       } 
       else if (F_Ball_y_tran_ <= F_Bk_y-F_bk_H) {
          F_close_position_y_before = F_Bk_y-F_bk_H;
          
          I_y_case_ = -1;
       }
       else {
          F_close_position_y_before = F_Ball_y_tran_;
          I_y_case_ = 0;
       }
       
       if (F_Ball_x_tran_ >= F_Bk_x+F_bk_L)  {
          F_close_position_x_before = F_Bk_x+F_bk_L;
          I_x_case_ = 1;
       } 
       else if (F_Ball_x_tran_ <= F_Bk_x-F_bk_L) {
          F_close_position_x_before = F_Bk_x-F_bk_L;
          I_x_case_ = -1;
       }
       else {
          F_close_position_x_before = F_Ball_x_tran_;
          I_x_case_ = 0;
       }
       
       
       if (I_x_case==0 & I_y_case==0  ) {
         I_brick_died = 0;
         if (I_x_case_ == 0) {
           print("x=-x");
           F_fix_y_position = F_Ball_y_tran + 2*(F_close_position_y_before-F_Ball_y_tran);
           F_fix_x_position = F_Ball_x_tran;
           F_speed_y_tran = -F_speed_y_tran;
           //ellipse(F_Ball_x_tran, F_Ball_y_tran, 10, 10);
           //ellipse(F_fix_x_position, F_fix_y_position, 10, 10);
           //ellipse(F_close_position_x_before, F_close_position_y_before, 10, 10);            
           
           
         }
         if (I_y_case_ == 0) {
            print("y=-y");
           F_fix_x_position = F_Ball_x_tran + 2*(F_close_position_x_before-F_Ball_x_tran);
           F_fix_y_position = F_Ball_y_tran;
           F_speed_x_tran = -F_speed_x_tran;
           
 
         }
         
         if (I_x_case_ == 1) {
           switch(I_y_case_) {
             case 1:
             print("1,1");
             
               if (abs(F_ball_speed_y/-F_ball_speed_x) < 
                   abs((F_close_position_y_before-F_Ball_y_tran_)/(F_close_position_x_before+10-F_Ball_x_tran_))) {
                 F_fix_y_position = F_Ball_y_tran + 2*(F_close_position_y_before-F_Ball_y_tran);
                 F_fix_x_position = F_Ball_x_tran;
                 F_speed_y_tran = -F_speed_y_tran;
                 //                 ellipse(F_fix_x_position, F_fix_y_position, 10, 10);
                 //ellipse(F_Ball_x_tran, F_Ball_y_tran, 10, 10);        
                 
               }
               else if (abs(F_ball_speed_y/-F_ball_speed_x) >              
                        abs((F_close_position_y_before+10-F_Ball_y_tran_)/(F_close_position_x_before-F_Ball_x_tran_))) {
                 F_fix_x_position = F_Ball_x_tran + 2*(F_close_position_x_before-F_Ball_x_tran);
                 F_fix_y_position = F_Ball_y_tran;
                 F_speed_x_tran = -F_speed_x_tran;
               }
               else {
                 exit();
               }
             case -1: 
             print("1,-1");
               if (abs(F_ball_speed_y/F_ball_speed_x) <=  
                   abs((F_close_position_y_before-F_Ball_y_tran_)/(F_close_position_x_before-10-F_Ball_x_tran_))) {
                 F_fix_y_position = F_Ball_y_tran + 2*(F_close_position_y_before-F_Ball_y_tran);
                 F_fix_x_position = F_Ball_x_tran;
                 F_speed_y_tran = -F_speed_y_tran;
               }
               else if (abs(F_ball_speed_y/F_ball_speed_x) >=  
                        abs((F_close_position_y_before+10-F_Ball_y_tran_)/(F_close_position_x_before-F_Ball_x_tran_))) {
                 F_fix_x_position = F_Ball_x_tran + 2*(F_close_position_x_before-F_Ball_x_tran);
                 F_fix_y_position = F_Ball_y_tran;
                 F_speed_x_tran = -F_speed_x_tran;
               }
               else {
                 exit();
               }
               
           }
         }
         else if (I_x_case_ == -1){
           switch(I_y_case_) {
             case 1:
             print("-1,1");
               if (abs(F_ball_speed_y/F_ball_speed_x) <=  
                   abs((F_close_position_y_before-F_Ball_y_tran_)/(F_close_position_x_before+10-F_Ball_x_tran_))) {
                 F_fix_y_position = F_Ball_y_tran + 2*(F_close_position_y_before-F_Ball_y_tran);
                 F_fix_x_position = F_Ball_x_tran;
                 F_speed_y_tran = -F_speed_y_tran;
               }
               else if (abs(F_ball_speed_y/F_ball_speed_x) >=  
                        abs((F_close_position_y_before-10-F_Ball_y_tran_)/(F_close_position_x_before-F_Ball_x_tran_))) {
                 F_fix_x_position = F_Ball_x_tran + 2*(F_close_position_x_before-F_Ball_x_tran);
                 F_fix_y_position = F_Ball_y_tran;
                 F_speed_x_tran = -F_speed_x_tran;
               }
               else {
                 exit();
               }
             case -1:
             print("-1,-1");
               if (abs(F_ball_speed_y/F_ball_speed_x) <=  
                   abs((F_close_position_y_before-F_Ball_y_tran_)/(F_close_position_x_before-10-F_Ball_x_tran_))) {
                 F_fix_y_position = F_Ball_y_tran + 2*(F_close_position_y_before-F_Ball_y_tran);
                 F_fix_x_position = F_Ball_x_tran;
                 F_speed_y_tran = -F_speed_y_tran;
               }
               else if (abs(F_ball_speed_y/F_ball_speed_x) >=  
                        abs((F_close_position_y_before-10-F_Ball_y_tran_)/(F_close_position_x_before-F_Ball_x_tran_))) {
                 F_fix_x_position = F_Ball_x_tran + 2*(F_close_position_x_before-F_Ball_x_tran);
                 F_fix_y_position = F_Ball_y_tran;
                 F_speed_x_tran = -F_speed_x_tran;
               }
               else {
                 exit();
               }
           }
         }
         ball_speed_x_Brick = F_speed_x_tran*cos(F_ele) - F_speed_y_tran*sin(F_ele);
         ball_speed_y_Brick = F_speed_x_tran*sin(F_ele) + F_speed_y_tran*cos(F_ele);
         F_fix_y_position = F_Bk_y + (F_fix_x_position-F_Bk_x)*sin(F_ele) + (F_fix_y_position-F_Bk_y)*cos(F_ele);
         F_fix_x_position = F_Bk_x + (F_fix_x_position-F_Bk_x)*cos(F_ele) - (F_fix_y_position-F_Bk_y)*sin(F_ele);
         
         
       }
       
       else {
         F_fix_y_position = F_Bk_y + (F_Ball_x_tran-F_Bk_x)*sin(F_ele) + (F_Ball_y_tran-F_Bk_y)*cos(F_ele);
         F_fix_x_position = F_Bk_x + (F_Ball_x_tran-F_Bk_x)*cos(F_ele) - (F_Ball_y_tran-F_Bk_y)*sin(F_ele);
         float F_close_position_x_;
         float F_close_position_y_;
         F_close_position_x_ = F_Bk_x + (F_close_position_x-F_Bk_x)*cos(F_ele) - (F_close_position_y-F_Bk_y)*sin(F_ele);
         F_close_position_y_ = F_Bk_y + (F_close_position_x-F_Bk_x)*sin(F_ele) + (F_close_position_y-F_Bk_y)*cos(F_ele);
         
         F_close_position_x = F_close_position_x_;
         F_close_position_y = F_close_position_y_;
       
     
         I_x_case_ = I_x_case;
         I_y_case_ = I_y_case;
         
         F_close_position_x_before = F_close_position_x;
         F_close_position_y_before = F_close_position_y;
         
         stroke(255,0,255);
         line(F_Ball_x,F_Ball_y,F_close_position_x,F_close_position_y); 
         
         float RandB_distance = sqrt(pow(F_close_position_x-F_Ball_x,2)+pow(F_close_position_y-F_Ball_y,2));
         
         
         float[] F_unit_vector;
         F_unit_vector = new float[2];
         F_unit_vector[0] = (F_close_position_x-F_Ball_x)/RandB_distance;
         F_unit_vector[1] = (F_close_position_y-F_Ball_y)/RandB_distance;
         
         float[] F_Normal_vector;
         F_Normal_vector = new float[2];
         F_Normal_vector[0] = (F_unit_vector[0]*ball_speed_x_Brick+F_unit_vector[1]*ball_speed_y_Brick)*F_unit_vector[0];
         F_Normal_vector[1] = (F_unit_vector[0]*ball_speed_x_Brick+F_unit_vector[1]*ball_speed_y_Brick)*F_unit_vector[1];
         
         stroke(255,125,125);
         line(F_Ball_x,F_Ball_y,
              F_Ball_x+5*F_Normal_vector[0],F_Ball_y+5*F_Normal_vector[1]); 
         
         float[] F_Tangent_vector;
         F_Tangent_vector = new float[2];
         F_Tangent_vector[0] = -ball_speed_x_Brick+F_Normal_vector[0];
         F_Tangent_vector[1] = -ball_speed_y_Brick+F_Normal_vector[1];
         
         
         stroke(255,125,125);
         line(F_Ball_x-5*F_Tangent_vector[0],F_Ball_y-5*F_Tangent_vector[1],
              F_Ball_x+5*F_Tangent_vector[0],F_Ball_y+5*F_Tangent_vector[1]); 
         
         
         if (
           RandB_distance <= 10 & RandB_distance != 0
         ) {
            println("normal");
            I_brick_died=0;
            ball_speed_x_Brick = ball_speed_x_Brick - 2*F_Normal_vector[0];
            ball_speed_y_Brick = ball_speed_y_Brick - 2*F_Normal_vector[1];
            
         }
       }
       
       
       
    }
  }
  
}
