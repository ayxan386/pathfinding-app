import java.util.Queue;
import java.util.ArrayDeque;
import java.util.Map;

class DFS implements Algorithm {

  Queue<ArrayList<Cell>> run(ArrayList<ArrayList<Cell>> grid, Cell start, Cell target) {
    ArrayDeque<ArrayList<Cell>> res = new ArrayDeque();
    ArrayDeque<Cell> que = new ArrayDeque();
    start.setState(2);
    que.push(start);
    Map<Cell, Cell> path = new HashMap();
    while (!que.isEmpty()) {

      Cell curr = que.pop();
      curr.setState(2);

      if (target.equals(curr))break;

      ArrayList<Cell> neigh = filterVisited(getNeigh(grid, curr));

      ArrayList<Cell> change = new ArrayList();

      change.add(curr.clone());

      for (Cell c : neigh) {
        c.setState(1);
        path.put(c, curr);
        que.push(c);
        change.add(c.clone());
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
    //println("DFS length" + change.size());
    res.add(change);
    return res;
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
  ArrayList<Cell> filterVisited(ArrayList<Cell> or) {
    ArrayList<Cell> res = new ArrayList();
    for (Cell c : or) {
      if (c.state == 0)res.add(c);
    }
    return res;
  }
}
