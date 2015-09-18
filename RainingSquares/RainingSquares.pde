
int hue;
void setup(){
  size(displayWidth,displayHeight);
  background(0);
  //switch color mode to HSV
  colorMode(HSB, 360, 100, 100);
  //intialize hue
   hue = round(random(360));
}

void draw(){ 
  //create a color for square with
  //a fixed hue and some changes
  //in saturation and value
  fill(hue,random(100),random(100),20);
  stroke(0);
  rect(random(width),random(height),random(10,70),random(10,70));
}

//save current frame
void keyPressed() {
  saveFrame("output_"+ String.valueOf(millis())+ ".png");
}

