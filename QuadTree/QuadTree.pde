Point[] points = new Point[100];
Qtree[] qtrees = new Qtree[1];

void setup() {
  size(1000,1000);
  
  for (int i=0;i<points.length;i++){
    points[i] = new Point(randomGaussian()*width/8,
                          randomGaussian()*height/8,
                          5);
  }
  
}

void draw() {
  noLoop();
  translate(width/2,height/2);
  background(0);
  
  qtrees[0] = new Qtree(0, 0, width/2, height/2, 4);
  qtrees[0].QtreePointIn(points);
  
  for (int i=0;i<points.length;i++){
    points[i].show();
  }
  
}
