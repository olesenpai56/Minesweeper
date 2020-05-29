import de.bezier.guido.*;

public final static int NUM_ROW = 20;
public final static int NUM_COLUMN =20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
   buttons = new MSButton[NUM_ROW][NUM_COLUMN];     //made an empty array for buttons
   for(int r = 0; r < buttons.length; r ++){
        for(int c = 0; c < buttons[r].length; c ++){
            buttons[r][c] = new MSButton(r, c);     //put the buttons in 
        }
    }
    
    for(int num = 0; num < 1; num++){
        setMines();
    }
}
public void setMines()
{
    //your code
    //int minesRow = (int)(Math.random() * NUM_ROW);
    //int minesColumn = (int)(Math.random() * NUM_COLUMN);
    //if(!mines.contains(buttons[minesRow][minesColumn])){
        //mines.add(buttons[minesRow][minesColumn]);
    //}
     double randomRow = Math.random() * NUM_ROW;
    double randomCol = Math.random() * NUM_COLUMN;
        if(mines.contains(buttons[(int)randomRow][(int)randomCol])){
            randomRow = Math.random() * NUM_ROW;
            randomCol = Math.random() * NUM_COLUMN;
            mines.add(buttons[(int)randomRow][(int)randomCol]);
        }
    mines.add(buttons[(int)randomRow][(int)randomCol]);

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
    int counter = 0; 
    int counterB = 0; 
    for(int i =0; i< mines.size(); i++){
       if(mines.get(i).isFlagged() == true){
            counter++;
       }
    }
   
    if(counter == mines.size()){
        return true;
    }else{
        return false;
    }

    }
public void displayLosingMessage()
{
    //your code here

    buttons[NUM_ROW/2][NUM_COLUMN/2 - 1].setLabel("L");
    buttons[NUM_ROW/2][NUM_COLUMN/2].setLabel("O");
    buttons[NUM_ROW/2][NUM_COLUMN/2 + 1].setLabel("S");
    buttons[NUM_ROW/2][NUM_COLUMN/2 + 2].setLabel("E");
    buttons[NUM_ROW/2][NUM_COLUMN/2 - 4].setLabel("R");
 
    fill(100);

}
public void displayWinningMessage()
{
    //your code here
     buttons[NUM_ROW/2][NUM_COLUMN/2 - 4].setLabel("W");
    buttons[NUM_ROW/2][NUM_COLUMN/2 - 3].setLabel("I");
    buttons[NUM_ROW/2][NUM_COLUMN/2 - 2].setLabel("N");
    
    fill(100);
}


public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLUMN;
        height = 400/NUM_ROW;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isClicked()
    {
        return clicked;
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
    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        //your code here
        if(mouseButton == RIGHT){
           flagged = !flagged; 
           if(flagged == false){
              clicked = false;
           }
        }else if(mines.contains(this)){
            displayLosingMessage();
        }else if(countMines(myRow,myCol) >0 ){
            myLabel = "" + countMines(myRow,myCol);
        }else{
            for(int i= myRow -1; i<=myRow+1; i++){
                for(int j = myCol-1; j<= myCol+1; j++){
                    if(isValid(myRow, myCol) && (buttons[myRow][myCol].isClicked() == false)){
                       buttons[myRow][myCol].mousePressed();
                    }
                }
            }
        }
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
    public int countMines(int row, int col)
{
    int numMines = 0;
    //your code here

   for(int i=row-1; i<row+1; i++){
      for(int j=col-1; j< col+1; i++){
          if(isValid(i,j) && mines.contains(buttons[i][j])){
            numMines++;
          }
      }
   }
   return numMines;
}
public boolean isValid(int r, int c)
{
    //your code here
   if(r>=0 && r<= NUM_ROW && c>=0 && c<=NUM_COLUMN){
     return true;
   }else{
    return false;
   }
}
}
