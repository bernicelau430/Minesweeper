import de.bezier.guido.*;
int NUM_ROWS = 5; 
int NUM_COLS = 5;
int NUM_MINES = 2;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for (int row = 0; row < NUM_ROWS; row++) {
      for (int col = 0; col < NUM_COLS; col++) {
        buttons[row][col] = new MSButton(row, col);
      }
    }
    setMines();
}
public void setMines() {
  while (mines.size() < NUM_MINES) {
     int randomRow = (int)(Math.random()*NUM_ROWS);
     int randomCol = (int)(Math.random()*NUM_COLS);
     if (!mines.contains(buttons[randomRow][randomCol])) {
       mines.add(buttons[randomRow][randomCol]);
     } 
  }
  // System.out.println(randomRow + "," + randomCol);
}

public void draw (){
  background( 0 );
  if(isWon() == true)
    displayWinningMessage();
}
public boolean isWon() {
  boolean temp = true;
  for (int row = 0; row < NUM_ROWS; row++) {
    for (int col = 0; col < NUM_COLS; col++) {
      if (buttons[row][col].clicked == false) {
        if (!mines.contains(buttons[row][col])) {
          temp = false;
        }
      }
    }
  }
  return temp;
}
public void displayLosingMessage(){
  for (int row = 0; row < NUM_ROWS; row++) {
    for (int col = 0; col < NUM_COLS; col++) {
      if (mines.contains(buttons[row][col])) {
        buttons[row][col].setLabel("You lose, try again!");
      }
    }
  }
}
public void displayWinningMessage() {
  for (int row = 0; row < NUM_ROWS; row++) {
    for (int col = 0; col < NUM_COLS; col++) {
      buttons[row][col].setLabel("You Win!");
    }
  }
}
public boolean isValid(int r, int c) {
  if (r < NUM_ROWS && r >= 0 && c < NUM_COLS && c >= 0) {
    return true;
  }
  return false;
}
public int countMines(int row, int col) {
  int numMines = 0;
  if (isValid(row + 1, col)) { //down
    if (mines.contains(buttons[row + 1][col])){
      numMines += 1;
    }
  }
  if (isValid(row + 1, col + 1)) { //diagonal-right-down
    if (mines.contains(buttons[row + 1][col + 1])){
      numMines += 1;
    }
  }
  if (isValid(row, col + 1)) { //right
    if (mines.contains(buttons[row][col + 1])){
      numMines += 1;
    }
  }
  if (isValid(row + 1, col - 1)) { //diagonal-left-down
    if (mines.contains(buttons[row + 1][col - 1])){
      numMines += 1;
    }
  }
  if (isValid(row - 1, col - 1)) { //diagonal-left-up
    if (mines.contains(buttons[row - 1][col - 1])){
      numMines += 1;
    }
  }
  if (isValid(row, col - 1)) { //left
    if (mines.contains(buttons[row][col - 1])){
      numMines += 1;
    }
  }
  if (isValid(row - 1, col)) { //up
    if (mines.contains(buttons[row - 1][col])){
      numMines += 1;
    }
  }
  if (isValid(row - 1, col + 1)) { //diagonal-right-up
    if (mines.contains(buttons[row - 1][col + 1])){
      numMines += 1;
    }
  }
  return numMines;
}
public class MSButton {
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        if (mouseButton == RIGHT) {
          if (flagged == true) {
            flagged = false;
          }
          else {
            flagged = true;
            clicked = false;
          }
        } 
        else if (mines.contains(this)) {
            displayLosingMessage();
        } 
        else if (countMines(this.myRow, this.myCol) >= 0) {
            this.setLabel(countMines(this.myRow, this.myCol));
        }
        else {
           if (isValid(this.myRow, this.myCol + 1) && buttons[this.myRow][this.myCol + 1].clicked == false) {
             buttons[this.myRow][this.myCol + 1].mousePressed(); //right
           }
           if (isValid(this.myRow, this.myCol - 1) && buttons[this.myRow][this.myCol - 1].clicked == false) {
             buttons[this.myRow][this.myCol - 1].mousePressed(); //left
           }
           if (isValid(this.myRow - 1, this.myCol) && buttons[this.myRow - 1][this.myCol].clicked == false) {
             buttons[this.myRow - 1][this.myCol].mousePressed(); //up
           }
           if (isValid(this.myRow + 1, this.myCol) && buttons[this.myRow + 1][this.myCol].clicked == false) {
             buttons[this.myRow + 1][this.myCol].mousePressed(); //down
           }
           if (isValid(this.myRow + 1, this.myCol + 1) && buttons[this.myRow + 1][this.myCol + 1].clicked == false) {
             buttons[this.myRow + 1][this.myCol + 1].mousePressed(); //diagonal-right-down
           }
           if (isValid(this.myRow - 1, this.myCol + 1) && buttons[this.myRow - 1][this.myCol + 1].clicked == false) {
             buttons[this.myRow - 1][this.myCol + 1].mousePressed(); //diagonal-right-up
           }
           if (isValid(this.myRow + 1, this.myCol - 1) && buttons[this.myRow + 1][this.myCol - 1].clicked == false) {
             buttons[this.myRow + 1][this.myCol - 1].mousePressed(); //diagonal-left-down
           }
           if (isValid(this.myRow - 1, this.myCol - 1) && buttons[this.myRow - 1][this.myCol - 1].clicked == false) {
             buttons[this.myRow - 1][this.myCol - 1].mousePressed(); //diagonal-left-up
           }
        }
    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );
        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
