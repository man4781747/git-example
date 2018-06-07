int CandBK_HitOrNotHit(float F_C_x,float F_C_y,float F_C_r,float[] F_thing_x,float[] F_thing_y) {
  
  float[] F_Tangent_vector_x;
  float[] F_Tangent_vector_y;
  float[] F_Normal_vector_x;
  float[] F_Normal_vector_y;
  F_Tangent_vector_x= new float[F_thing_x.length];
  F_Tangent_vector_y= new float[F_thing_x.length];
  F_Normal_vector_x = new float[F_thing_x.length];
  F_Normal_vector_y = new float[F_thing_x.length];
  
  int j = 1;
  for (int i=0;i<F_thing_x.length;i++) {
    if (j == F_thing_x.length) {
      j = 0; 
    }
    F_Tangent_vector_x[i] = F_thing_x[i]-F_thing_x[j];
    F_Tangent_vector_y[i] = F_thing_y[i]-F_thing_y[j];
    
    F_Normal_vector_x[i] =  F_Tangent_vector_y[i]/sqrt(pow(F_Tangent_vector_x[i],2)+pow(F_Tangent_vector_y[i],2));
    F_Normal_vector_y[i] = -F_Tangent_vector_x[i]/sqrt(pow(F_Tangent_vector_x[i],2)+pow(F_Tangent_vector_y[i],2));
    j = j + 1;
  }
  
  float F_check;
  float F_check_C;
  /*
  check
  */
  for (int k=0;k<F_thing_x.length;k++) {
    
    float F_break = 0;
    float[] F_check_all = new float[F_thing_x.length-1];
    
    for (int l=0;l<F_thing_x.length-1;l++) {
      int m = k+l+1;
      if (m >= F_thing_x.length) {
        m = m - F_thing_x.length; 
      }
      F_check = (F_thing_x[m]-F_thing_x[k])*F_Normal_vector_x[k]+(F_thing_y[m]-F_thing_y[k])*F_Normal_vector_y[k];
      F_check_all[l] = F_check;
    }
    
    F_check_C = (F_C_x-F_thing_x[k])*F_Normal_vector_x[k]+(F_C_y-F_thing_y[k])*F_Normal_vector_y[k];
  /*
    stroke(125,255,125);
    line(F_thing_x[k]+F_Tangent_vector_x[k]+F_Normal_vector_x[k]*max(F_check_all),F_thing_y[k]+F_Tangent_vector_y[k]+F_Normal_vector_y[k]*max(F_check_all),
         F_thing_x[k]+F_Tangent_vector_x[k]+F_Normal_vector_x[k]*min(F_check_all),F_thing_y[k]+F_Tangent_vector_y[k]+F_Normal_vector_y[k]*min(F_check_all));

    stroke(125,255,125);
    line(F_thing_x[k]+F_Tangent_vector_x[k]+F_Normal_vector_x[k]*(F_check_C+F_C_r),
         F_thing_y[k]+F_Tangent_vector_y[k]+F_Normal_vector_y[k]*(F_check_C+F_C_r),
         F_thing_x[k]+F_Tangent_vector_x[k]+F_Normal_vector_x[k]*(F_check_C-F_C_r),
         F_thing_y[k]+F_Tangent_vector_y[k]+F_Normal_vector_y[k]*(F_check_C-F_C_r)
         );
  */
    if (max(F_check_all) >F_check_C-F_ball_r/2 & F_check_C+F_C_r> min(F_check_all)){
      F_break = 1;
    }
    if (F_break == 0){
      return 0;
    }
  }
  
  /*
  check C
  */
  float[] F_Direction_vector_x;
  float[] F_Direction_vector_y;
  float[] F_Direction_vector_l;
  F_Direction_vector_x = new float[F_thing_x.length];
  F_Direction_vector_y = new float[F_thing_x.length];
  F_Direction_vector_l = new float[F_thing_x.length];
  
  int F_min_num = 0;
  
  for (int i=0;i<F_thing_x.length;i++) {
     F_Direction_vector_x[i] = F_thing_x[i] - F_C_x;
     F_Direction_vector_y[i] = F_thing_y[i] - F_C_y;
     F_Direction_vector_l[i] = sqrt(pow(F_Direction_vector_x[i],2)+pow(F_Direction_vector_y[i],2));
     if (i>0) {
       if (F_Direction_vector_l[i]<F_Direction_vector_l[F_min_num]) {F_min_num=i;}
     }
  }
  
  float[] F_check_all = new float[F_thing_x.length];
  float F_break = 0;
  for (int i=0;i<F_thing_x.length;i++){
     F_check = F_Direction_vector_x[i]*(F_Direction_vector_x[F_min_num]/F_Direction_vector_l[F_min_num])+F_Direction_vector_y[i]*(F_Direction_vector_y[F_min_num]/F_Direction_vector_l[F_min_num]);
     F_check_all[i] = F_check;
  }
    if (max(F_check_all) > -F_C_r & F_C_r > min(F_check_all)){
      F_break = 1;
    }
    if (F_break == 0){
      return 0;
    }
  

  
  return 1;
}
