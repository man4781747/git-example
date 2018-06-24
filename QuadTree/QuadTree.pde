<<<<<<< HEAD
Point[] points = new Point[1000];
=======
Point[] points = new Point[0];
>>>>>>> 34c4e69d2e6712fccdb77c33c573985db955445a
Qtree[] qtrees = new Qtree[1];
int sec,millis;

void mouseDragged(){
  Point[] points_ = new Point[points.length+1];
  for (int i=0;i<points.length;i++){
    points_[i] = points[i];
  }
  points_[points.length] = new Point(mouseX-width/2,
                                     mouseY-height/2,
                                     5);
  points = points_;
                                     
}

void mouseDragged() {
  PointsAdd();
}

void PointsAdd() {
  Point[] points_ = new Point[points.length+1];
  for (int i=0;i<points.length;i++) {
    points_[i] = points[i];
  }
  points_[points.length] = new Point(randomGaussian()*5+mouseX-width/2,
                                     randomGaussian()*5+mouseY-height/2,
                                     5);
  points = points_;
  //println(mouseX-width/2);
  //println(mouseY-height/2);
}

void setup() {
  size(1000,1000);
  
  for (int i=0;i<points.length;i++){
    points[i] = new Point(randomGaussian()*width/8,
                          randomGaussian()*height/8,
                          5);
  }
  
}

void draw() {
<<<<<<< HEAD
  sec = second();
  millis = millis();
  //noLoop();
  
  //println(points.length);
=======
>>>>>>> 34c4e69d2e6712fccdb77c33c573985db955445a
  translate(width/2,height/2);
  background(0);
  
  qtrees[0] = new Qtree(0, 0, width/2, height/2, 5);
  qtrees[0].QtreePointIn(points);
  //println(points.length);
  for (int i=0;i<points.length;i++){
    points[i].show();
  }
  //println(millis-millis());
  //println((second()-sec)+(millis()-millis)/1000);
}
