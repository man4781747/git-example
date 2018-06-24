Point[] points = new Point[0];
Qtree[] qtrees = new Qtree[1];

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
  translate(width/2,height/2);
  background(0);
  
  qtrees[0] = new Qtree(0, 0, width/2, height/2, 4);
  qtrees[0].QtreePointIn(points);
  //println(points.length);
  for (int i=0;i<points.length;i++){
    points[i].show();
  }
  
}
