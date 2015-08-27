import java.util.ArrayList;
class Element {
  int hue;
  int sat;
  int value;
  float x_top1;
  float x_bottom1;
  float off1;
  float off2;
  int end;
  int idx;
  Element() {
  };


  void create_seed() {
    off1=random(10);
    off2=random(10);
    hue=round(random(360*3)%360);
    sat=90;
    value=90;
    x_top1=random(width*0.1,width*0.5);
    x_bottom1=random(width);
    end=round(random(100,250));
    idx=0;
  }
  void setup() {
    create_seed();
  }

  void draw() {
    stroke(hue, sat, value,62);
    line(x_bottom1, 0, x_top1, height);
    //line(x_bottom2, 0, x_top2, height);
    float offset=map(noise(off1), 0, 1, -3, 3);
    x_top1+=offset;
    off1+=0.01;
    offset=map(noise(off2), 0, 1, -3, 3);
    x_bottom1+=offset;
    off2+=0.01;
    idx++;
    if(idx>=end){
      create_seed();
    }
  }
}

Element e;
void setup() {

  size(displayWidth, displayHeight);
  background(255);
  colorMode(HSB,360,100,100,255);
  smooth(4) ;
  e=new Element();
  e.setup();
  
  
  fill(51,25,90,5);
  noStroke();
  for(int x=0;x<width*height/10;x++){
    rect(random(-50,width),random(-50,height),random(50),random(50));
  }
}

void draw() {
  e.draw();
}


//save current frame
void keyPressed() {
  saveFrame("output_"+ String.valueOf(millis())+ ".png");
}

