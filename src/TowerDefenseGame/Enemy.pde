class Enemy {
  // member variables
  int x, y, speed, health, r, type;

  // constructor
  Enemy(int x, int y) {
    this.x = x;
    this.y = y;
    type = int (random (3));
    r = 40;
    switch (type) {
    case 0: // normal
      speed = 3;
      health = 40;
      break;
    case 1: // slow high
      speed = 1;
      health = 60;
      break;
    case 2: // high low
      speed = 5;
      health = 20;
      break;
    }
  }

  // member methods
  boolean splashIntersection(Splash splash) {
    float distance = dist (x, y, splash.x, splash.y);
    if (distance < r + splash.r) {
      return true;
    } else {
      return false;
    }
  }

  boolean laserIntersection(Laser laser) {
    float distance = dist (x, y, laser.x, laser.y);
    if (distance < r + laser.r) {
      return true;
    } else {
      return false;
    }
  }

  boolean reachedEnd() {
    if (x > width + 50) {
      return true;
    } else {
      return false;
    }
  }

  void move() {
    if (x < 550) {
      x += speed;
    } 
    if (x > 545 && x < 550) {
      x = 550;
    }
    if (x == 550) {
      if (y < 375) {
        y += speed;
      } else if (y > 375) {
        y -= speed;
      }
    } 
    if (y == 375) {
      x += speed;
    }
  }

  void display() {
    switch (type) {
    case 0: // normal
      fill (#E8CB23);
      ellipse (x, y, health, health);
      break;
    case 1: // slow high
      fill (#92C9ED);
      ellipse (x, y, health, health);
      break;
    case 2: // high low
      fill (#ED0C10);
      ellipse (x, y, health, health);
      break;
    }
  }
}
