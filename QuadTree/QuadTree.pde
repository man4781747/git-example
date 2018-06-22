Point[] points = new Point[1000];
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

void setup() {
  size(1000,1000);
  
  for (int i=0;i<points.length;i++){
    points[i] = new Point(randomGaussian()*width/8,
                          randomGaussian()*height/8,
                          5);
  }
  
}

void draw() {
  sec = second();
  millis = millis();
  //noLoop();
  
  //println(points.length);
  translate(width/2,height/2);
  background(0);
  
  qtrees[0] = new Qtree(0, 0, width/2, height/2, 5);
  qtrees[0].QtreePointIn(points);
  
  for (int i=0;i<points.length;i++){
    points[i].show();
  }
  //println(millis-millis());
  //println((second()-sec)+(millis()-millis)/1000);
}
