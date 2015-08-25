PVector position;//ball coordinates

PVector speed;//ball speed

float hOff;//offset to update ball color with perlin noise 

int radius;//ball radius

void setup(){
  size(displayWidth,displayHeight);
  background(255);
  position=new PVector(0,0);
  speed=new PVector(10,30);

  //generate seeds for random numbers
  //and print them to repeat a nice behaviour
  int seedR=round(random(MAX_INT));
  int seedN=round(random(MAX_INT));
  println("(" + seedR + " , " + seedN +")");
  //initialize random numbers generators
  randomSeed(seedR);
  noiseSeed(seedN);
  
  hOff=0.;
  
  //switch color mode to HSV
  colorMode(HSB, 360, 100, 100);
 
  //initialize ball radius
  radius=50;
}

void draw(){

  position.add(speed);
  hOff += 0.01;
   
  //check if the ball is inside the display window bounds
  if( (position.x>=width+radius/2) || (position.x<0) ){
  //out of bounds  
    speed.set(speed.x*-1,speed.y);
  }
  
  if( (position.y>=height+radius/2) || (position.y<0) ){
  //out of bounds
    speed.set(speed.x,speed.y*-1);
  }
  
  //update hue of ball according to its position
  int hue = round(map(noise(hOff), 0, 1, 0, 3*360));
  hue = hue % 360;
  //draw ball
  fill(hue,62,100,20);
  noStroke();
  ellipse(position.x,position.y,radius,radius);
}


//save current frame
void keyPressed() {
  saveFrame("output_"+ String.valueOf(millis())+ ".png");
}

