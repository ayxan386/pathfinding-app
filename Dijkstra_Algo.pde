//import java.util.Queue;
//import java.util.Map;
import java.util.*;
import java.util.Map.*;
//import java.util.ArrayDeque;

class Dijikstra implements Algorithm {

  Queue<ArrayList<Cell>> run(ArrayList<ArrayList<Cell>> grid, Cell start, Cell target) {
    ArrayDeque<ArrayList<Cell>> res = new ArrayDeque();

    Map<Cell, Cell> path = new HashMap();

    Map<Cell, Integer> d = initMap(grid);
    d.put(start, 0);

    for (;;) {

      Cell curr = getMinCell(d);
      if(curr == null)break;

      curr.setState(2);

      if (target.equals(curr))break;

      ArrayList<Cell> change = new ArrayList();
      change.add(curr.clone());
      ArrayList<Cell> neigh = (getNeigh(grid, curr));
      
      for (Cell c : neigh) {
        if (c.state != -1) {
          if (d.get(c) > d.get(curr) + 1) {
            path.put(c, curr);
            c.setState(1);
            d.put(c, d.get(curr) + 1);
            change.add(c.clone());
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
    //println("Dijikstra length" + change.size());
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
  Cell getMinCell(Map<Cell, Integer> d) {
    Cell min = null;
    int dis = Integer.MAX_VALUE;

    for (Map.Entry<Cell, Integer> el : d.entrySet()) {
      if (el.getKey().state == 2 || el.getKey().state == -1)continue;
      if (el.getValue() < dis) {
        min = el.getKey();
        dis = el.getValue();
      }
    }
    return min;
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
