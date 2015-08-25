import java.util.ArrayList;
class Element {
  int hue;
  int sat;
  int value;
  float x_top1;
  float x_bottom1;
  float x_top2;
  float x_bottom2;
  float off;
  Element() {
  };


  void create_seed() {
    off=random(10);
    hue=round(random(360*3)%360);
    sat=200;//round(random(125,175));
    value=255;
    x_top1=random(width);
    x_bottom1=random(width*0.1,width*0.5);
    x_top2=x_top1;
    x_bottom2=x_bottom1;
  }
  void setup() {
    create_seed();
  }

  void draw() {
    stroke(hue, sat, value, 10);
    line(x_bottom1, 0, x_top1, height);
    line(x_bottom2, 0, x_top2, height);
    float offset=map(noise(off), 0, 1, -1, 1);
    x_top1+=offset;
    x_bottom1+=offset;
    off+=0.01;
    offset=map(noise(off), 0, 1, -1, 1);
    x_top2+=offset;
    x_bottom2+=offset;
    off+=0.01;
    if (random(500)<1) create_seed();
  }
}

Element e;
void setup() {

  size(displayWidth, displayHeight);
  background(0);
  colorMode(HSB,360,255,255,255);
  strokeWeight(3);
  smooth(4) ;
  e=new Element();
  e.setup();
}

void draw() {
  e.draw();
}


//save current frame
void keyPressed() {
  saveFrame("output_"+ String.valueOf(millis())+ ".png");
}

