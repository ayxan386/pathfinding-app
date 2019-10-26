import java.util.Iterator;

class Animator {
  Queue<ArrayList<Cell>> iterations;
  Animator(Queue<ArrayList<Cell>> ch){
    this.iterations = ch;
    frameRate(ch.size() * 0.87);
  }
  
  boolean play(Grid grid) {
    ArrayList<Cell> curr = iterations.poll();
    if(curr != null){
      for(Cell c : curr){
        grid.setCellAt(c.x,c.y,c.state);
      }
      return true;
    }
    return false;
  }
}
