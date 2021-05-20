class Laser {
  // member variables
  int x, y, a, speed, damage, r, type, radius;
  PImage arrow, arrow1;

  // constructor
  Laser(int x, int y) {
    this.x = x;
    this.y = y;
    r = 7;
    speed = 5;
    damage = 200;
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
    arrow = loadImage ("arrow.png");
    arrow1 = loadImage ("arrow1.png");
    if (a > 375) {
      image (arrow, x, y);
    } else if (a < 375) {
      image (arrow1, x, y);
    }
  }
}
