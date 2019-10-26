class Button {
  final int x;
  final int y;
  final int width;
  final int height;
  final color cl;

  final String name;

  Button(int x, int y, int width, int height, String name, color c) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.name = name;
    this.cl = c;
  }

  void drawMe() {
    pushMatrix();
    stroke(0);
    fill(cl);
    translate(x, y);

    rect(0, 0, this.width, this.height);

    fill(0, 0, 0);
    textSize(12);
    text(name, 3, 3, this.width, this.height);

    popMatrix();
  }

  boolean contains(int x, int y) {
    if (x > this.x && x < this.x + this.width)
      if (y > this.y && y < this.y + this.height)return true;
    return false;
  }
}
