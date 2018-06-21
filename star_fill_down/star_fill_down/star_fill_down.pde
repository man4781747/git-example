Aerolite[] aerolite;
float rotate_ang;
PVector day_1,day_2,day_3,day_4;
int Game_type;
PVector you_p = new PVector(0,-300);
float start_time_millis;
float start_time_sec;
float start_time_min;
float start_time_hr;
float time_total=0;
float time_max=0;
float time_test;
float time_test_ = second();

void mouseClicked() {
  if (Game_type == 0) {
    Game_type = 1;
    start_time_millis = millis();
    start_time_sec = second();
    start_time_min = minute();
    start_time_hr = hour();
  }
}

void Game_restart() {
  aerolite = new Aerolite[20];
  for (int i = 0;i<aerolite.length;i++){
    aerolite[i] = new Aerolite(random(0.02,0.03),
                               random(750,1000),
                               random(10,50),
                               random(-PI,PI));
  }
  Game_type = 0;
}

void add_aerolite(){
  Aerolite[] aerolite_ = new Aerolite[aerolite.length+1];
  for (int i = 0;i<aerolite.length;i++){
    aerolite_[i] = aerolite[i];
  }
  aerolite_[aerolite.length] = new Aerolite(random(0.01,0.03),
                               random(750,1000),
                               random(10,50),
                               random(-PI,PI));
  aerolite = aerolite_;
}

void setup() {
  //size(1000,800);
  fullScreen();
  Game_restart();
}

void draw() {
  background(0);
  translate(width/2,height);
  
  time_test = second();
  if (time_test_ != time_test && Game_type == 1){
    add_aerolite();
  }
  time_test_ = time_test;
  
  textFont(createFont("Arial", 50, true));
  textAlign(RIGHT);
  fill(255);
  text(aerolite.length, width/2, -height*9/10);
  textAlign(LEFT);
  text(time_max, -width/2, -height*9/10);
  
  rotate_ang = map(mouseX,0,width,-PI,PI);
  noStroke();
  fill(44,155,44);
  ellipse(0,0,500,500);
  fill(0);
  strokeWeight(3);
  stroke(255,0,0);
  ellipse(you_p.x,you_p.y,20,20);
  switch(Game_type) {
    case 0: 
      for (int i = 0;i<aerolite.length;i++){
        aerolite[i].Aerolite_show(rotate_ang);
      }
      textAlign(CENTER);
      fill(255);
      text("Press the MOUSE to start", 0, -height/2);
      text(time_total, 0, -height/10);
      break;
    case 1:
      for (int i = 0;i<aerolite.length;i++){
        aerolite[i].Aerolite_update();
        aerolite[i].Aerolite_show(rotate_ang);
        Game_type = aerolite[i].Aerolite_hit(you_p,rotate_ang);
        if (Game_type!=1){
          break;
        }
      }
      time_total = -((start_time_hr-hour())*3600+(start_time_min-minute())*60+(start_time_sec-second())+(start_time_millis-millis())*0.001);
      textAlign(CENTER);
      fill(255);
      text(time_total, 0, -height/10);
      if (time_total > time_max) {
        time_max = time_total;
      }
      break;
    
    case 2:
      Game_restart();
  }
}
