class Tower {
  // member variables
  int x, y;

  // constructor
  Tower(int x, int y) {
    this.x = x;
    this.y = y;
  }

  // member methods
  void display() {
    fill (#E8CB23);
    rect (x, y, 125, 125);
  }
}
