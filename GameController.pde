class GameController {
  Grid grid;
  Animator anim;
  Algorithms algos;

  ArrayList<Button> controller;
  Button clearGrid;
  Button bfs;
  Button dfs;
  Button astar;
  Button dijikstra;
  Button mazeGen;
  boolean isGoing = false;

  GameController() {

    controller = new ArrayList();
    algos = new Algorithms();
    
    clearGrid = new Button(width - 60, 50, 50, 50, "Clean Grid", color(125, 125, 125));
    bfs = new Button(width - 60, 100, 50, 50, "Start BFS", color(225, 125, 125));
    dfs = new Button(width - 60, 150, 50, 50, "Start DFS", color(125, 125, 225));
    dijikstra = new Button(width -60, 200, 50, 50, "Start Dijikstra's", color(125, 125, 225));
    astar = new Button(width - 60, 250, 50, 50, "Start A*", color(125, 125, 225));
    mazeGen = new Button(width - 60, 300, 50, 50, "Start Maze Generator", color(125, 125, 225));
    
    controller.add(clearGrid);
    controller.add(bfs);
    controller.add(dfs);
    controller.add(mazeGen);
    controller.add(dijikstra);
    controller.add(astar);
  }

  void drawGrid() {
    grid.drawGrid();

    for (Button b : controller) {
      b.drawMe();
    }
  }

  void clicked(int x, int y, boolean isRight) {
    if (isGoing)return;
    if (checkForButtons(x, y)) {
      Button click = getButtonAt(x, y);
      switch(click.name) {
      case "Clean Grid":
        makeNewGrid(grid.w);
        return;
      case "Start BFS":
        isGoing = true;
        grid.setZero();
        anim = algos.startBFS(grid);
        return;
      case "Start DFS":
        isGoing = true;
        grid.setZero();
        anim = algos.startDFS(grid);
        return;
      case "Start Dijikstra's":
        isGoing = true;
        grid.setZero();
        anim = algos.startDIJ(grid);
        return;
      case "Start A*":
        isGoing = true;
        grid.setZero();
        anim = algos.startAStar(grid);
        return;
      case "Start Maze Generator":
        isGoing = true;
        grid.setZero();
        anim = algos.startMazeGen(grid);
        return;
      default:
        print("Unknown name");
        return;
      }
    }
    updateCell(x, y, isRight);
  }
  void  dragged(int x, int y, boolean right) {
    updateCell(x, y, right);
  }
  

  boolean checkForButtons(int x, int y) {
    for (Button b : controller) {
      if (b.contains(x, y))return true;
    }
    return false;
  }

  Button getButtonAt(int x, int y) {
    for (Button b : controller) {
      if (b.contains(x, y))return b;
    }
    return null;
  }
  void makeNewGrid(int w) {
    grid = new Grid(w);
  }

  void updateCell(int x, int y, boolean isRight) {
    grid.updateCell(x, y, isRight);
  }
  void tick() {
    if (anim == null) {
      isGoing = false;
      return;
    }

    if (anim.play(grid))drawGrid();
    else {
      if (anim.setZero)grid.setZero();
      drawGrid();
      anim = null;
    }
  }
  void release() {
    grid.release();
    drawGrid();
  }
}
