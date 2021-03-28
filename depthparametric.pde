// Antonio Badillo 2021

// Note: when saving an img the process will freeze the program for 5 seconds or so, depending on your computer or the saveScaleF (factor) currently set to x4
// also, the info panel on the top right will NOT appear on the saved image, so it is not necessary to turn it off


float r = 50;                // initial radius for center function     [mouseY]
float frq = 50;              // frequency multiplier                   [mouseX]
float amp = 50;              // funtion amplitud multiplier            [q-e]
int N = 7;                   // number of lines multiplied by 2 +      [w-s]
float xmax = 1;              // horizontal width divider               [a-d]
float yoffset = 40;          // vertical offset                        [↕]
float xoffset = 0;           // horizontal offset                      [↔] 
int tsize = 18;              // information panel text size            

int saveScaleF = 4;          // Scale factor multiplier based on window dimentions

// flags
boolean xfade = false;       // horizonal fade flag                    [x]
boolean yfade = true;        // vertical fade flag                     [y]
boolean finfo = true;        // information panel                      [i]

boolean ft1 = true;          // funtion 1                              [1]
boolean ft2 = false;         // funtion 2                              [2]
boolean ft3 = false;         // funtion 3                              [3]

// 
float t = 0;
float nr;      
float x;
float y;
float xalpha;
float yalpha;




void setup() {

  //size(1080,720,FX2D);
  fullScreen(FX2D);
 
  noCursor();
  //noSmooth();
}

void draw() {

  _main();
}


/// necesary for Image saving
void _main (){            

  background(0);
  translate(width/2, height/2);
  
  if (finfo)
    info();

  r   =  map(mouseY, 0, height, 25, 500);
  frq =  map(mouseX, 0, width, 50, 1000);
  t   =  -width/xmax;

  while (t <= width/xmax) { 

    for (int n = -N; n <= N; n++) 
      drawCircle(n);   

    t+=frq/10;          // high frequency = less circles, low frequency = more circles
    //t+=10000/frq;     // the inverse  ( doesnt look very good )
  }
  
}


void drawCircle(float n) {

  //nr = (abs(n+0.1)/(n+0.1)) * (5*r/(abs(n)+5.0));     // old radius function
  nr = 5*r/(abs(n)+5.0);                                // radius funtion dependent on line number     

  yalpha = 255;
  xalpha = 1; 

  if (yfade)
    yalpha = 100/(abs(n)+0.4);                                               // tranparency funtion dependent also on the line number  
  if (xfade) 
    xalpha = map( dist(abs(t), 0, width/xmax, 0), 0, width/xmax, 0, 1);     // tranparency multiplier calculated with the distance from circle center to invisible border (width/xmax)
  
  
  noFill();
  stroke(255, yalpha*xalpha);

  // parametric equations examples   
  
  // x = t;                                  y = (amp*sin(t/frq));                  // Sine
  // x = t;                               y = (amp*cos(t/frq));                  // Cosine
  // x = t;                               y = (amp*tan(t/frq));                  // Tangent
  // x = (amp*sin(t/frq));                y = t;                                 // inverse Sine 
  // x = amp*cos(t/frq)*(1-cos(t/frq));   y = amp*sin(t/frq)*(1-cos(t/frq);      // Cardioid 
  // x = amp*cos(t/frq);                  y = amp*sin(t/frq);                    // Circunference  

  if (ft1){                                              //  default (enable or disable with the number 1)
    x = t;                                  
    y = (amp*sin(t/frq)); 
    circle(x +  n*xoffset, y + n*yoffset, nr*2);  
  }
  
  if (ft2){                                              // optional (number 2)
    x = t;                               
    y = (amp*cos(t/frq)); 
    circle(x +  n*xoffset, y + n*yoffset, nr*2);  
  }
  
  if (ft3){                                              // optional(number 3)
    x = amp*cos(t/frq);                 
    y = amp*sin(t/frq);
    circle(x +  n*xoffset, y + n*yoffset, nr*2);  
  }


  // colorized  
  // x = t;    y = (amp*sin(t/frq)) + yoffset;                                            // Sine vertical yoffset
  // stroke(#4D72FF, alpha*xfade);
  // circle(x, y, r*2);  
  // x = t;    y = (amp*cos(t/frq)) + yoffset;                                            // Cosine
  // stroke(#FF4D4D, alpha*xfade);
  // circle(x, y, r*2);
}



void keyPressed() {    

  switch(key) {                //keybinds

    case 'Q':
    case 'q': 
      amp += 10;  
      break;
    case 'E':
    case 'e': 
      amp -= 10;  
      break;
  
    case 'a':
    case 'A': 
      xmax += 0.5;  
      break;
    case 'd':
    case 'D': 
      if (xmax > 1)
        xmax -= 0.5;  
      break;
  
    case 'w':
    case 'W': 
      N += 1;  
      break;
    case 's':
    case 'S': 
      if (N > 0)
        N -= 1;  
      break;
  
    case 'x':
    case 'X': 
      xfade = !xfade;
      break;
    case 'y':
    case 'Y': 
      yfade = !yfade;
      break;
    case 'i':
    case 'I': 
      finfo = !finfo;
      break;  
      
    case 'p':
    case 'P': 
      saveImg();   
      break; 
      
    case '1':
      ft1 = !ft1;
      break;
    case '2':
      ft2 = !ft2;
      break;
    case '3':
      ft3 = !ft3;
      break;
  }


  switch(keyCode) {

    case RIGHT:
      xoffset -= 1;
      break;
    case LEFT:
      xoffset += 1;
      break;
    case UP:
      yoffset += 1;
      break;
    case DOWN:
      yoffset -= 1;
      break;   
  }
}



void info () {

  textAlign(RIGHT, TOP);
  textSize(tsize);

  text("fps: "        + int(frameRate) , width/2, -height/2+tsize*1);
  text("frq[mX]: "    + frq            , width/2, -height/2+tsize*2);
  text("r[mY]: "      + r              , width/2, -height/2+tsize*3);
  text("amp[q-e]: "   + amp            , width/2, -height/2+tsize*4);
  text("xmax[a-d]: "  + 1/xmax        , width/2, -height/2+tsize*5);
  text("N[w-s]:"      + (N*2 + 1)          , width/2, -height/2+tsize*6);
  text("yoffset[↕]: " + yoffset        , width/2, -height/2+tsize*7);
  text("xoffset[↔]: " + xoffset        , width/2, -height/2+tsize*8);
  text("xfade[x]: "   + xfade          , width/2, -height/2+tsize*9);
  text("yfade[y]: "   + yfade          , width/2, -height/2+tsize*10);
  text("info[i]: "    + finfo          , width/2, -height/2+tsize*11);
  text("saveImg : [p]"                 , width/2, -height/2+tsize*12);
  text("ft: [1-2-3]"                   , width/2, -height/2+tsize*13);

  //text(height+" "+ width,  width/2,-height/2+tsize*6);
}


void saveImg() {
 
  //textAlign(RIGHT, TOP);
  //textSize(tsize*1.5);
  println("SAVING...");
  //_main();  
  
  PGraphics pg = createGraphics(width * saveScaleF, height * saveScaleF, JAVA2D);

  beginRecord(pg);
  pg.scale(saveScaleF);
    
  finfo = false;
  _main();
  finfo = true;  
  
  endRecord();
  
  String filename = year()+""+month()+""+day()+"_"+hour()+""+minute()+""+second()+"["+saveScaleF+"]";
  pg.save("examples/" +filename+ ".png");
  //pg.save(filename+".tif");
  //pg.save(filename+".jpg");
  //pg.save(filename+".tga");
  
  println("DONE!");
}
