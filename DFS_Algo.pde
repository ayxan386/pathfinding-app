import java.util.Queue;
import java.util.ArrayDeque;
import java.util.Map;

class DFS implements Algorithm {

  Queue<ArrayList<Cell>> run(ArrayList<ArrayList<Cell>> grid, Cell start, Cell target) {
    ArrayDeque<ArrayList<Cell>> res = new ArrayDeque();
    ArrayDeque<Cell> que = new ArrayDeque();
    start.setState(2);
    que.push(start);
    Map<Cell,Cell> path = new HashMap();
    while (!que.isEmpty()) {
      Cell curr = que.pop();
      curr.setState(2);

      if (target.equals(curr))break;

      ArrayList<Cell> change = new ArrayList();
      change.add(curr.clone());
      if (curr.y - 1 >= 0) {
        Cell top = grid.get(curr.y - 1).get(curr.x);
        if (top.state == 0) {
          top.setState(1);
          path.put(top,curr);
          que.push(top);
          change.add(top.clone());
        }
      }
      if (curr.y + 1 < grid.size()) {
        Cell bottom = grid.get(curr.y + 1).get(curr.x);
        if (bottom.state == 0) {
          bottom.setState(1);
          path.put(bottom,curr);
          que.push(bottom);
          change.add(bottom.clone());
        }
      }
      if (curr.x - 1 >= 0) {
        Cell left = grid.get(curr.y).get(curr.x - 1);
        if (left.state == 0) {
          left.setState(1);
          path.put(left,curr);
          que.push(left);
          change.add(left.clone());
        }
      }
      if (curr.x + 1 < grid.get(0).size()) {
        Cell right = grid.get(curr.y).get(curr.x + 1);
        if (right.state == 0) {
          right.setState(1);
          path.put(right,curr);
          que.push(right);
          change.add(right.clone());
        }
      }
      res.add(change);
    }
    ArrayList<Cell> change = new ArrayList();
    Cell c = path.get(target);
    while(!start.equals(c)){
      c.setState(3);
      change.add(c.clone());
      c = path.get(c);
    }
    res.add(change);
    return res;
  }
}
