import java.util.ArrayList;
PImage backIm;
class Element {
  PVector p;//position
  PVector s;//speed
  PVector a;//acceleration
  int hue;//hue in HSV
  int sat;//saturation in HSB
  int value;//value in HSV

  Element(float x, float y, int h) {
    p=new PVector(x, y);
    s=new PVector(0, 0);
    a=new PVector(0, 0);
    hue=h;
    sat=round(random(100));
    value=round(random(50, 100));
  }

  int distance(Element e2) {
    return round(sqrt(pow((this.p.y-e2.p.y), 2)+pow((this.p.x-e2.p.x), 2)));
  }
  void update(float X, float Y) {
    // Draw the particles
    int sigma=3000;
    a = new PVector(random(-0.1, 0.1)+(X-p.x)/sigma, random(-0.1, 0.1)+(Y-p.y)/sigma);
    s.add(a);
    p.add(s);

    int border=100;

    if (p.x<-border || p.x>width+border) {
      //restore previous point
      p.sub(s);
      //change speed
      s.set(-s.x, s.y);
      //recompute position
      p.add(s);
    }

    if (p.y<-border || p.y>height+border) {
      //restore previous point
      p.sub(s);
      //change speed
      s.set(s.x, -s.y);
      //recompute position
      p.add(s);
    }
  }
  void draw() {

    noStroke(); 
    fill(hue, sat, value, 62);  


    //draw particles
    ellipse(p.x, p.y, 5, 5); 
    fill(hue, sat, value, 255);
    ellipse(p.x, p.y, 30, 30);
  }
}

class Cluster {
  ArrayList<Element> elements;
  Cluster(int j, int columnWidthCenter, int nbElements, int nbClusters) {
    elements=new ArrayList<Element>();
    // initialise hue 
    float h=min(j*(360./nbClusters), 360.);

    //initialize position : put seed somewhere in the column j
    float iX=random(j*columnWidthCenter, (j+1)*columnWidthCenter);
    float iY= random(height);
    for (int i=0; i<nbElements; i++) {
      elements.add(new Element(iX, iY, round(h)));
    }
  }

  void draw() {


    float X=0;
    float Y=0;
    for (int i=0; i<elements.size (); i++) {
      X+=elements.get(i).p.x;
      Y+=elements.get(i).p.y;
    }
    X/=elements.size();
    Y/=elements.size();

    for (int i=0; i<elements.size (); i++) {
      elements.get(i).update(X, Y);
      elements.get(i).draw();
    }
  }

  int size() {
    return elements.size();
  }

  Element get(int x) {
    return elements.get(x);
  }
}



ArrayList<Cluster> clusters;
void setup() {
  colorMode(HSB, 360, 100, 100, 255);
  size(displayWidth, displayHeight);
  background(255);
  //noCursor();
  int k = 7; // We want 20 of them apples
  int nbClusters=7;
  // Particle array size is the number of particles we want

  //cut image in columns
  int columnWidthCenter=width/nbClusters;

  clusters=new ArrayList<Cluster>();

  for (int j=0; j<nbClusters; j++) {
    clusters.add(new Cluster(j, columnWidthCenter, 7, nbClusters));
  }


  backIm=createImage(width, height, RGB);
  backIm.loadPixels();
  int stepX=width/clusters.size();
  int nbY=ceil(height/stepX);
  int grays[][]=new int[nbY+1][clusters.size()+1];
  for (int y=0; y<=nbY; y++) {
    for (int x=0; x<=clusters.size (); x++) {

      grays[y][x]=round(random(255));
    }
  }
  for (int y=0; y<height; y++) {

    for (int x=0; x<width; x++) {
      int gray=grays[floor(y/stepX)][floor(x/stepX)];
      backIm.pixels[y*width+x]=color(gray);
    }
  }
}


void draw() {

  colorMode(RGB, 255, 255, 255);
  background(backIm);
  colorMode(HSB, 360, 100, 100, 255);

  for (int i=0; i<clusters.size (); i++) {
    //Update acceleration, speed and position 
    for (int j=0; j<clusters.get (i).size(); j++) { 
      Element e1=clusters.get(i).get(j);

      for (int y=0; y<clusters.size (); ++y) {
        for (int x=0; x<clusters.get (y).size(); x++) {
          Element e2=clusters.get(y).get(x);
          int dist=e1.distance(e2);
          if (dist<255) {
            stroke((e1.hue+e2.hue)/2, (e1.sat+e2.sat)/2, (e1.value+e2.value)/2, 255-dist);

            line(e1.p.x, e1.p.y, e2.p.x, e2.p.y); // Here we use the point visual primitive
          }
        }
      }
    }
  }
  
  
  for (int i=0; i<clusters.size (); i++) {
    clusters.get(i).draw();
  }
}

void keyPressed() {
  //saveFrame("output_"+ String.valueOf(millis())+ ".png");
}

