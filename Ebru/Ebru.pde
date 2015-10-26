
int taille=10000;
float[] x = new float[taille];
float[] y = new float[taille];


float[] xOld = new float[taille];
float[] yOld = new float[taille];

float[] stepSize = new float[taille];

void setup(){
  size(displayWidth,displayHeight);
  for(int i=0;i<x.length;i++){
    x[i]=random(width);
    y[i]=random(height);
    xOld[i]=x[i];
    yOld[i]=y[i];
    stepSize[i] = random(0,1.5);
  }
  background(255);
}

void draw(){
  //blue
  stroke(36,86,170,25);
  for(int i=0;i<x.length/2;i++){    
    float noiseScale=100;
    float noiseStrength=10;
    float angle = noise(x[i]/noiseScale,y[i]/noiseScale)*noiseStrength;
    x[i]+=cos(angle)*stepSize[i];
    y[i]+=sin(angle)*stepSize[i];
    if(x[i]<0){
      x[i]=random(width);
      y[i]=random(height);
      xOld[i]=x[i];
      yOld[i]=y[i];
    }
    if(y[i]<0){
      x[i]=random(width);
      y[i]=random(height);
      xOld[i]=x[i];
      yOld[i]=y[i];
    }
    if(x[i]>width){
      x[i]=random(width);
      y[i]=random(height);
      xOld[i]=x[i];
      yOld[i]=y[i];
    }
    if(y[i]>height){
      x[i]=random(width);
      y[i]=random(height);
      xOld[i]=x[i];
      yOld[i]=y[i];
    }
    
    line(xOld[i],yOld[i],x[i],y[i]);
    xOld[i]=x[i];
    yOld[i]=y[i];
  }
  
  stroke(193,71,37,25);
  for(int i=x.length/2;i<x.length;i++){    
    float noiseScale=100;
    float noiseStrength=10;
    float angle = noise(x[i]/noiseScale,y[i]/noiseScale)*noiseStrength;
    x[i]+=cos(angle)*stepSize[i];
    y[i]+=sin(angle)*stepSize[i];
    if(x[i]<0){
      x[i]=random(width);
      y[i]=random(height);
      xOld[i]=x[i];
      yOld[i]=y[i];
    }
    if(y[i]<0){
      x[i]=random(width);
      y[i]=random(height);
      xOld[i]=x[i];
      yOld[i]=y[i];
    }
    if(x[i]>width){
      x[i]=random(width);
      y[i]=random(height);
      xOld[i]=x[i];
      yOld[i]=y[i];
    }
    if(y[i]>height){
      x[i]=random(width);
      y[i]=random(height);
      xOld[i]=x[i];
      yOld[i]=y[i];
    }
    
    line(xOld[i],yOld[i],x[i],y[i]);
    xOld[i]=x[i];
    yOld[i]=y[i];
  }
}