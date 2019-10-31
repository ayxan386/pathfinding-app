GameController gc;


void setup() {
  //
  size(1200, 800);
  //
  gc = new GameController();
  gc.makeNewGrid(75);
  gc.drawGrid();
  //frameRate(30);
}

void draw() {
  gc.tick();
  //saveFrame("frames/###.png");
}


void mouseDragged() {
  boolean toPass = false;
  if (mouseButton == RIGHT)toPass = true;
  gc.dragged(mouseX, mouseY, toPass);
  gc.drawGrid();
}

void mouseClicked() {
  boolean toPass = false;
  if (mouseButton == RIGHT)toPass = true;
  gc.clicked(mouseX, mouseY, toPass);
  gc.drawGrid();
}
void mouseReleased() {
  gc.release();
}
