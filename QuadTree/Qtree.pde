class Qtree {
  float x, y, L, H;
  Qtree[] qtreesNE;
  Qtree[] qtreesNW;
  Qtree[] qtreesSE;
  Qtree[] qtreesSW;
  boolean grow = false;
  int Size;
  Point[] PointInsideAll = new Point[0];
  Point[] PointInsideAll_ = new Point[0];
  Point[] PointOutsideAll = new Point[0];
  
  Qtree(float x_, float y_, float L_, float H_, int QtreeSize){
    x = x_;
    y = y_;
    L = L_;
    H = H_;
    Size = QtreeSize;
  }
  
  Point[] QtreePointIn(Point[] points){
    for (int i=0;i<points.length;i++){
      if(IsPointInQtree(points[i])){
        PointInsideAll = PointObjAdd(PointInsideAll, points[i]);
      } else {
        PointOutsideAll = PointObjAdd(PointOutsideAll, points[i]);
      }
    }
    if (PointInsideAll.length > Size && !grow){
      QtreeGrow();
    } else {
      stroke(50);
      //fill(255,0,0);
      line(x+L, y+H, x-L, y+H);
      line(x-L, y+H, x-L, y-H);
      line(x-L, y-H, x+L, y-H);
      line(x+L, y-H, x+L, y+H);
    };
    //PointInsideAll_ = PointInsideAll;
    //PointOutsideAll = points;
    return PointOutsideAll;
    //println(PointInsideAll.length);
  }
  
  boolean IsPointInQtree(Point point){
    if (point.x >= x+L || point.x <= x-L ||
        point.y >= y+H || point.y <= y-H) {
      return false;
    }
    return true;
  }
  
  void QtreeGrow(){
    qtreesNE = new Qtree[1];
    qtreesNE[0] = new Qtree(x+L/2, H/2+y, L/2, H/2, Size);
    PointInsideAll_ = qtreesNE[0].QtreePointIn(PointInsideAll);
    qtreesNW = new Qtree[1];
    qtreesNW[0] = new Qtree(x-L/2, H/2+y, L/2, H/2, Size);
    PointInsideAll_ = qtreesNW[0].QtreePointIn(PointInsideAll);
    qtreesSE = new Qtree[1];
    qtreesSE[0] = new Qtree(x+L/2, -H/2+y, L/2, H/2, Size);
    PointInsideAll_ = qtreesSE[0].QtreePointIn(PointInsideAll);
    qtreesSW = new Qtree[1];
    qtreesSW[0] = new Qtree(x-L/2, -H/2+y, L/2, H/2, Size);
    qtreesSW[0].QtreePointIn(PointInsideAll);
    
    grow = true;
  }
  
  Point[] PointObjAdd(Point[] Old, Point Add){
    Point[] points_ = new Point[Old.length+1];
    for (int i=0;i<Old.length;i++){
      points_[i] = Old[i];
    }
    points_[Old.length] = Add;
    
    return points_;
  }
  
}
