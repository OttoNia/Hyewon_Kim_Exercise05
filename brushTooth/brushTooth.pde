import ddf.minim.*;
Minim minim;
AudioPlayer BG;
AudioPlayer brush1;

PImage[] brush_ani = new PImage[9];
PImage[] cursors = new PImage[2];
PImage brush, bar, back;

int brushX = 465;
int brushY = 605;
int frameNum = 4;
int brushScore = 0;
int cursorNum = 0;

void setup() {
  size(1000, 700);
  
  minim = new Minim(this);
  
  brush1 = minim.loadFile("brush1.wav");

  BG = minim.loadFile("BG.mp3");
  BG.loop();

  for (int i=0; i < 9; i++) {
    brush_ani[i] = loadImage("ani_" + i + ".png");
  }
  for (int i=0; i < 2; i++) {
    cursors[i] = loadImage("cursor_" + i + ".png");
  }
  brush = loadImage("tBrush.png");
  bar = loadImage("pBar.png");
  back = loadImage("back.png");
  noCursor();
}

void draw() {
  background(255);

  brushScore = constrain(brushScore, 0, 5000);
  int barPos = int(map(brushScore, 0, 5000, 20, 310));
  image(bar, barPos, 515);// x: 20~310

  image(back, 0, 0);
  image(brush_ani[frameNum], 178, 51);
  image(brush, brushX, brushY); // LE : 330  C : 465   RE : 605

  image(cursors[cursorNum], mouseX, mouseY);

  if (!mousePressed) {
    if (mouseX > 885 && mouseY > 20 && mouseX < 885 
      && mouseY < 20) {
      cursorNum = 2;
    } else {
      cursorNum = 0;
    }
  }
}

void mouseDragged() {
  
    brush1.play();
    brush1.loop();
    
  if (mouseX > brushX + 100 && mouseY > brushY - 25 &&
    mouseX < brushX + brush.width &&
    mouseY < brushY - 25 + brush.height) {     
    brushX = brushX - (pmouseX - mouseX);
    brushX = constrain(brushX, 330, 605);
    
    brush1.play();
    brush1.loop();
    
    frameNum = int(map(brushX, 330, 605, 8, 0));
    brushScore = brushScore + int(dist(pmouseX, 0, mouseX, 0));
    cursorNum = 1;
  }
  
}
