class Grid {

  ArrayList<Cell> grid;
  int a;
  Cell start;
  Cell target;
  boolean selectinTarget = false, selectinStart = false;
  int w;

  Grid(int w) {

    a = (width - 100) / w;    

    this.w = w;
    int h = height / a;

    cleanGrid(w, h);

    start = new Cell(0, 0);
    target = new Cell(w - 2, h - 2);
  }

  void drawGrid() {
    background(255);
    pushMatrix();
    stroke(0);
    noFill();
    strokeWeight(1);
    for (Cell c : grid) {

      int screenX = c.x * a;
      int screenY = c.y * a;

      if (c.state == 0)fill(255); //empty cell
      else if (c.state == -1)fill(0, 0, 0); //wall cell
      else if (c.state == 1)fill(255, 0, 0); // in progress
      else if (c.state == 2)fill(0, 255, 0); // completed
      else if (c.state == 3)fill(0, 0, 255); // part of path

      if (isStart(c)) {
        fill(255, 255, 0);
        if (selectinStart)fill(255, 0, 0);
      } else if (isTarget(c)) {
        fill(0, 255, 255);
        if (selectinTarget)fill(255, 0, 0);
      }

      rect(screenX, screenY, a, a);
    }
    popMatrix();
  }

  void updateCell(int x, int y, boolean clear) {
    if (x > width - 100)return;
    int gridX = x / a;
    int gridY = y / a;

    Cell c = this.getCellAt(gridX, gridY);

    if (c == null)return;

    if (selectinTarget) {

      setCellAt(target.x, target.y, 0);
      setTarget(gridX, gridY);
      //selectinTarget = false;
      return;
    }
    if (selectinStart) {

      setCellAt(target.x, target.y, 0);

      setStart(gridX, gridY);

      //selectinStart = false;
      return;
    }

    if (isTarget(c)) {
      selectinTarget = true;
      return;
    }
    if (isStart(c)) {
      selectinStart = true;
      return;
    }
    if (!clear)c.makeBrick();
    else c.clear();
  }

  void setCellAt(int x, int y, int state) {
    Cell c = this.getCellAt(x, y);

    if (c == null)return;

    if (isStart(c) || isTarget(c))return;

    c.state = state;
  }

  void setTarget(int x, int y) {
    if (isStart(getCellAt(x, y)))return;
    target = new Cell(x, y);
  }

  void setStart(int x, int y) {
    if (isTarget(getCellAt(x, y)))return;
    start = new Cell(x, y);
  }
  Cell getCellAt(int x, int y) {
    if (y * w + x < grid.size() && y * w + x >= 0) {
      return grid.get(y * w + x);
    }
    return null;
  }

  ArrayList<ArrayList<Cell>> getGridCopy() {
    ArrayList<ArrayList<Cell>> res = new ArrayList();
    int h = height / a;
    for (int y = 0; y < h; y++) {
      ArrayList<Cell> row = new ArrayList();
      for (int x = 0; x < w; x++) {
        Cell c = grid.get(y * w + x).clone();
        if (c.state != -1)
          c.setState(0);
        row.add(c);
      }
      res.add(row);
    }
    return res;
  }
  void release() {
    selectinStart = false;
    selectinTarget = false;
    //drawGrid();
  }
  boolean isStart(Cell c) {
    return c.equals(start);
  }

  boolean isTarget(Cell c) {
    return c.equals(target);
  }

  void cleanGrid(int w, int h) {
    grid = new ArrayList();
    for (int y = 0; y < h; y++) {
      for (int x = 0; x < w; x++) {
        grid.add(new Cell(x, y));
      }
    }
  }
  void setZero() {
    for (Cell c : grid) {
      if (c.state == -1)continue;
      c.setState(0);
    }
  }
}
