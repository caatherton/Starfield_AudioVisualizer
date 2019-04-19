//Inspired By Dan Shiffman's Starfield(https://www.youtube.com/watch?v=17WoOqgXsRM)

import ddf.minim.analysis.*;
import ddf.minim.*;

Minim       minim;
AudioPlayer song;
FFT fft;
float bass;
float mid;    
float high;

Star[] stars = new Star[1000];
float h = 0;
float speed;
float highBass = 0;

void setup() {
  //size(600, 600);
  noCursor();
  fullScreen(P3D);
  colorMode(HSB);
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
  }
  minim = new Minim(this);
  song = minim.loadFile("oliver3.mp3"); 
  fft = new FFT( song.bufferSize(), song.sampleRate() );
  strokeWeight(2);
  song.play();
}

void draw() {
  bass = fft.calcAvg(0, 100);
  mid = fft.calcAvg(100, 1000)*8;    
  high = fft.calcAvg(1000, 20000)*8;
  if (bass > highBass) {
    highBass = bass;
  }
  if (highBass < 99) {
    background(0);
  }
  //println(highBass);
  //highBass = highBass -1;
  speed = map(mouseX, 0, width, 0, 50) + (mid/5);
  translate(width/2, height/2);
  for (int i = 0; i < stars.length; i++) {
    rotateZ(h);
    stars[i].update();
    stars[i].show();
    fft.forward(song.mix);
    if (highBass > 99) {
      h = h + 0.00000001;
    } else {
      h = h + 0.000000001;
    }
  }
}
