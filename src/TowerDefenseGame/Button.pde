class Button {
  // Member variables
  int x, y, w, h;
  color c1, c2;
  String text;
  boolean hover, used;

  // Constructor
  Button(int tempX, int tempY, int tempW, int tempH, String tempText, color tempc1, color tempc2) {
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
    c1 = tempc1;
    c2 = tempc2;
    text = tempText;
    hover = false;
    used = false;
  }

  // Display Method
  void display() {
    if (used == false) {
      if (hover) {
        fill (c2);
      } else {
        fill (c1);
      }

      rect (x, y, w, h, 7);

      strokeWeight (4);
      stroke (0, 100);
      line (x+2, y+h-2, x+w-2, y+h-2);
      line (x+w-2, y+h-2, x+w-2, y+2);

      stroke (255, 100);
      line (x+2, y+h-2, x+2, y+2);
      line (x+2, y+2, x+w-2, y+2);

      strokeWeight (1);

      fill (0);
      textAlign (CENTER);
      textSize (14);
      text (text, x+w/2-1, y+h/2+3);
    }
  }

  // Hover Method
  void hover() {
    if (used == true) {
      hover = false;
    } else {
      hover = (mouseX>x && mouseX<x+w && mouseY>y && mouseY<y+h);
    }
  }
}
