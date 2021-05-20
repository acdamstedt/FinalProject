// Tower Defense Game | May 2021
// by Annika Damstedt

import processing.sound.*;
SoundFile startgame;
SoundFile tower;
SoundFile splash;
SoundFile enemydeath;
SoundFile laserSound; 
SoundFile lifelost;
SoundFile endgame;

PImage background;
PImage toxicdisplay;
PImage slowdisplay;
PImage bnwtoxicdisplay;
PImage bnwslowdisplay;
PImage towerimg;
PImage wolf, bear, fox;

ArrayList<Tower> towers;
ArrayList<Enemy> enemies;
ArrayList<Laser> lasers;
ArrayList<ToxicSplash> tsplashes;
ArrayList<SlowSplash> ssplashes;
ArrayList<Timer> lTimers;
Button[] buttons = new Button[12];
int money, lives, kills, spawn, ey;
Timer enemyTimer, enemyTimer2, enemyTimer3, tsplashTimer, ssplashTimer, tcooldown, scooldown;
boolean play;

void setup() {
  size (1200, 750);
  
  endgame = new SoundFile (this, "gameover_sound.wav");
  startgame = new SoundFile (this, "gamestart.wav");
  splash = new SoundFile (this, "splash.wav");
  lifelost = new SoundFile (this, "lifelost.wav");
  tower = new SoundFile (this, "buildtower.wav");
  laserSound = new SoundFile (this, "laser.wav");
  enemydeath = new SoundFile (this, "monsterdeath1.wav");
  
  background = loadImage ("tdbackground.png");
  toxicdisplay = loadImage ("toxicdisplay.png");
  slowdisplay = loadImage ("slowdisplay.png");
  bnwtoxicdisplay = loadImage ("bnwtoxicdisplay.png");
  bnwslowdisplay = loadImage ("bnwslowdisplay.png");

  // buttons
  buttons [0] = new Button (50, 15, 125, 125, "Open plot", #E88D31, #A05403);
  buttons [1] = new Button (350, 15, 125, 125, "Open plot", #E88D31, #A05403);
  buttons [2] = new Button (50, 313, 125, 125, "Open plot", #E88D31, #A05403);
  buttons [3] = new Button (300, 313, 125, 125, "Open plot", #E88D31, #A05403);
  buttons [4] = new Button (50, 610, 125, 125, "Open plot", #E88D31, #A05403);
  buttons [5] = new Button (350, 610, 125, 125, "Open plot", #E88D31, #A05403);
  buttons [6] = new Button (650, 150, 125, 125, "Open plot", #E88D31, #A05403);
  buttons [7] = new Button (825, 150, 125, 125, "Open plot", #E88D31, #A05403);
  buttons [8] = new Button (1000, 150, 125, 125, "Open plot", #E88D31, #A05403);
  buttons [9] = new Button (650, 475, 125, 125, "Open plot", #E88D31, #A05403);
  buttons [10] = new Button (825, 475, 125, 125, "Open plot", #E88D31, #A05403);
  buttons [11] = new Button (1000, 475, 125, 125, "Open plot", #E88D31, #A05403);

  // set up variables
  towers = new ArrayList();
  enemies = new ArrayList();
  lasers = new ArrayList();
  tsplashes = new ArrayList();
  ssplashes = new ArrayList();
  lTimers = new ArrayList();

  money = 600;
  lives = 10;
  kills = 0;

  enemyTimer = new Timer (4000);
  enemyTimer.start();
  enemyTimer2 = new Timer (2000);
  enemyTimer2.start();
  enemyTimer3 = new Timer (1000);
  enemyTimer3.start();
  ssplashTimer = new Timer (10000);
  ssplashTimer.start();
  tsplashTimer = new Timer (10000);
  tsplashTimer.start();
  tcooldown = new Timer (2000);
  scooldown = new Timer (2000);
}

void draw() {
  if (!play) {
    startScreen();
  } else {
    image (background, 0, 0);
    
    fill (0);
    textSize (24);
    text (lives, 775, 710);
    text (money, 950, 710);
    text (kills, 1125, 710);

    //call buttons
    for (int i=0; i<buttons.length; i++) {
      buttons[i].display();
      buttons[i].hover();
    }
    
    // display abilities
    if (ssplashTimer.isFinished()) {
      image (slowdisplay, 975, 20);  
    } else if (!ssplashTimer.isFinished()) {
      image (bnwslowdisplay, 975, 20);
    }
    if (tsplashTimer.isFinished()) {
      image (toxicdisplay, 1080, 20);
    } else if (!tsplashTimer.isFinished()) {
      image (bnwtoxicdisplay, 1080, 20);
    }

    // use slow splash
    if (ssplashTimer.isFinished() && keyPressed && key == '1') {
      ssplashes.add(new SlowSplash(mouseX, mouseY));
      splash.play();
      ssplashTimer.start();
      scooldown.start();
    }

    for (int i=0; i<ssplashes.size(); i++) {
      SlowSplash ssplash = ssplashes.get(i);
      ssplash.display();
      for (int j=0; j<enemies.size(); j++) {
        Enemy enemy = enemies.get(j);
        if (enemy.ssplashIntersection(ssplash)) {
          enemy.speed = 1;
        }
        if (scooldown.isFinished()) {
          enemy.speed = enemy.cSpeed;
          ssplashes.remove(ssplash);
        }
      }
    }

    // use toxic splash
    if (tsplashTimer.isFinished() && keyPressed && key == '2') {
      tsplashes.add(new ToxicSplash(mouseX, mouseY));
      splash.play();
      tsplashTimer.start();
      tcooldown.start();
    }

    for (int i=0; i<tsplashes.size(); i++) {
      ToxicSplash tsplash = tsplashes.get(i);
      tsplash.display();
      for (int j=0; j<enemies.size(); j++) {
        Enemy enemy = enemies.get(j);
        if (enemy.tsplashIntersection(tsplash)) {
          enemy.health-=2;
        }
      }
      if (tcooldown.isFinished()) {
        tsplashes.remove(tsplash);
      }
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
    if (enemyTimer.isFinished() && kills <= 10) {
      enemies.add(new Enemy(-50, ey));
      enemyTimer.start();
    }

    // enemy timer 2
    if (enemyTimer2.isFinished() && kills > 10 && kills <= 30) {
      enemies.add(new Enemy(-50, ey));
      enemyTimer2.start();
    }

    // enemy timer 3
    if (enemyTimer3.isFinished() && kills >30) {
      enemies.add(new Enemy(-50, ey));
      enemyTimer3.start();
    }

    // add enemies
    for (int i = 0; i < enemies.size(); i++) {
      Enemy enemy = enemies.get(i);
      enemy.display();
      enemy.move();
      if (enemy.reachedEnd()) {
        enemies.remove(enemy);
        lives--;
        lifelost.play();
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
          laserSound.play();
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
        if (enemy.type == 0) {
          money += 100;
        } else if (enemy.type == 1) {
          money += 150;
        } else if (enemy.type == 2) {
          money += 50;
        }
        enemies.remove(enemy);
        enemydeath.play();
        kills++;
      }
    }

    // end condition
    if (lives == 0) {
      play = false;
      endgame.play();
      gameOver();
    }
  }
}

void mousePressed() {
  for (int i=0; i<buttons.length; i++) {
    if (buttons[i].hover && money >= 300) {
      towers.add(new Tower(buttons[i].x, buttons[i].y));
      tower.play();
      lTimers.add(new Timer(1000));
      money -= 300;
      buttons[i].used = true;
    }
  }
}

void infoPanel() {
  background (230);
  fill (0);
  textSize (50);
  textAlign (LEFT);
  text ("Info Panel", 20, 50);
  textSize (35);
  text ("Tower", 20, 100);
  text ("Enemies", 20, 325);
  text ("Abilities", 20, 550);
  textSize (25);
  text ("Click a button to place a tower. $300 is required. It will shoot bullets along the path, killing enemies.", 225, 135, 500, 200);
  text ("The wolf has a normal speed and health. The bear has a slow speed and high health. The fox has high speed and low health.", 550, 360, 550, 200);
  text ("Click '1' and where your mouse is an ice spill will temporarily slow enemies.", 400, 585, 600, 200);
  text ("Click '2' and where your mouse is a toxic spill will temporarily damage enemies.", 400, 660, 600, 200);
  // tower display
  towerimg = loadImage ("tower.png");
  image (towerimg, 20, 100, 200, 200);
  // enemies display
  wolf = loadImage ("wolf1.png");
  image (wolf, 30, 375, 140, 100); 
  bear = loadImage ("bear1.png");
  image (bear, 190, 375, 200, 120);
  fox = loadImage ("fox1.png");
  image (fox, 375, 375, 160, 80);
  // abilities display
  image (slowdisplay, 50, 600, 112, 150);
  image (toxicdisplay, 212, 600, 112, 150);
}

void startScreen() {
  background (#64D386);
  textSize (50);
  textAlign (CENTER);
  fill (0);
  text ("Tower Defense Game", width/2, height/2);
  textSize (40);
  text ("Click anywhere to play", width/2, height/2+40);
  textSize (20);
  text ("Press 'i' to see information about the game", 220, height-30);

  if (keyPressed && key == 'i') {
    infoPanel();
  }

  if (mousePressed) {
    play = true;
    startgame.play();
  }
}

void gameOver() {
  background(#123B1F);
  textAlign (CENTER);
  fill (222);
  textSize (20);
  text ("You died!", width/2, height/2);
  text("You killed " + kills + " enemies!", width/2, height/2+40);
  noLoop();
}
