class ToxicSplash {
  // member variables
  int x, y, r;
  PImage toxicsplash;
  
  // constructor
  ToxicSplash(int x, int y) {
    this.x = x;
    this.y = y;
    r = 100;
  }
  
  // member methods  
  void display() {
    toxicsplash = loadImage ("toxicsplash.png");
    image (toxicsplash, x-50, y-50);
  }
}
