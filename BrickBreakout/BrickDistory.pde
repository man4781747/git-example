void BrickDistroy() {
  if (brick.length > 0) {
    ArrayList Brick_num_list=new ArrayList();
    int[] Brick_Check = new int[brick.length];
    for (int i=0; i < brick.length;i++) {
      Brick_Check[i] = brick[i].I_brick_died;
      if (Brick_Check[i]==1) {
        Brick_num_list.add(i);
      }
    }
    
    //println(Ball_num_list.size());
    Brick[] brick_ = new Brick[Brick_num_list.size()];
    int j = 0;
    for (int i=0 ; i < brick.length ;i++) {
      if (brick[i].I_brick_died == 1) {
         brick_[j] = brick[i];
         j = j +1;
      }
    }
    
    brick = brick_;
  }
}
