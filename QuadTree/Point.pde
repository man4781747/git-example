class Point{
  float x,y,r;
  
  Point(float x_, float y_, float r_){
    x = x_;
    y = y_;
    r = r_;
  }
  
  
  void show() {
    noStroke();
<<<<<<< HEAD
    fill(255,0,0);
=======
    fill(255,131,19);
>>>>>>> 34c4e69d2e6712fccdb77c33c573985db955445a
    ellipse(x,y,r,r);
  }
  
}
