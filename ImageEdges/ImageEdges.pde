import java.util.ArrayList;
PImage im;

ArrayList<Integer> boundaryPoints;
int idxBoundary;

void setup() {
  im=loadImage("image1.jpg");
  size(im.width, im.height);
  background(im);
  idxBoundary=0;
  getBoundaryPoints();
}

void getBoundaryPoints() {
  boundaryPoints = new ArrayList<Integer>();
  PImage boundary=loadImage("boundary1.jpg");

  boundary.loadPixels();
  int nbPixels=boundary.width*boundary.height;
  for (int i=0; i<nbPixels; i++) {
    color currentPixel=boundary.pixels[i];
    if (red(currentPixel)+green(currentPixel)+blue(currentPixel)==0) {
      //get boundary point
      boundaryPoints.add(i);
    }
  }
}


void draw() {
  idxBoundary=round(random(boundaryPoints.size()));
  im.loadPixels();

  color pixel=im.pixels[boundaryPoints.get(idxBoundary)];
  stroke(255, 0, 0, 23);
  noFill();
  ellipse(boundaryPoints.get(idxBoundary)%width, boundaryPoints.get(idxBoundary)/width, 3, 3);
}

