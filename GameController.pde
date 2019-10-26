class GameController {
  Grid grid;
  Animator anim;

  ArrayList<Button> controller;
  Button clearGrid;
  Button bfs;
  Button dfs;
  boolean isGoing = false;
  
  GameController() {

    controller = new ArrayList();
    clearGrid = new Button(width - 50, 55, 45, 45, "Clean Grid", color(125, 125, 125));
    bfs = new Button(width - 50, 100, 45, 45, "Start BFS", color(225, 125, 125));
    dfs = new Button(width - 50, 145, 45, 45, "Start DFS", color(125, 125, 225));

    controller.add(clearGrid);
    controller.add(bfs);
    controller.add(dfs);
  }

  void drawGrid() {
    grid.drawGrid();

    for (Button b : controller) {
      b.drawMe();
    }
  }

  void clicked(int x, int y, boolean isRight) {
    if(isGoing)return;
    if (checkForButtons(x, y)) {
      Button click = getButtonAt(x, y);
      switch(click.name) {
      case "Clean Grid":
        makeNewGrid(grid.w);
        return;
      case "Start BFS":
        isGoing = true;
        startBFS();
        return;
      case "Start DFS":
        isGoing = true;
        startDFS();
        return;
      default:
        print("Unknown name");
        return;
      }
    }
    updateCell(x, y, isRight);
  }
  void  dragged(int x,int y,boolean right){
    updateCell(x, y, right);
  }
  void startBFS() {
    Algorithm algo = new BFS(); 
    Queue<ArrayList<Cell>> changes = algo.run(grid.getGridCopy(), grid.start, grid.target);
    anim = new Animator(changes);
  }
  void startDFS() {
    Algorithm algo = new DFS(); 
    Queue<ArrayList<Cell>> changes = algo.run(grid.getGridCopy(), grid.start, grid.target);
    anim = new Animator(changes);
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
    if (anim == null){
      isGoing = false;
      return;
    }
    
    if(anim.play(grid))drawGrid();
    else anim = null;
  }
  void release(){
    grid.release();
    drawGrid();
  }
}
