void BallDistroy() {
  ArrayList Ball_num_list=new ArrayList();
  int[] Check = new int[ball.length];
  for (int i=0; i < ball.length;i++) {
    Check[i] = ball[i].Ball_died;
    if (Check[i]==1) {
      Ball_num_list.add(i);
    }
  }
  
  println(Ball_num_list.size());
  Ball[] ball_ = new Ball[Ball_num_list.size()];
  int j = 0;
  for (int i=0 ; i < ball.length ;i++) {
    if (ball[i].Ball_died == 1) {
       ball_[j] = ball[i];
       j = j +1;
    }
  }
  
  ball = ball_;
}
