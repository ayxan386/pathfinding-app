import java.util.Queue;
import java.util.ArrayDeque;

interface Algorithm {

  Queue<ArrayList<Cell>> run(ArrayList<ArrayList<Cell>> grid, Cell start, Cell target);
}
