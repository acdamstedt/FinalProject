class SlowSplash {
  // member variables
  int x, y, r;
  PImage slowsplash;
  
  // constructor
  SlowSplash(int x, int y) {
    this.x = x;
    this.y = y;
    r = 100;
  }
  
  // member methods  
  void display() {
    slowsplash = loadImage ("slowsplash.png");
    image (slowsplash, x-50, y-50);
  }
}
