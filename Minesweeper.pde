import de.bezier.guido.*;
int NUM_ROWS = 20;
int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
public final int NUM_BOMBS = (int)((Math.random()*20)+10);
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    // mines = new ArrayList <MSButton>();
    for(int i =0; i< NUM_ROWS; i++){
        for(int k = 0; k < NUM_COLS; k++){
            buttons[i][k] = new MSButton(i,k);
        }
    }
     //your code to initialize buttons goes here
    setMines();
}
public void setMines()
{
    while(mines.size() < NUM_BOMBS){
        int row = (int)(Math.random()*20);
        int col = (int)(Math.random()*20);
        if(mines.contains(buttons)==false){
            mines.add(buttons[row][col]);
        System.out.println(row+"."+col);
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
    for(int i = 0; i<=NUM_ROWS; i++){
        for(int c = 0; i<=NUM_COLS;c++){
            if(!mines.contains(buttons[i][c])&&!buttons[i][c].clicked){
                return false;
            }
        }
    }
    return true;
}
public void displayLosingMessage()
{
    textSize(40);
    text("You lose:(",10,90);
}
public void displayWinningMessage()
{
    textSize(40);
    text("You win:(",10,90);
}
public boolean isValid(int r, int c)
{
    if(r >= NUM_ROWS || r < 0 || c >= NUM_COLS || c< 0){
        return false;
    }
    return true;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    if(isValid(NUM_ROWS-1,NUM_COLS)==true && mines.contains(buttons[NUM_ROWS-1][NUM_COLS])){
        numMines ++;
    }
    if(isValid(NUM_ROWS+1,NUM_COLS)==true && mines.contains(buttons[NUM_ROWS+1][NUM_COLS])){
        numMines ++;
    }
    if(isValid(NUM_ROWS,NUM_COLS-1)==true && mines.contains(buttons[NUM_ROWS][NUM_COLS-1])){
        numMines ++;
    }
    if(isValid(NUM_ROWS,NUM_COLS+1)==true && mines.contains(buttons[NUM_ROWS][NUM_COLS+1])){
        numMines ++;
    }
    if(isValid(NUM_ROWS-1,NUM_COLS+1)==true && mines.contains(buttons[NUM_ROWS-1][NUM_COLS+1])){
        numMines ++;
    }
    if(isValid(NUM_ROWS-1,NUM_COLS-1)==true && mines.contains(buttons[NUM_ROWS-1][NUM_COLS-1])){
        numMines ++;
    }
    if(isValid(NUM_ROWS+1,NUM_COLS+1)==true && mines.contains(buttons[NUM_ROWS+1][NUM_COLS+1])){
        numMines ++;
    }
    if(isValid(NUM_ROWS+1,NUM_COLS-1)==true && mines.contains(buttons[NUM_ROWS+1][NUM_COLS-1])){
        numMines ++;
    }
    return numMines;
}
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

    public boolean isClicked(){
        return clicked;
    }
    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        if(mouseButton == RIGHT){
            flagged=!flagged;
            if(flagged==false){
                clicked=false;
            }
        }else if(mines.contains(this)){
            displayLosingMessage();
        }else if(countMines(myRow,myCol)>0){
            setLabel(countMines(myRow,myCol));
        }else{
            if(isValid(myRow,myCol-1) && buttons[myRow][myCol-1].clicked == false)
                buttons[myRow][myCol-1].mousePressed();
            if(isValid(myRow,myCol+1) && buttons[myRow][myCol+1].clicked == false)
                buttons[myRow][myCol+1].mousePressed();
            if(isValid(myRow-1,myCol) && buttons[myRow-1][myCol].clicked == false)
                buttons[myRow-1][myCol].mousePressed();
            if(isValid(myRow+1,myCol) && buttons[myRow+1][myCol].clicked == false)
                buttons[myRow+1][myCol].mousePressed();
            if(isValid(myRow+1,myCol+1) && buttons[myRow+1][myCol+1].clicked == false)
                buttons[myRow+1][myCol+1].mousePressed();
            if(isValid(myRow+1,myCol-1) && buttons[myRow+1][myCol-1].clicked == false)
                buttons[myRow+1][myCol-1].mousePressed();
            if(isValid(myRow-1,myCol+1) && buttons[myRow-1][myCol+1].clicked == false)
                buttons[myRow-1][myCol+1].mousePressed();
            if(isValid(myRow-1,myCol-1) && buttons[myRow-1][myCol-1].clicked == false)
                buttons[myRow-1][myCol-1].mousePressed();
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
