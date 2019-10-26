class Cell {
  final int x;
  final int y;
  int state;

  Cell(int x, int y) {
    this.x = x;
    this.y = y;
    this.state = 0;
  }
  Cell(int x, int y, int state) {
    this.x = x;
    this.y = y;
    this.state = state;
  }

  int getState() {
    return this.state;
  }

  void nextState() {
    this.state++;
  }

  boolean equals(Object b) {
    if (!(b instanceof Cell))return false;
    if (this == b)return true;

    Cell that = (Cell)b;
    if (that.x == this.x && 
      that.y == this.y)return true;

    return false;
  }
  void setState(int state) {
    this.state = state;
  }

  void makeBrick() {
    this.state = -1;
  }
  void clear() {
    this.state = 0;
  }
  Cell clone() {
    return new Cell(this.x, this.y, this.state);
  }
  public int hashCode(){
    return this.x * 31 + this.y;
  }
  public String toString(){
    return String.format("(%d,%d), %d",this.x,this.y,this.state);
  }
}
