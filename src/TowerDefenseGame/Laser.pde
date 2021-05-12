class Laser {
  // member variables
  int x, y, a, speed, damage, r, type, radius;

  // constructor
  Laser(int x, int y) {
    this.x = x;
    this.y = y;
    r = 7;
    speed = 5;
    damage = 20;
    a = y;
  }

  // member methods
  void move() { 
    if (a > 375) {
      y -= speed;
    } else if (a < 375) {
      y += speed;
    }
  }
  
  boolean reachedEnd() {
    if (y < -50 || y > 800) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
      noStroke();
      fill (#E8CB23);
      rect (x, y, r, r+13);
  }
}
