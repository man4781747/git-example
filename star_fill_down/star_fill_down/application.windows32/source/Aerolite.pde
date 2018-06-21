class Aerolite{
  float v = 0;
  float a;
  float distance;
  float r;
  float rotate_angle;
  PVector p;
  float R = random(100,255);
  float G = random(100,255);
  float B = random(100,255);
  
  Aerolite(float g,float distance_,float r_,float rotate_angle_) {
    a = g;
    distance = distance_;
    r = r_;
    rotate_angle = rotate_angle_;
    p = new PVector(0,distance).rotate(rotate_angle);
  }
  
  void Aerolite_update(){
    v = v + a;
    distance = distance - v;
    p.set(0,distance).rotate(rotate_angle);
    Aerolite_re();
    
  }
  
  void Aerolite_re(){
    if (distance <= r/2+250){
      a = random(0.01,0.03);
      distance = random(750,1000);
      r = random(10,50);
      rotate_angle = random(-PI,PI);
      p = new PVector(0,distance).rotate(rotate_angle);
      v = 0;
      R = random(100,255);
      G = random(100,255);
      B = random(100,255);
    }
  }
  
  int Aerolite_hit(PVector you,float rotate_ang){
    float d = PVector.dist(p.copy().rotate(rotate_ang),you);
    if (d <= r/2+10) {
      return 2;
    } else {
      return 1;
    }
    
  }
  
  void Aerolite_show(float rotate_ang){
    noStroke();
    fill(R,G,B);
    ellipse(p.copy().rotate(rotate_ang).x,
            p.copy().rotate(rotate_ang).y,r,r);
  }
}
