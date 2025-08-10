float[][] x = new float[2000][5];
int n1 = 1000;
int n2 = 1000;
int n = 0, f = 0;
long[] p = new long[1000]; 
float[] test = new float[100000];

void setup(){
  fullScreen();   
  //size(500,500);
  frameRate(1000);
    int i, j, m=0;

    for(i=0; i<n1+n2; i++){
        x[i][0] = random(height);
        x[i][1] = random(height);
        for(j=0; j<i; j++){
          if(abs(x[i][0]-x[j][0])<10&&abs(x[i][1]-x[j][1])<10){
             m = 1;
          }
        }
        x[i][2] = random(-1, 1);
        if(random(0,2)<1){
            j = -1;
        }
        else{
            j = 1;
        }
        x[i][3] = j*sqrt(1-(x[i][2]*x[i][2]));
        if(m==1){
          i--;
          m = 0;
        }
    }
}

void draw(){
    background(255);
    int i, j, m;
    int[] s = new int[1000];
    float a, b, c, d;
    m = 0;
    if(keyPressed && key == 32){
      m = 1;  
    }
    textSize(16);
    fill(0,0,0);
    text("Screen Setup = " + width + " * " + height + "\nTable Setup = " + height + " * " + height + "\nFrame = " + f, height+10, 26);
    textSize(32);
    text("Molecule 1(Green)\nMolecule 2(Blue)\nMolecule Sum", height+10, 120);
    text("= "+n1+"\n= "+n2+"\n= "+(n1+n2), height+300, 120);
    text("Molecule Reaction time = " + n + "\nMolecule Reaction speed(/kFrame) = " + ((float)n*1000/(f-500)), height+10, 300);
    
    for(i=0; i<n1+n2; i++){
      if(i>n1){
        fill(135,206,255);
      }
      else{
        fill(10,255,10);
      }
      circle(x[i][0], x[i][1], 10);
      if(m==1){
        fill(0,0,0);
        line(x[i][0], x[i][1], x[i][0]+(30*x[i][2]), x[i][1]+(30*x[i][3]));  
      }
      x[i][0] = x[i][0] + x[i][2];
      x[i][1] = x[i][1] + x[i][3];
      if(x[i][0]<0){
        x[i][2] = -x[i][2];
        x[i][0] = 0;
        x[i][4] = 0;
      }
      else if(height<x[i][0]){
        x[i][2] = -x[i][2];
        x[i][0] = height;
        x[i][4] = 0;
      }
      else if(x[i][1]<0){
        x[i][3] = -x[i][3];
        x[i][1] = 0;
        x[i][4] = 0;
      }
      else if(height<x[i][1]){
        x[i][3] = -x[i][3];
        x[i][1] = height;
        x[i][4] = 0;
      }
      else {
        for(j=i+1; j<n1+n2; j++){
          if((x[i][0]-x[j][0])*(x[i][0]-x[j][0])+(x[i][1]-x[j][1])*(x[i][1]-x[j][1])<100&&(x[i][4]!=j||x[j][4]!=i)){
            a = x[i][0]-x[j][0];
            b = x[i][1]-x[j][1];
            c = a/sqrt((a*a)+(b*b));
            d = b/sqrt((a*a)+(b*b));
            a = x[i][2]*c+x[i][3]*d;
            b = x[j][2]*c+x[j][3]*d;
            x[i][2] = x[i][2] - (a*c) + (b*c); 
            x[j][2] = x[j][2] - (b*c) + (a*c);
            x[i][3] = x[i][3] - (a*d) + (b*d);
            x[j][3] = x[j][3] - (b*d) + (a*d);
            x[i][0]+=x[i][2];
            x[i][1]+=x[i][3];
            x[j][0]+=x[j][2];
            x[j][1]+=x[j][3];
            x[i][4] = j;
            x[j][4] = i;
            if(i<n1&&j>=n1&&f>500){
              n++;
            }
          } 
        }
      }
    };
    f++;
    fill(0);
    text("Molecule speed", height+300, 450);
    
    textSize(16);
    text("amount\n(none)", height+105, 485);
    text("speed\n(pixel/frame)", height+650, height-80);
    text("10", height+140, height-143);
    text("20", height+140, height-193);
    text("30", height+140, height-243);
    text("40", height+140, height-293);
    text("50", height+140, height-343);
    text("60", height+140, height-393);
    text("70", height+140, height-443);
    text("80", height+140, height-493);
    text("90", height+140, height-543);
    text("1", height+315, height-80);
    text("2", height+465, height-80);
    text("3", height+615, height-80);
    
    
    for(i=0; i<10; i++){
      line(height+170, height-100-(50*i), height+670, height-100-(50*i));
    }

    for(i=0; i<17; i++){
      line(height+170+(30*i), height-100, height+170+(30*i), height-600);
    }
    
    for(i=0; i<n1+n2; i++){
      s[int(30*sqrt((x[i][2]*x[i][2])+(x[i][3]*x[i][3])))]++;
      if(f>500){
        p[int(30*sqrt((x[i][2]*x[i][2])+(x[i][3]*x[i][3])))]++;
      }
    }
    for(i=1; i<100; i++){
      if(f<2000){
        line(height+170+(5*(i-1)), height-100-(5*s[i-1]), height+170+(5*i), height-100-(5*s[i]));
      }
      if(f>500){
        line(height+170+(5*(i-1)), height-100-(5*p[i-1]/(f-500)), height+170+(5*i), height-100-(5*p[i]/(f-500)));  
      }
    }
    if(keyPressed&&(key == 'S'||key == 's')){
      delay(100);
    }
    if(keyPressed&&(key == 'D'||key == 'd')){
      delay(1000);
    }
  
    {  
      test[int(f/30)] = 100*(float)n/(f-500);
      line(height, height-60, width, height-60);
      for(i=1; i<f/30; i++){
        line(height+i-1, height-test[i-1]+2700, height+i, height-test[i]+2700);
      } 
    } 
}
