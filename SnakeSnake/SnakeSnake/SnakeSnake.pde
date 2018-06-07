// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Video: https://youtu.be/hbgDqyy8bIw

Segment tentacle;

float F_x = 300;
float F_y = 200;

float F_r = 10;

float F_V_x = 5;
float F_V_y = 5;

int old_sec=0;
int new_sec;
void setup() {
  size(600, 400);
  Segment current = new Segment(300, 200, F_r, 0);

  for (int i = 0; i < 50; i++) {
    Segment next = new Segment(current, F_r, i);
    current.child = next;
    current = next;

  }
  tentacle = current;
}

void keyPressed() {
  if (key=='+'){
    Segment next = new Segment(tentacle, 10, 1);
    tentacle.child = next;
    tentacle = next;
  }
  
}
void draw() {
  background(51);
  new_sec = second();
  //tentacle.follow(mouseX, mouseY);
  tentacle.follow(F_x, F_y);
  tentacle.update();
  tentacle.show();
  Segment next = tentacle.parent;
  int i = 1;
  while (next != null) {
    next.follow();
    next.update();
    next.show();
    next.check(F_x, F_y);
    next = next.parent;
    i = i+1;
  }
  if (F_x<0 || F_x>width){
    F_V_x = -F_V_x;
  }
  if (F_y<0 || F_y>height){
    F_V_y = -F_V_y;
  }
  F_x = F_x + F_V_x;
  F_y = F_y + F_V_y;
  if (old_sec != new_sec) {
    Segment next_ = new Segment(tentacle, 10, 1);
    tentacle.child = next_;
    tentacle = next_;
  }
  
  
  old_sec = new_sec;
  
}
