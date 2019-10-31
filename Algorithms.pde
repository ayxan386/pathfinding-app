class Algorithms {
  Animator startBFS(Grid grid) {
    Algorithm algo = new BFS(); 
    Queue<ArrayList<Cell>> changes = algo.run(grid.getGridCopy(), grid.start, grid.target);
    return new Animator(changes);
  }
  Animator startDFS(Grid grid) {
    Algorithm algo = new DFS(); 
    Queue<ArrayList<Cell>> changes = algo.run(grid.getGridCopy(), grid.start, grid.target);
    return new Animator(changes);
  }
  Animator startDIJ(Grid grid) {
    Algorithm algo = new Dijikstra(); 
    Queue<ArrayList<Cell>> changes = algo.run(grid.getGridCopy(), grid.start, grid.target);
    return new Animator(changes);
  }

  Animator startAStar(Grid grid) {
    Algorithm algo = new Astar(); 
    Queue<ArrayList<Cell>> changes = algo.run(grid.getGridCopy(), grid.start, grid.target);
    return new Animator(changes);
  }

  Animator startMazeGen(Grid grid) {
    Algorithm algo = new MazeGenerator(); 
    Queue<ArrayList<Cell>> changes = algo.run(grid.getGridCopy(), grid.start, grid.target);
    return new Animator(changes, true);
  }
}
