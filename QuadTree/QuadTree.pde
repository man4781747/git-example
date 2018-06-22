Point[] points = new Point[1000];

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
  for (int i=0;i<points.length;i++){
    points[i].show();
  }
}
