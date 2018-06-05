int BKandBK_HitOrNotHit(float[] F_thing_a_x,float[] F_thing_a_y,float[] F_thing_b_x,float[] F_thing_b_y) {
  float[] F_a_Tangent_vector_x;
  float[] F_a_Tangent_vector_y;
  float[] F_a_Normal_vector_x;
  float[] F_a_Normal_vector_y;
  F_a_Tangent_vector_x= new float[F_thing_a_x.length];
  F_a_Tangent_vector_y= new float[F_thing_a_x.length];
  F_a_Normal_vector_x = new float[F_thing_a_x.length];
  F_a_Normal_vector_y = new float[F_thing_a_x.length];
  
  float[] F_b_Tangent_vector_x;
  float[] F_b_Tangent_vector_y;
  float[] F_b_Normal_vector_x;
  float[] F_b_Normal_vector_y;
  F_b_Tangent_vector_x= new float[F_thing_b_x.length];
  F_b_Tangent_vector_y= new float[F_thing_b_x.length];
  F_b_Normal_vector_x = new float[F_thing_b_x.length];
  F_b_Normal_vector_y = new float[F_thing_b_x.length];
  
  int j = 1;
  for (int i=0;i<F_thing_a_x.length;i++) {
    if (j == F_thing_a_x.length) {
      j = 0; 
    }
    F_a_Tangent_vector_x[i] = F_thing_a_x[i]-F_thing_a_x[j];
    F_a_Tangent_vector_y[i] = F_thing_a_y[i]-F_thing_a_y[j];
    
    F_a_Normal_vector_x[i] =  F_a_Tangent_vector_y[i]/sqrt(pow(F_a_Tangent_vector_x[i],2)+pow(F_a_Tangent_vector_y[i],2));
    F_a_Normal_vector_y[i] = -F_a_Tangent_vector_x[i]/sqrt(pow(F_a_Tangent_vector_x[i],2)+pow(F_a_Tangent_vector_y[i],2));
    j = j + 1;
  }
  
  j = 1;
  for (int i=0;i<F_thing_b_x.length;i++) {
    if (j == F_thing_b_x.length) {
      j = 0; 
    }
    F_b_Tangent_vector_x[i] = F_thing_b_x[i]-F_thing_b_x[j];
    F_b_Tangent_vector_y[i] = F_thing_b_y[i]-F_thing_b_y[j];
    
    F_b_Normal_vector_x[i] =  F_b_Tangent_vector_y[i]/sqrt(pow(F_b_Tangent_vector_x[i],2)+pow(F_b_Tangent_vector_y[i],2));
    F_b_Normal_vector_y[i] = -F_b_Tangent_vector_x[i]/sqrt(pow(F_b_Tangent_vector_x[i],2)+pow(F_b_Tangent_vector_y[i],2));
    j = j + 1;
  }
  
  float F_check_a;
  float F_check_b;
  /*
  a check
  */
  for (int k=0;k<F_thing_a_x.length;k++) {
    float F_break = 0;
  //for (int k=0;k<1;k++) {
    float[] F_check_a_all = new float[F_thing_a_x.length-1];
    float[] F_check_b_all = new float[F_thing_b_x.length];
    
    for (int l=0;l<F_thing_a_x.length-1;l++) {
      int m = k+l+1;
      if (m >= F_thing_a_x.length) {
        m = m - F_thing_a_x.length; 
      }
      F_check_a = (F_thing_a_x[m]-F_thing_a_x[k])*F_a_Normal_vector_x[k]+(F_thing_a_y[m]-F_thing_a_y[k])*F_a_Normal_vector_y[k];
      F_check_a_all[l] = F_check_a;
    }
    
    for (int n=0;n<F_thing_b_x.length;n++) {
      int o = k+n+1;
      if (o >= F_thing_b_x.length) {
        o = o - F_thing_b_x.length; 
      }
      F_check_b = (F_thing_b_x[o]-F_thing_a_x[k])*F_a_Normal_vector_x[k]+(F_thing_b_y[o]-F_thing_a_y[k])*F_a_Normal_vector_y[k];
      F_check_b_all[n] = F_check_b;
    }
    /*
    noStroke();
    ellipse(F_thing_a_x[k]+F_a_Tangent_vector_x[k],F_thing_a_y[k]+F_a_Tangent_vector_y[k],5,5);
    ellipse(F_thing_a_x[k],F_thing_a_y[k],5,5);
    
    stroke(125,255,125);
    line(F_thing_a_x[k]+F_a_Tangent_vector_x[k]+F_a_Normal_vector_x[k]*max(F_check_a_all),F_thing_a_y[k]+F_a_Tangent_vector_y[k]+F_a_Normal_vector_y[k]*max(F_check_a_all),
         F_thing_a_x[k]+F_a_Tangent_vector_x[k]+F_a_Normal_vector_x[k]*min(F_check_a_all),F_thing_a_y[k]+F_a_Tangent_vector_y[k]+F_a_Normal_vector_y[k]*min(F_check_a_all));
         
    stroke(255,0,0);
    line(F_thing_a_x[k]+F_a_Tangent_vector_x[k]+F_a_Normal_vector_x[k]*max(F_check_b_all),F_thing_a_y[k]+F_a_Tangent_vector_y[k]+F_a_Normal_vector_y[k]*max(F_check_b_all),
         F_thing_a_x[k]+F_a_Tangent_vector_x[k]+F_a_Normal_vector_x[k]*min(F_check_b_all),F_thing_a_y[k]+F_a_Tangent_vector_y[k]+F_a_Normal_vector_y[k]*min(F_check_b_all));
    */
         
    if (max(F_check_a_all) >min(F_check_b_all) & max(F_check_b_all) > min(F_check_a_all)){
      F_break = 1;
    }
    if (F_break == 0){
      return 0;
    }
  }
  /*
  b check
  */
  for (int k=0;k<F_thing_b_x.length;k++) {
    float F_break = 0;
  //for (int k=0;k<1;k++) {
    float[] F_check_a_all = new float[F_thing_a_x.length];
    float[] F_check_b_all = new float[F_thing_b_x.length-1];
    
    for (int l=0;l<F_thing_b_x.length-1;l++) {
      int m = k+l+1;
      if (m >= F_thing_b_x.length) {
        m = m - F_thing_b_x.length; 
      }
      F_check_b = (F_thing_b_x[m]-F_thing_b_x[k])*F_b_Normal_vector_x[k]+(F_thing_b_y[m]-F_thing_b_y[k])*F_b_Normal_vector_y[k];
      F_check_b_all[l] = F_check_b;
    }
    
    for (int n=0;n<F_thing_a_x.length;n++) {
      int o = k+n+1;
      if (o >= F_thing_a_x.length) {
        o = o - F_thing_a_x.length; 
      }
      F_check_a = (F_thing_a_x[o]-F_thing_b_x[k])*F_b_Normal_vector_x[k]+(F_thing_a_y[o]-F_thing_b_y[k])*F_b_Normal_vector_y[k];
      F_check_a_all[n] = F_check_a;
    }
    
    /*
    noStroke();
    ellipse(F_thing_b_x[k]+F_b_Tangent_vector_x[k],F_thing_b_y[k]+F_b_Tangent_vector_y[k],5,5);
    ellipse(F_thing_b_x[k],F_thing_b_y[k],5,5);
    
    stroke(125,255,125);
    line(F_thing_b_x[k]+F_b_Tangent_vector_x[k]+F_b_Normal_vector_x[k]*max(F_check_b_all),F_thing_b_y[k]+F_b_Tangent_vector_y[k]+F_b_Normal_vector_y[k]*max(F_check_b_all),
         F_thing_b_x[k]+F_b_Tangent_vector_x[k]+F_b_Normal_vector_x[k]*min(F_check_b_all),F_thing_b_y[k]+F_b_Tangent_vector_y[k]+F_b_Normal_vector_y[k]*min(F_check_b_all));
         
    stroke(255,0,0);
    line(F_thing_b_x[k]+F_b_Tangent_vector_x[k]+F_b_Normal_vector_x[k]*max(F_check_a_all),F_thing_b_y[k]+F_b_Tangent_vector_y[k]+F_b_Normal_vector_y[k]*max(F_check_a_all),
         F_thing_b_x[k]+F_b_Tangent_vector_x[k]+F_b_Normal_vector_x[k]*min(F_check_a_all),F_thing_b_y[k]+F_b_Tangent_vector_y[k]+F_b_Normal_vector_y[k]*min(F_check_a_all));
    */
    
    if (max(F_check_a_all) >min(F_check_b_all) & max(F_check_b_all) > min(F_check_a_all)){
      F_break = 1;
    }
    if (F_break == 0){
      return 0;
    }
  }
  
  
  return 1;
}
