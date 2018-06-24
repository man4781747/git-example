import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class QuadTree extends PApplet {

Point[] points = new Point[0];
Qtree[] qtrees = new Qtree[1];

public void mouseDragged() {
  PointsAdd();
}

public void PointsAdd() {
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

public void setup() {
  
  
  for (int i=0;i<points.length;i++){
    points[i] = new Point(randomGaussian()*width/8,
                          randomGaussian()*height/8,
                          5);
  }
  
}

public void draw() {
  translate(width/2,height/2);
  background(0);
  
  qtrees[0] = new Qtree(0, 0, width/2, height/2, 4);
  qtrees[0].QtreePointIn(points);
  //println(points.length);
  for (int i=0;i<points.length;i++){
    points[i].show();
  }
  
}
class Point{
  float x,y,r;
  
  Point(float x_, float y_, float r_){
    x = x_;
    y = y_;
    r = r_;
  }
  
  
  public void show() {
    noStroke();
    fill(255,131,19);
    ellipse(x,y,r,r);
  }
  
}
class Qtree {
  float x, y, L, H;
  Qtree[] qtreesNE;
  Qtree[] qtreesNW;
  Qtree[] qtreesSE;
  Qtree[] qtreesSW;
  boolean grow = false;
  int Size;
  Point[] PointInsideAll = new Point[0];
  
  Qtree(float x_, float y_, float L_, float H_, int QtreeSize){
    x = x_;
    y = y_;
    L = L_;
    H = H_;
    Size = QtreeSize;
  }
  
  public void QtreePointIn(Point[] points){
    for (int i=0;i<points.length;i++){
      if(IsPointInQtree(points[i])){
        PointInsideAll = PointObjAdd(PointInsideAll, points[i]);
      }
    }
    if (PointInsideAll.length > Size && !grow){
      QtreeGrow();
    } else {
      stroke(255);
      //fill(255,0,0);
      line(x+L, y+H, x-L, y+H);
      line(x-L, y+H, x-L, y-H);
      line(x-L, y-H, x+L, y-H);
      line(x+L, y-H, x+L, y+H);
    };
    //println(PointInsideAll.length);
  }
  
  public boolean IsPointInQtree(Point point){
    if (point.x >= x+L || point.x <= x-L ||
        point.y >= y+H || point.y <= y-H) {
      return false;
    }
    return true;
  }
  
  public void QtreeGrow(){
    qtreesNE = new Qtree[1];
    qtreesNE[0] = new Qtree(x+L/2, H/2+y, L/2, H/2, Size);
    qtreesNE[0].QtreePointIn(PointInsideAll);
    qtreesNW = new Qtree[1];
    qtreesNW[0] = new Qtree(x-L/2, H/2+y, L/2, H/2, Size);
    qtreesNW[0].QtreePointIn(PointInsideAll);
    qtreesSE = new Qtree[1];
    qtreesSE[0] = new Qtree(x+L/2, -H/2+y, L/2, H/2, Size);
    qtreesSE[0].QtreePointIn(PointInsideAll);
    qtreesSW = new Qtree[1];
    qtreesSW[0] = new Qtree(x-L/2, -H/2+y, L/2, H/2, Size);
    qtreesSW[0].QtreePointIn(PointInsideAll);
    
    grow = true;
  }
  
  public Point[] PointObjAdd(Point[] Old, Point Add){
    Point[] points_ = new Point[Old.length+1];
    for (int i=0;i<Old.length;i++){
      points_[i] = Old[i];
    }
    points_[Old.length] = Add;
    
    return points_;
  }
  
}
  public void settings() {  size(1000,1000); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--stop-color=#cccccc", "QuadTree" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
