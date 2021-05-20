class Tower {
  // member variables
  int x, y;
  PImage tower, tower1;

  // constructor
  Tower(int x, int y) {
    this.x = x;
    this.y = y;
  }

  // member methods
  void display() {
    tower = loadImage ("tower.png");
    tower1 = loadImage ("tower1.png");
    if (y > 375) {
      image (tower, x, y);
    } else if (y < 375) {
      image (tower1, x, y);
    }
  }
}
