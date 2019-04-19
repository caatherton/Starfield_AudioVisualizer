class Star {
  float x;
  float y;
  float z;
  float pz;
  float c;

  Star() {
    x = random(-width, width);
    y = random(-height, height);
    z = random(width);
    c = map(x, -width/2, width/2, 0, 360);
    pz = z;
  }

  void update() {

    z = z - speed;
    if (z < 1) {
      z = width;
      x = random(-width, width);
      y = random(-height, height);
      pz = z;
    }
  }

  void show() {
    bass = fft.calcAvg(0, 100);
    mid = fft.calcAvg(100, 1000)*8;    
    high = fft.calcAvg(1000, 20000)*8;
    //c = map(y,-height/2,height/2,0,360);
    float fade = map(z, 700, width, 255, 0);
    //fill(c, mid, fade-(bass/5));
    //noStroke();

    float sx = map(x / z, 0, 1, 0, width);
    float sy = map(y / z, 0, 1, 0, height);

    //float r = map(z, 0, width, 16, 0);
    //ellipse(sx, sy, r+(bass/10), r+(bass/10));

    float px = map(x / (pz+200), 0, 1, 0, width);
    float py = map(y / (pz+200), 0, 1, 0, height);
    pz = z;
    stroke(c/1.8, mid, fade-(bass/10));
    strokeWeight((mid/30));
    line(px, py, sx, sy);
  }
}
