float F_ball_r = 40;
float F_bk_x = 500;
float F_bk_y = 500;
float F_bk_L = 50;
float F_bk_H = F_ball_r/2;
float F_ele_base = 0;
float F_ele_mouse = 0;
float[] F_Tangent_vector_x;
float[] F_Tangent_vector_y;
float[] F_Normal_vector_x;
float[] F_Normal_vector_y;
float[] F_Tangent_vector_x_other;
float[] F_Tangent_vector_y_other;

float[] F_base_bk_x;
float[] F_base_bk_y;
float[] F_base_bl_x;
float[] F_base_bl_y;
float[] F_mouse_bk_1_x;
float[] F_mouse_bk_1_y;
float[] F_mouse_bk_2_x;
float[] F_mouse_bk_2_y;
float[] F_mouse_bl_x;
float[] F_mouse_bl_y;

float F_circle_speed = 0.5;
int I_hit_b_1 = 0;
int I_hit_b_2 = 0;
int I_hit_c1 = 0;
int I_hit_c2 = 0;

void keyPressed() {
  if (key=='+'){
    F_ele_mouse = F_ele_mouse + 15*PI/180;
  }
  
  if (key=='-'){
    F_ele_mouse = F_ele_mouse - 15*PI/180;
  }
}


void setup() {
  size(1000,1000);
  
}

void draw() {
  background(0);
  
  /* base */
  F_base_bk_x = new float[4];
  F_base_bk_y = new float[4];
  
  F_base_bk_x[0] = F_bk_x+F_bk_L*cos(F_ele_base)-F_bk_H*sin(F_ele_base);
  F_base_bk_x[1] = F_bk_x-F_bk_L*cos(F_ele_base)-F_bk_H*sin(F_ele_base);
  F_base_bk_x[2] = F_bk_x-F_bk_L*cos(F_ele_base)+F_bk_H*sin(F_ele_base);
  F_base_bk_x[3] = F_bk_x+F_bk_L*cos(F_ele_base)+F_bk_H*sin(F_ele_base);
  
  F_base_bk_y[0] = F_bk_y+F_bk_L*sin(F_ele_base)+F_bk_H*cos(F_ele_base);
  F_base_bk_y[1] = F_bk_y-F_bk_L*sin(F_ele_base)+F_bk_H*cos(F_ele_base);
  F_base_bk_y[2] = F_bk_y-F_bk_L*sin(F_ele_base)-F_bk_H*cos(F_ele_base);
  F_base_bk_y[3] = F_bk_y+F_bk_L*sin(F_ele_base)-F_bk_H*cos(F_ele_base);
  
  fill(255,255-I_hit_b_1*255,255);
  noStroke();
  quad(F_base_bk_x[0], F_base_bk_y[0],
       F_base_bk_x[1], F_base_bk_y[1],
       F_base_bk_x[2], F_base_bk_y[2],
       F_base_bk_x[3], F_base_bk_y[3]);
       
  F_base_bl_x = new float[2];
  F_base_bl_y = new float[2]; 
       
  F_base_bl_x[0] = F_bk_x-F_bk_L;
  F_base_bl_x[1] = F_bk_x+F_bk_L;
  F_base_bl_y[0] = F_bk_y;
  F_base_bl_y[1] = F_bk_y; 
       
  //noStroke();
  //ellipse(F_base_bl_x[0],F_base_bl_y[0],F_ball_r,F_ball_r);
  //ellipse(F_base_bl_x[1],F_base_bl_y[1],F_ball_r,F_ball_r);
  
  /* mouse */
  F_mouse_bk_1_x = new float[4];
  F_mouse_bk_1_y = new float[4];
  /*
  F_mouse_bk_x[0] = mouseX+F_bk_L*cos(F_ele_mouse)-F_bk_H*sin(F_ele_mouse);
  F_mouse_bk_x[1] = mouseX-F_bk_L*cos(F_ele_mouse)-F_bk_H*sin(F_ele_mouse);
  F_mouse_bk_x[2] = mouseX-F_bk_L*cos(F_ele_mouse)+F_bk_H*sin(F_ele_mouse);
  F_mouse_bk_x[3] = mouseX+F_bk_L*cos(F_ele_mouse)+F_bk_H*sin(F_ele_mouse);
  
  F_mouse_bk_y[0] = mouseY+F_bk_L*sin(F_ele_mouse)+F_bk_H*cos(F_ele_mouse);
  F_mouse_bk_y[1] = mouseY-F_bk_L*sin(F_ele_mouse)+F_bk_H*cos(F_ele_mouse);
  F_mouse_bk_y[2] = mouseY-F_bk_L*sin(F_ele_mouse)-F_bk_H*cos(F_ele_mouse);
  F_mouse_bk_y[3] = mouseY+F_bk_L*sin(F_ele_mouse)-F_bk_H*cos(F_ele_mouse);
  */
  F_mouse_bk_1_x[0] = mouseX+F_bk_L*cos(F_ele_mouse);
  F_mouse_bk_1_x[1] = mouseX-F_bk_L*cos(F_ele_mouse);
  F_mouse_bk_1_x[2] = mouseX-F_bk_L*cos(F_ele_mouse)+F_bk_H*sin(F_ele_mouse);
  F_mouse_bk_1_x[3] = mouseX+F_bk_L*cos(F_ele_mouse)+F_bk_H*sin(F_ele_mouse);
  
  F_mouse_bk_1_y[0] = mouseY+F_bk_L*sin(F_ele_mouse);
  F_mouse_bk_1_y[1] = mouseY-F_bk_L*sin(F_ele_mouse);
  F_mouse_bk_1_y[2] = mouseY-F_bk_L*sin(F_ele_mouse)-F_bk_H*cos(F_ele_mouse);
  F_mouse_bk_1_y[3] = mouseY+F_bk_L*sin(F_ele_mouse)-F_bk_H*cos(F_ele_mouse);
  
  F_mouse_bk_2_x = new float[4];
  F_mouse_bk_2_y = new float[4];
  
  F_mouse_bk_2_x[0] = mouseX+F_bk_L*cos(F_ele_mouse);
  F_mouse_bk_2_x[1] = mouseX-F_bk_L*cos(F_ele_mouse);
  F_mouse_bk_2_x[2] = mouseX-F_bk_L*cos(F_ele_mouse)-F_bk_H*sin(F_ele_mouse);
  F_mouse_bk_2_x[3] = mouseX+F_bk_L*cos(F_ele_mouse)-F_bk_H*sin(F_ele_mouse);
  
  F_mouse_bk_2_y[0] = mouseY+F_bk_L*sin(F_ele_mouse);
  F_mouse_bk_2_y[1] = mouseY-F_bk_L*sin(F_ele_mouse);
  F_mouse_bk_2_y[2] = mouseY-F_bk_L*sin(F_ele_mouse)+F_bk_H*cos(F_ele_mouse);
  F_mouse_bk_2_y[3] = mouseY+F_bk_L*sin(F_ele_mouse)+F_bk_H*cos(F_ele_mouse);
  
  fill(255,I_hit_b_1*255,0);
  noStroke();
  quad(F_mouse_bk_1_x[0], F_mouse_bk_1_y[0],
       F_mouse_bk_1_x[1], F_mouse_bk_1_y[1],
       F_mouse_bk_1_x[2], F_mouse_bk_1_y[2],
       F_mouse_bk_1_x[3], F_mouse_bk_1_y[3]);
  
  fill(255,I_hit_b_2*255,0);
  noStroke();
  quad(F_mouse_bk_2_x[0], F_mouse_bk_2_y[0],
       F_mouse_bk_2_x[1], F_mouse_bk_2_y[1],
       F_mouse_bk_2_x[2], F_mouse_bk_2_y[2],
       F_mouse_bk_2_x[3], F_mouse_bk_2_y[3]);
  
  
  
  
  F_mouse_bl_x = new float[2];
  F_mouse_bl_y = new float[2]; 
       
  F_mouse_bl_x[0] = mouseX-F_bk_L*cos(F_ele_mouse);
  F_mouse_bl_x[1] = mouseX+F_bk_L*cos(F_ele_mouse);
  F_mouse_bl_y[0] = mouseY-F_bk_L*sin(F_ele_mouse);
  F_mouse_bl_y[1] = mouseY+F_bk_L*sin(F_ele_mouse); 
  
  fill(255,I_hit_c1*255,0);
  noStroke();
  ellipse(F_mouse_bl_x[0],F_mouse_bl_y[0],F_ball_r,F_ball_r);
  fill(255,I_hit_c2*255,0);
  ellipse(F_mouse_bl_x[1],F_mouse_bl_y[1],F_ball_r,F_ball_r);
  
  
  
  I_hit_b_1 = BKandBK_HitOrNotHit(F_base_bk_x,F_base_bk_y,F_mouse_bk_1_x,F_mouse_bk_1_y);
  I_hit_b_2 = BKandBK_HitOrNotHit(F_base_bk_x,F_base_bk_y,F_mouse_bk_2_x,F_mouse_bk_2_y);
  I_hit_c1 = CandBK_HitOrNotHit(F_mouse_bl_x[0],F_mouse_bl_y[0],F_ball_r/2,F_base_bk_x,F_base_bk_y);
  I_hit_c2 = CandBK_HitOrNotHit(F_mouse_bl_x[1],F_mouse_bl_y[1],F_ball_r/2,F_base_bk_x,F_base_bk_y);
  
  
  //print(HitOrNotHit(F_base_bk_x,F_base_bk_y,F_mouse_bk_x,F_mouse_bk_y));
  
  /* check */

  /*
  F_Tangent_vector_x= new float[4];
  F_Tangent_vector_y= new float[4];
  F_Normal_vector_x = new float[4];
  F_Normal_vector_y = new float[4];
  
  int j = 1;
  for (int i=0;i<4;i++) {
    if (j == 4) {
      j = 0; 
    }
    F_Tangent_vector_x[i] = F_base_bk_x[i]-F_base_bk_x[j];
    F_Tangent_vector_y[i] = F_base_bk_y[i]-F_base_bk_y[j];
    
    F_Normal_vector_x[i] = F_Tangent_vector_y[i]/sqrt(pow(F_Tangent_vector_x[i],2)+pow(F_Tangent_vector_y[i],2));
    F_Normal_vector_y[i] = -F_Tangent_vector_x[i]/sqrt(pow(F_Tangent_vector_x[i],2)+pow(F_Tangent_vector_y[i],2));
    
    //stroke(125,255,125);
    //line(F_bk_x,F_bk_y,F_bk_x+F_Normal_vector_x[i]*100,F_bk_y+F_Normal_vector_y[i]*100);
    j = j + 1;
  }
  
  float F_check_base;
  float F_check_mouse;
  for (int k=0;k<4;k++) {
    float[] F_check_base_all = new float[3];
    float[] F_check_mouse_all = new float[4];
    
    for (int l=0;l<3;l++) {
      int m = k+l+1;
      if (m >= 4) {
        m = m - 4; 
      }
      F_check_base = (F_base_bk_x[m]-F_base_bk_x[k])*F_Normal_vector_x[k]+(F_base_bk_y[m]-F_base_bk_y[k])*F_Normal_vector_y[k];
      F_check_base_all[l] = F_check_base;
    }
    
    for (int n=0;n<4;n++) {
      int o = k+n+1;
      if (o >= 4) {
        o = o - 4; 
      }
      F_check_mouse = (F_mouse_bk_x[o]-F_base_bk_x[k])*F_Normal_vector_x[k]+(F_mouse_bk_y[o]-F_base_bk_y[k])*F_Normal_vector_y[k];
      F_check_mouse_all[n] = F_check_mouse;

    }
    noStroke();
    ellipse(F_base_bk_x[k]+F_Tangent_vector_x[k],F_base_bk_y[k]+F_Tangent_vector_y[k],5,5);
    ellipse(F_base_bk_x[k],F_base_bk_y[k],5,5);
    
    stroke(125,255,125);
    line(F_base_bk_x[k]+F_Tangent_vector_x[k]+F_Normal_vector_x[k]*max(F_check_base_all),F_base_bk_y[k]+F_Tangent_vector_y[k]+F_Normal_vector_y[k]*max(F_check_base_all),
         F_base_bk_x[k]+F_Tangent_vector_x[k]+F_Normal_vector_x[k]*min(F_check_base_all),F_base_bk_y[k]+F_Tangent_vector_y[k]+F_Normal_vector_y[k]*min(F_check_base_all));
         
    stroke(255,0,0);
    line(F_base_bk_x[k]+F_Tangent_vector_x[k]+F_Normal_vector_x[k]*max(F_check_mouse_all),F_base_bk_y[k]+F_Tangent_vector_y[k]+F_Normal_vector_y[k]*max(F_check_mouse_all),
         F_base_bk_x[k]+F_Tangent_vector_x[k]+F_Normal_vector_x[k]*min(F_check_mouse_all),F_base_bk_y[k]+F_Tangent_vector_y[k]+F_Normal_vector_y[k]*min(F_check_mouse_all));
  }
  */
  
  
  
  F_ele_base = F_ele_base + F_circle_speed*PI/180;
  if (F_ele_base >= 2*PI) {
    F_ele_base =F_ele_base - 2*PI;
  }
 
}
