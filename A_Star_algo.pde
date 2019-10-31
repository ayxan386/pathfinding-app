//import java.util.Queue;
//import java.util.Map;
import java.util.*;
import java.util.Map.*;
//import java.util.ArrayDeque;

class Astar implements Algorithm {

  Queue<ArrayList<Cell>> run(ArrayList<ArrayList<Cell>> grid, Cell start, Cell target) {
    ArrayDeque<ArrayList<Cell>> res = new ArrayDeque();

    ArrayDeque<Cell> openSet = new ArrayDeque();
    openSet.add(start);

    Map<Cell, Cell> path = new HashMap();

    Map<Cell, Integer> gScore = initMap(grid);
    gScore.put(start, 0);

    Map<Cell, Integer> fScore = initMap(grid);
    fScore.put(start, h(start, target));

    while (!openSet.isEmpty()) {

      Cell curr = getMinCell(fScore, openSet);
      openSet.remove(curr);

      if (curr == null)break;
      curr.setState(2);

      if (target.equals(curr))break;

      ArrayList<Cell> change = new ArrayList();
      change.add(curr.clone());
      ArrayList<Cell> neigh = (getNeigh(grid, curr));
      
      for (Cell c : neigh) {
        if (c.state != -1) {
          if (gScore.get(c) > gScore.get(curr) + 1) {
            path.put(c, curr);
            c.setState(1);
            change.add(c.clone());

            gScore.put(c, gScore.get(curr) + 1);

            fScore.put(c, gScore.get(c) + h(c, target));
            if (!openSet.contains(c))openSet.add(c);
          }
        }
      }
      
      res.add(change);
    }
    ArrayList<Cell> change = new ArrayList();
    Cell c = path.get(target);
    while (c != null && !start.equals(c)) {
      c.setState(3);
      change.add(c.clone());
      c = path.get(c);
    }
    //println("fScore value" + fScore.get(target));
    //println("A* length" + change.size());
    res.add(change);

    return res;
  }

  Map<Cell, Integer> initMap(ArrayList<ArrayList<Cell>> grid) {
    Map<Cell, Integer> res = new HashMap();
    for (ArrayList<Cell> row : grid) {
      for (Cell c : row) {
        res.put(c, Integer.MAX_VALUE);
      }
    }
    return res;
  }
  Cell getMinCell(Map<Cell, Integer> dis, Deque<Cell> que) {
    Cell min = null;
    int disMin = Integer.MAX_VALUE;

    for (Cell el : que) {
      if (dis.get(el) < disMin) {
        min = el;
        disMin = dis.get(el);
      }
    }
    return min;
  }
  Integer h(Cell a, Cell b) {
    return (int)(((a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y)));
  }
  ArrayList<Cell> getNeigh(ArrayList<ArrayList<Cell>> grid, Cell curr) {
    ArrayList<Cell> res = new ArrayList();
    if (curr.y - 1 >= 0) {
      Cell top = grid.get(curr.y - 1).get(curr.x);
      res.add(top);
    }
    if (curr.y + 1 < grid.size()) {
      Cell bottom = grid.get(curr.y + 1).get(curr.x);
      res.add(bottom);
    }
    if (curr.x - 1 >= 0) {
      Cell left = grid.get(curr.y).get(curr.x - 1);
      res.add(left);
    }
    if (curr.x + 1 < grid.get(0).size()) {
      Cell right = grid.get(curr.y).get(curr.x + 1);
      res.add(right);
    }
    return res;
  }
}
