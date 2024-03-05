import de.bezier.guido.*;
public final static int NUM_ROWS = 14;
public final static int NUM_COLS = 14;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines;//ArrayList of just the minesweeper buttons that are mined
public boolean gameOver = false;
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    mines = new ArrayList <MSButton>();
    
    Interactive.make( this );
    for(int r = 0; r < NUM_ROWS; r++)
      for(int c = 0; c < NUM_COLS; c++)
      buttons[r][c] = new MSButton(r,c);
    
    setMines();
    
}
public void setMines()
{
   while(mines.size()<20){
    int r = (int)(Math.random()*NUM_ROWS);
    int c = (int)(Math.random()*NUM_COLS);
    
    if(!mines.contains(buttons[r][c])){
        mines.add(buttons[r][c]);
    }
   }
      
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    for(int r = 0; r < NUM_ROWS; r ++)
    for(int c = 0; c < NUM_COLS; c ++)
if(!buttons[r][c].clicked && !mines.contains(buttons[r][c])){
    return false;
  }
    return true;
}
public void displayLosingMessage()
{
    //your code here
    gameOver = true;
    buttons[7][1].setLabel("Y");
    buttons[7][2].setLabel("O");
    buttons[7][3].setLabel("U");
    buttons[7][4].setLabel("'");
    buttons[7][5].setLabel("R");
    buttons[7][6].setLabel("E");
    buttons[7][7].setLabel("");
    buttons[7][8].setLabel("T");
    buttons[7][9].setLabel("R");
    buttons[7][10].setLabel("A");
    buttons[7][11].setLabel("S");
    buttons[7][12].setLabel("H");
}
public void displayWinningMessage()
{
    buttons[7][1].setLabel("B");
    buttons[7][2].setLabel("E");
    buttons[7][3].setLabel("T");
    buttons[7][4].setLabel("T");
    buttons[7][5].setLabel("E");
    buttons[7][6].setLabel("R");
    buttons[7][7].setLabel("");
    buttons[7][8].setLabel("T");
    buttons[7][9].setLabel("R");
    buttons[7][10].setLabel("A");
    buttons[7][11].setLabel("S");
    buttons[7][12].setLabel("H");
}

public boolean isValid(int r, int c)
{
  if(r < 0 || c < 0 || r >= NUM_ROWS || c >= NUM_COLS){
    return false;
  }
  return true;
}

public int countMines(int row, int col)
{
    int numMines = 0;
  if(isValid(row-1,col-1) && mines.contains(buttons[row-1][col-1]))
    numMines++;
  if(isValid(row-1,col) && mines.contains(buttons[row-1][col]))
    numMines++;
  if(isValid(row-1,col+1) && mines.contains(buttons[row-1][col+1]))
    numMines++;
  if(isValid(row,col-1) && mines.contains(buttons[row][col-1]))
    numMines++;
  if(isValid(row,col+1) && mines.contains(buttons[row][col+1]))
    numMines++;
  if(isValid(row+1,col-1) && mines.contains(buttons[row+1][col-1]))
    numMines++;
  if(isValid(row+1,col) && mines.contains(buttons[row+1][col]))
    numMines++;
  if(isValid(row+1,col+1) && mines.contains(buttons[row+1][col+1]))
    numMines++;
    return numMines;
}
public int numF = 40;

public class MSButton
{
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
       if(gameOver == false){
    clicked = true;
    //your code here
    if (mouseButton==RIGHT) {

      if(flagged == true){
        flagged = false;
        numF++;
      }
      else if(flagged == false){
        flagged = true;
        numF--;
      }
      if(flagged == false)
        clicked = false;
    } else if (mines.contains(this))
      displayLosingMessage();
    else if (countMines(myRow, myCol)>0) {
      clicked=true;
      setLabel(""+countMines(myRow, myCol));
    } else {
      //call mousePressed for the blob on left
      clicked = true;
      for (int i = myRow-1; i<=myRow+1; i++) {
        for (int j = myCol-1; j<=myCol+1; j++) {
          if (isValid(i, j) && !buttons[i][j].clicked) {
            buttons[i][j].mousePressed();
          }
        }
      }
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
