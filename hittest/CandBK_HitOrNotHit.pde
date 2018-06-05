void CandBK_HitOrNotHit(float F_C_x,float F_C_y,float F_C_r,float[] F_thing_x,float[] F_thing_y) {
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
  float F_check;
  float[] F_check_all = new float[F_thing_x.length];
  for (int i=0;i<F_thing_x.length;i++){
     F_check = F_Direction_vector_x[i]*(F_Direction_vector_x[F_min_num]/F_Direction_vector_l[F_min_num])+F_Direction_vector_y[i]*(F_Direction_vector_y[F_min_num]/F_Direction_vector_l[F_min_num]);
     F_check_all[i] = F_check;
  }
  
    stroke(125,255,125);
    line(F_C_x+F_Direction_vector_x[F_min_num]/F_Direction_vector_l[F_min_num]*F_C_r,
         F_C_y+F_Direction_vector_y[F_min_num]/F_Direction_vector_l[F_min_num]*F_C_r,
         F_C_x-F_Direction_vector_x[F_min_num]/F_Direction_vector_l[F_min_num]*F_C_r,
         F_C_y-F_Direction_vector_y[F_min_num]/F_Direction_vector_l[F_min_num]*F_C_r
         );
         
    stroke(125,125,255);
    line(F_C_x+F_Direction_vector_x[F_min_num]/F_Direction_vector_l[F_min_num]*max(F_check_all),
         F_C_y+F_Direction_vector_y[F_min_num]/F_Direction_vector_l[F_min_num]*max(F_check_all),
         F_C_x+F_Direction_vector_x[F_min_num]/F_Direction_vector_l[F_min_num]*min(F_check_all),
         F_C_y+F_Direction_vector_y[F_min_num]/F_Direction_vector_l[F_min_num]*min(F_check_all)
         );


  if (max(F_check_all) > -F_C_r & F_C_r > min(F_check_all)){
    //return 0;
  }
  //return 1;
  
}
