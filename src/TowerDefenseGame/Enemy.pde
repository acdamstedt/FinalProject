class Enemy {
  // member variables
  int x, y, speed, health, r, type, cSpeed;
  PImage fox1, fox2, wolf1, wolf2, bear1, bear2;

  // constructor
  Enemy(int x, int y) {
    this.x = x;
    this.y = y;
    type = int (random (3));
    switch (type) {
    case 0: // normal
      speed = 3;
      cSpeed = 3;
      health = 400;
      r = 50;
      break;
    case 1: // slow high
      speed = 1;
      cSpeed = 1;
      health = 800;
      r = 60;
      break;
    case 2: // high low
      speed = 5;
      cSpeed = 5;
      health = 200;
      r = 40;
      break;
    }
  }

  // member methods
  boolean ssplashIntersection(SlowSplash ssplash) {
    float distance = dist (x, y, ssplash.x, ssplash.y);
    if (distance < r + ssplash.r - 50) {
      return true;
    } else {
      return false;
    }
  }

  boolean tsplashIntersection(ToxicSplash tsplash) {
    float distance = dist (x, y, tsplash.x, tsplash.y);
    if (distance < r + tsplash.r - 50) {
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
    frameRate(60);
    switch (type) {
    case 0: // normal
      wolf1 = loadImage ("wolf1.png");
      wolf2 = loadImage ("wolf2.png");
      if (frameCount % 100 < 50) {
        image (wolf1, x-35, y-25);
      } else {
        image (wolf2, x-35, y-25);
      }
      break;
    case 1: // slow high
      bear1 = loadImage ("bear1.png");
      bear2 = loadImage ("bear2.png");
      if (frameCount % 100 < 50) {
        image (bear1, x-50, y-30);
      } else {
        image (bear2, x-50, y-30);
      }
      break;
    case 2: // high low
      fox1 = loadImage ("fox1.png");
      fox2 = loadImage ("fox2.png");
      if (frameCount  % 10 < 5) {
        image (fox1, x-40, y-20, 80, 40);
      } else {
        image (fox2, x-40, y-20, 80, 40);
      }
      break;
    }
  }
}
