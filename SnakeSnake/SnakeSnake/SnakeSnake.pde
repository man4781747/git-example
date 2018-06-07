// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Video: https://youtu.be/hbgDqyy8bIw

Segment tentacle;

float F_x = 300;
float F_y = 200;

float F_V_x = 10;
float F_V_y = 10;
void setup() {
  size(600, 400);
  Segment current = new Segment(300, 200, 10, 0);

  for (int i = 0; i < 50; i++) {
    Segment next = new Segment(current, 10, i);
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

  //tentacle.follow(mouseX, mouseY);
  tentacle.follow(F_x, F_y);
  tentacle.update();
  tentacle.show();

  Segment next = tentacle.parent;
  while (next != null) {
    next.follow();
    next.update();
    next.show();
    next = next.parent;
  }
  if (F_x<0 || F_x>width){
    F_V_x = -F_V_x;
  }
  if (F_y<0 || F_y>height){
    F_V_y = -F_V_y;
  }
  F_x = F_x + F_V_x;
  F_y = F_y + F_V_y;
}
