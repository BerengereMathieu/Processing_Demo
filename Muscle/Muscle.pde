import java.util.ArrayList;
class Element {
  int red;
  int green;
  int blue;
  float x_top;
  float x_bottom;
  float off;
  Element() {
  };


  void create_seed() {
    off=random(0);
    red=round(random(255));
    green=round(random(255));
    blue=round(random(255));
    x_top=random(width);
    x_bottom=random(width*0.1,width*0.5);
  }
  void setup() {
    create_seed();
  }

  void draw() {
    stroke(red, green, blue, 10);
    line(x_bottom, 0, x_top, height);
    float offset=map(noise(off), 0, 1, -1, 1);
    x_top+=offset;
    x_bottom+=offset;
    off+=0.01;
    if (random(1000)<2) create_seed();
  }
}

Element e;
void setup() {

  size(displayWidth, displayHeight);
  background(255);
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

