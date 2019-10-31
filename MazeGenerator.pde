import java.util.Queue;
import java.util.ArrayDeque;
import java.util.Map;

class MazeGenerator implements Algorithm {

  Queue<ArrayList<Cell>> run(ArrayList<ArrayList<Cell>> grid, Cell start, Cell target) {
    ArrayDeque<ArrayList<Cell>> res = new ArrayDeque();

    res.add(makeAllWalls(grid, start.x % 2, start.y % 2));

    ArrayDeque<Cell> que = new ArrayDeque();
    start.setState(2);

    que.push(start);

    Cell curr = start;
    while (isThereAnyUnvisited(grid)) {
      ArrayList<Cell> change = new ArrayList();
      //println(curr);
      curr.setState(2);
      change.add(curr.clone());

      //if (target.equals(curr))break;

      ArrayList<Cell> neigh = filterVisited(getNeigh(grid, curr));
      if (neigh.size() > 0) {
        Cell randomNe = neigh.get((int)(Math.random()*neigh.size()));

        if (neigh.size() > 1)que.push(curr);

        Cell wall = new Cell((curr.x + randomNe.x)/2, (curr.y + randomNe.y)/2);

        wall.clear();
        change.add(wall.clone());

        curr = randomNe;
        curr.setState(2);
      } else {
        while (!que.isEmpty()) {
          Cell top = que.pop();
          if (filterVisited(getNeigh(grid, top)).size() > 0) {
            curr = top;
            break;
          }
        }
      }

      res.add(change);
    }
    return res;
  }

  ArrayList<Cell> getNeigh(ArrayList<ArrayList<Cell>> grid, Cell curr) {
    ArrayList<Cell> res = new ArrayList();
    if (curr.y - 2 >= 0) {
      Cell top = grid.get(curr.y - 2).get(curr.x);
      res.add(top);
    }
    if (curr.y + 2 < grid.size()) {
      Cell bottom = grid.get(curr.y + 2).get(curr.x);
      res.add(bottom);
    }
    if (curr.x - 2 >= 0) {
      Cell left = grid.get(curr.y).get(curr.x - 2);
      res.add(left);
    }
    if (curr.x + 2 < grid.get(0).size()) {
      Cell right = grid.get(curr.y).get(curr.x + 2);
      res.add(right);
    }
    return res;
  }
  ArrayList<Cell> filterVisited(ArrayList<Cell> or) {
    ArrayList<Cell> res = new ArrayList();
    for (Cell c : or) {
      if (c.state == 0)res.add(c);
    }
    return res;
  }
  ArrayList<Cell> makeAllWalls(ArrayList<ArrayList<Cell>>grid, int x, int y) {
    ArrayList<Cell> res = new ArrayList();
    for (int i=0; i<grid.size(); i++) {
      for (int j=0; j<grid.get(i).size(); j++) {
        if (i % 2 != y || j % 2 != x) {
          grid.get(i).get(j).makeBrick();
          res.add(grid.get(i).get(j).clone());
        }
      }
    }
    return res;
  }
  boolean  isThereAnyUnvisited(ArrayList<ArrayList<Cell>>grid) {
    for (int i=0; i<grid.size(); i++) {
      for (int j=0; j<grid.get(i).size(); j++) {
        if (grid.get(i).get(j).state == 0) {
           return true;
        }
      }
    }
    return false;
  }
}
