import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
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
    int row,col;
    for(int i = 0; i<NUM_BOMBS;i++){
        row = (int)(Math.random()*20);
        col = (int)(Math.random()*20);
        if(!mines.contains(buttons[row][col])){
            mines.add(buttons[row][col]);
        // System.out.println(row+"."+col);
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
    for(int i = 0; i<mines.size(); i++){
        if(mines.get(i).flagged == false){
            return false;
        }
    }
    return true;
}
public void displayLosingMessage()
{
    textSize(8);
    for(int i=0;i<mines.size();i++){
        mines.get(i).clicked =true;
    }
    for(int r=0;r<NUM_ROWS;r++){
        for(int c=0;c<NUM_COLS;c++){
            if(!mines.contains(buttons[r][c])){
                buttons[r][c].clicked=true;
            }
        }
    }
    buttons[NUM_ROWS/2][NUM_COLS/2 -1].setLabel("You");
    buttons[NUM_ROWS/2][NUM_COLS/2 ].setLabel("Lost");
    buttons[NUM_ROWS/2][NUM_COLS/2 +1].setLabel("XD");
    // textSize(10);
    // text("You lose:(",10,90);
}
public void displayWinningMessage()
{
    buttons[NUM_ROWS/2][NUM_COLS/2 -1].setLabel("YOU");
    buttons[NUM_ROWS/2][NUM_COLS/2 ].setLabel("WIN");
    buttons[NUM_ROWS/2][NUM_COLS/2 +1].setLabel("XD");
    // textSize(10);
    // text("You win:(",10,90);
}
public boolean isValid(int r, int c)
{
    return r < NUM_ROWS && r >= 0 && c < NUM_COLS && c>= 0;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    for(int r=row-1; r<=row+1;r++){
        for(int c = col-1; c<=col+1;c++){
            if(isValid(r,c) && mines.contains(buttons[r][c])){
                numMines++;
            }
        }
    }
    return numMines;
    // if(isValid(NUM_ROWS-1,NUM_COLS)==true && mines.contains(buttons[NUM_ROWS-1][NUM_COLS])){
    //     numMines ++;
    // }
    // if(isValid(NUM_ROWS+1,NUM_COLS)==true && mines.contains(buttons[NUM_ROWS+1][NUM_COLS])){
    //     numMines ++;
    // }
    // if(isValid(NUM_ROWS,NUM_COLS-1)==true && mines.contains(buttons[NUM_ROWS][NUM_COLS-1])){
    //     numMines ++;
    // }
    // if(isValid(NUM_ROWS,NUM_COLS+1)==true && mines.contains(buttons[NUM_ROWS][NUM_COLS+1])){
    //     numMines ++;
    // }
    // if(isValid(NUM_ROWS-1,NUM_COLS+1)==true && mines.contains(buttons[NUM_ROWS-1][NUM_COLS+1])){
    //     numMines ++;
    // }
    // if(isValid(NUM_ROWS-1,NUM_COLS-1)==true && mines.contains(buttons[NUM_ROWS-1][NUM_COLS-1])){
    //     numMines ++;
    // }
    // if(isValid(NUM_ROWS+1,NUM_COLS+1)==true && mines.contains(buttons[NUM_ROWS+1][NUM_COLS+1])){
    //     numMines ++;
    // }
    // if(isValid(NUM_ROWS+1,NUM_COLS-1)==true && mines.contains(buttons[NUM_ROWS+1][NUM_COLS-1])){
    //     numMines ++;
    // }
    // return numMines;
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

    // public boolean isClicked(){
    //     return clicked;
    // }
    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        if(mouseButton == RIGHT){
            if(flagged==true){
                clicked=false;
                flagged=false;
            }else if(flagged ==false){
                flagged = true;
            }
        }else if(mines.contains(this)){
            displayLosingMessage();
        }else if(countMines(this.myRow,this.myCol)>0){
            setLabel(""+countMines(this.myRow,this.myCol));
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
