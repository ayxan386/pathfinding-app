import java.util.Iterator;

class Animator {
  boolean setZero = false;
  Queue<ArrayList<Cell>> iterations;
  Animator(Queue<ArrayList<Cell>> ch) {
    this.iterations = ch;
    //frameRate(ch.size() * 0.87);
    //println("Fps is :" +ch.size() * 0.87); 
    frameRate(60); // for testing
  }
  Animator(Queue<ArrayList<Cell>> ch, boolean setZero) {
    this.iterations = ch;
    //frameRate(ch.size() * 0.87);
    //println("Fps is :" +ch.size() * 0.87);
    this.setZero = setZero;
    frameRate(60); // for testing
  }

  boolean play(Grid grid) {
    ArrayList<Cell> curr = iterations.poll();
    if (curr != null) {
      for (Cell c : curr) {
        grid.setCellAt(c.x, c.y, c.state);
      }
      return true;
    }
    return false;
  }
}
