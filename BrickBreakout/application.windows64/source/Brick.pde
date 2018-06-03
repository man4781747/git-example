class Brick {
  private float ball_speed_x_Brick;
  private float ball_speed_y_Brick;
  float F_Bk_x;
  float F_Bk_y;
  float F_Ball_distand;
  float F_bk_circle;
  float F_bk_H = height/50;
  float F_bk_L = width*0.9/16;
  int I_brick_died=1;
  float F_ele;
  int I_color_r=round(156*random(1)+100);
  int I_color_g=round(156*random(1)+100);
  int I_color_b=round(156*random(1)+100);
  
  
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
  
  void Brick_ball_distand(float F_Ball_x,float F_Ball_y,float F_ball_speed_x,float F_ball_speed_y) {
     F_Ball_distand =  sqrt(pow(F_Bk_x-F_Ball_x,2)+pow(F_Bk_y-F_Ball_y,2));
     F_bk_circle = sqrt(pow(F_bk_H,2)+pow(F_bk_L,2));
     
     float F_Ball_x_tran = F_Bk_x + (F_Ball_x-F_Bk_x)*cos(-F_ele) - (F_Ball_y-F_Bk_y)*sin(-F_ele);
     float F_Ball_y_tran = F_Bk_y + (F_Ball_x-F_Bk_x)*sin(-F_ele) + (F_Ball_y-F_Bk_y)*cos(-F_ele);
     
     ball_speed_x_Brick = F_ball_speed_x;
     ball_speed_y_Brick = F_ball_speed_y;
     
     if (F_Ball_distand <= 1.5*(F_bk_circle+10) ){   
       float F_close_position_y;
       float F_close_position_x;
       int I_x_case;
       int I_y_case;
       
       //fill(255,255,0);
       //noStroke();
       //ellipse(F_Ball_x_tran, F_Ball_y_tran, 10, 10);
       
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
       float F_close_position_x_;
       float F_close_position_y_;
       F_close_position_x_ = F_Bk_x + (F_close_position_x-F_Bk_x)*cos(F_ele) - (F_close_position_y-F_Bk_y)*sin(F_ele);
       F_close_position_y_ = F_Bk_y + (F_close_position_x-F_Bk_x)*sin(F_ele) + (F_close_position_y-F_Bk_y)*cos(F_ele);
       
       F_close_position_x = F_close_position_x_;
       F_close_position_y = F_close_position_y_;
       
       
       //stroke(255,0,255);
       //line(F_Ball_x,F_Ball_y,F_close_position_x,F_close_position_y); 
       
       float RandB_distance = sqrt(pow(F_close_position_x-F_Ball_x,2)+pow(F_close_position_y-F_Ball_y,2));
       
       float[] F_unit_vector;
       F_unit_vector = new float[2];
       F_unit_vector[0] = (F_close_position_x-F_Ball_x)/RandB_distance;
       F_unit_vector[1] = (F_close_position_y-F_Ball_y)/RandB_distance;
       
       float[] F_Normal_vector;
       F_Normal_vector = new float[2];
       F_Normal_vector[0] = (F_unit_vector[0]*ball_speed_x_Brick+F_unit_vector[1]*ball_speed_y_Brick)*F_unit_vector[0];
       F_Normal_vector[1] = (F_unit_vector[0]*ball_speed_x_Brick+F_unit_vector[1]*ball_speed_y_Brick)*F_unit_vector[1];
       
       //stroke(255,125,125);
       //line(F_Ball_x,F_Ball_y,
       //     F_Ball_x+5*F_Normal_vector[0],F_Ball_y+5*F_Normal_vector[1]); 
       
       float[] F_Tangent_vector;
       F_Tangent_vector = new float[2];
       F_Tangent_vector[0] = -ball_speed_x_Brick+F_Normal_vector[0];
       F_Tangent_vector[1] = -ball_speed_y_Brick+F_Normal_vector[1];
       
       /*
       stroke(255,125,125);
       line(F_Ball_x-5*F_Tangent_vector[0],F_Ball_y-5*F_Tangent_vector[1],
            F_Ball_x+5*F_Tangent_vector[0],F_Ball_y+5*F_Tangent_vector[1]); 
       */
       
       
       
       
       
       if (
         RandB_distance <= 10
       ) {
          I_brick_died=0;
          ball_speed_x_Brick = ball_speed_x_Brick - 2*F_Normal_vector[0];
          ball_speed_y_Brick = ball_speed_y_Brick - 2*F_Normal_vector[1];
          
       }
    }
  }
  
}
