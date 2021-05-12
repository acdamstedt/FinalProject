// Tower Defense Game | May 2021
// by Annika Damstedt

/*
Stuff to do
 -add different splashes
 */

ArrayList<Tower> towers;
ArrayList<Enemy> enemies;
ArrayList<Laser> lasers;
ArrayList<Splash> splashes;
ArrayList<Timer> lTimers;
Button[] buttons = new Button[12];
int money, lives, kills, spawn, ey;
Timer enemyTimer, splashTimer;
boolean play;

void setup() {
  size (1200, 750);

  // buttons
  buttons [0] = new Button (50, 15, 125, 125, "Open plot", #00CBBC, #03A089);
  buttons [1] = new Button (350, 15, 125, 125, "Open plot", #00CBBC, #03A089);
  buttons [2] = new Button (50, 313, 125, 125, "Open plot", #00CBBC, #03A089);
  buttons [3] = new Button (300, 313, 125, 125, "Open plot", #00CBBC, #03A089);
  buttons [4] = new Button (50, 610, 125, 125, "Open plot", #00CBBC, #03A089);
  buttons [5] = new Button (350, 610, 125, 125, "Open plot", #00CBBC, #03A089);
  buttons [6] = new Button (650, 150, 125, 125, "Open plot", #00CBBC, #03A089);
  buttons [7] = new Button (825, 150, 125, 125, "Open plot", #00CBBC, #03A089);
  buttons [8] = new Button (1000, 150, 125, 125, "Open plot", #00CBBC, #03A089);
  buttons [9] = new Button (650, 475, 125, 125, "Open plot", #00CBBC, #03A089);
  buttons [10] = new Button (825, 475, 125, 125, "Open plot", #00CBBC, #03A089);
  buttons [11] = new Button (1000, 475, 125, 125, "Open plot", #00CBBC, #03A089);

  // set up variables
  towers = new ArrayList();
  enemies = new ArrayList();
  lasers = new ArrayList();
  splashes = new ArrayList();
  lTimers = new ArrayList();

  money = 500;
  lives = 20;
  kills = 0;

  enemyTimer = new Timer (5000);
  enemyTimer.start();
  splashTimer = new Timer (1000);
  splashTimer.start();
}

void draw() {
  if (!play) {
    startScreen();
  } else {
    background (200);
    size (1200, 750);
    noStroke();
    fill (255);
    // upper left
    rect (50, 15, 125, 125);
    rect (350, 15, 125, 125);
    // mid
    rect (50, 313, 125, 125);
    rect (300, 313, 125, 125);
    // lower left
    rect (50, 610, 125, 125);
    rect (350, 610, 125, 125);
    // upper right
    rect (650, 150, 125, 125);
    rect (825, 150, 125, 125);
    rect (1000, 150, 125, 125);
    // lower right
    rect (650, 475, 125, 125);
    rect (825, 475, 125, 125);
    rect (1000, 475, 125, 125);
    // map
    rect (0, 157.5, 600, 125);
    rect (0, 467.5, 600, 125);
    rect (475, 157.5, 125, 435);
    rect (475, 312.5, 725, 125);
    // player data
    fill (0);
    rect (650, 650, 550, 100);
    fill (255);
    textSize (24);
    text ("Lives: " + lives, 725, 710);
    text ("Money: " + money, 900, 710);
    text ("Kills: " + kills, 1100, 710);

    //call buttons
    for (int i=0; i<buttons.length; i++) {
      buttons[i].display();
      buttons[i].hover();
    }

    // switch enemy spawn
    spawn = int (random (2));
    switch (spawn) {
    case 0:
      ey = 225;
      break;
    case 1:
      ey = 525;
      break;
    }

    // enemy timer
    if (enemyTimer.isFinished()) {
      enemies.add(new Enemy(-50, ey)); 
      enemyTimer.start();
    }

    // add enemies
    for (int i = 0; i < enemies.size(); i++) {
      Enemy enemy = enemies.get(i);
      enemy.display();
      enemy.move();
      if (enemy.reachedEnd()) {
        enemies.remove(enemy);
        lives--;
      }
    }

    // add towers + laser timer
    for (int i=0; i<towers.size(); i++) {
      Tower tower = towers.get(i);
      tower.display();
      for (int j=0; j<lTimers.size(); j++) {
        Timer lTimer = lTimers.get(i);
        if (lTimer.isFinished()) {
          lasers.add (new Laser (tower.x+63, tower.y+63));
          lTimer.start();
        }
      }
    }

    // add lasers
    for (int i=0; i<lasers.size(); i++) {
      Laser laser = lasers.get(i);
      laser.display();
      laser.move();
      if (laser.reachedEnd()) {
        lasers.remove(laser);
      }
      for (int j=0; j<enemies.size(); j++) {
        Enemy enemy = enemies.get(j);
        if (enemy.laserIntersection(laser)) {
          enemy.health -= laser.damage;
          lasers.remove(laser);
        }
      }
    }

    for (int i=0; i<enemies.size(); i++) {
      Enemy enemy = enemies.get(i);
      if (enemy.health < 10) {
        enemies.remove(enemy);
        kills++;
        money+=50;
      }
    }

    // end condition
    if (lives == 0) {
      play = false; 
      gameOver();
    }
  }
}



void mousePressed() {
  for (int i=0; i<buttons.length; i++) {
    if (buttons[i].hover) {
      towers.add(new Tower(buttons[i].x, buttons[i].y));
      lTimers.add(new Timer(1000));
      buttons[i].used = true;
    }
  }
}

void infoPanel() {
}

void startScreen() {
  background (200);
  textSize (20);
  textAlign (CENTER);
  text ("Tower Defense Game", width/2, height/2);
  text ("Click anywhere to play", width/2, height/2+20); //button in future

  if (mousePressed) {
    play = true;
  }
}

void gameOver() {
  background(0);
  textAlign (CENTER);
  fill (222);
  textSize (20);
  text ("You died!", width/2, height/2);
  text("You killed " + kills + " enemies!", width/2, height/2+40);
  noLoop();
}
