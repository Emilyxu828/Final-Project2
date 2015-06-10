// card images https://code.google.com/p/vector-playing-cards/
// http://www.rgbhex.com/  COLORS

// need to fix "go back to menu" function
// instead of having the back of a card, we could tint the card an opaque color instead
// still need to figure out how to tint cards when they are clicked
//      biggest problem is figuring out how to know which card is clicked
// we need to figure out how the point system works
// adding from the stock works the first time when clicked, but not the second time
// maybe we can use shaders/set() to outline the cards when they are face down
// remove cards from upCards
// should rewrite setup into different functions 

// for the initial setup
// the tableaus will be in an array
// the piles of cards in the tableaus will be linked lists of nodes
// these nodes will point to the next cards

// the cards will be represented by nodes
// the cards will have a boolean to represent face up/down
// the cards also need to have values and names 
// the values will determine if a move is valid or not 


// there are 104 cards
// in the setup, 54 cards are put in the columns
// there are 10 tableaus (hence array of length 10) 
// first 4 have 6 cards, other 6 have 5 cards
// other 50 cards are in the stock

// easy: only one suit (spades)
// intermediate: two suits (spades and hearts)
// difficult: four suits

import java.util.ArrayList;
import java.util.Collections;

LL[] tableaus;
ArrayList<Node> stock = new ArrayList<Node>();
Node[] cards = new Node[104]; 
ArrayList<Integer> list = new ArrayList<Integer>(); // random ints to 104
int listPos = 0; 
PImage[] imgs = new PImage[14];
int[] columns = new int[10];

ArrayList<Node> upCards = new ArrayList<Node>();
Node tmpCard;

// width card = 500
// length card = 760
// loads card images
PImage img1, img2, img3, img4, img5, img6, img7, img8, img9, img10, img11, img12, img13;
/*img1 = loadImage("1.png");
img2 = loadImage("2.png");
img3 = loadImage("3.png");
img4 = loadImage("4.png");
img5 = loadImage("5.png");
img6 = loadImage("6.png");
img7 = loadImage("7.png");
img8 = loadImage("8.png");
img9 = loadImage("9.png");
img10 = loadImage("10.png");
img11 = loadImage("11.png");
img12 = loadImage("12.png");
img13 = loadImage("13.png");*/
// how to scale image: scale(decimal number)
// how to print image: image(imageName, x, y)
int column1 = 200-40;
int column2 = 775-40;
int column3 = 1350-40;
int column4 = 1925-40;
int column5 = 2500-40;
int column6 = 3075-40;
int column7 = 3650-40;
int column8 = 4225-40;
int column9 = 4800-40;
int column10 = 5375-40;
  

int instX, instY;
int startX, startY;
int menuX, menuY;
color instC, startC, menuC;
int instH, instL;
int startH, startL;
int menuH, menuL;

int circlePlayX, circlePlayY;
int circlePlaySize;
color circlePlayC;

boolean inst = false;
boolean start = false;
boolean menuI = false;
boolean menuS = false;
boolean circlePlay = false;
boolean play = false;

boolean rectInstOver = false;
boolean rectStartOver = false;
boolean rectMenuSOver = false;
boolean rectMenuIOver = false;
// play button
boolean circlePlayOver = false;

boolean clicked = false;

//boolean tinted = false;

void setupImgs() {
  imgs[0] = null;
  imgs[1] = img1;
  imgs[2] = img2;
  imgs[3] = img3;
  imgs[4] = img4;
  imgs[5] = img5;
  imgs[6] = img6;
  imgs[7] = img7;
  imgs[8] = img8;
  imgs[9] = img9;
  imgs[10] = img10;
  imgs[11] = img11;
  imgs[12] = img12;
  imgs[13] = img13;
}

void setupColumns() {
  columns[0] = column1;
  columns[1] = column2;
  columns[2] = column3;
  columns[3] = column4;
  columns[4] = column5;
  columns[5] = column6;
  columns[6] = column7;
  columns[7] = column8;
  columns[8] = column9;
  columns[9] = column10;
}

void setup() {
  setup1();   
}

void setup1() {
  size(1500, 800);
  background(0,0,102);
  textSize(200);
  textAlign(CENTER);
  text("SOLITAIRE", 750, 325);
  textAlign(CENTER);
  textSize(75);
  text("By Alice Xue & Emily Xu", 750, 700);
  
  //instructions & start buttons
  instC = color(255,0,0);
  instX = 500;
  instY = 500;
  instL = 200;
  instH = 50;
  rect(instX, instY, instL, instH);
  textSize(20);
  textAlign(LEFT);
  text("Instructions", 500, 500);
  
  startC = color(255,0,0);
  startX = 700;
  startY = 500;
  startL = 200;
  startH = 50;
  rect(startX, startY, startL, startH);
  textSize(20);
  textAlign(LEFT);
  text("Start", 700, 500); 
  
  // load card images continued
  img1 = loadImage("1.png");
  img2 = loadImage("2.png");
  img3 = loadImage("3.png");
  img4 = loadImage("4.png");
  img5 = loadImage("5.png");
  img6 = loadImage("6.png");
  img7 = loadImage("7.png");
  img8 = loadImage("8.png");
  img9 = loadImage("9.png");
  img10 = loadImage("10.png");
  img11 = loadImage("11.png");
  img12 = loadImage("12.png");
  img13 = loadImage("13.png");
  
  setupImgs();
  setupColumns();
}

void draw() {
  update(mouseX, mouseY);
  if (inst == true) {
    //resetBooleans();
    inst = true;
    background(0,0,102);
    textSize(20);
    text("Instructions", 700, 300);
    menuC = color(255,0,0);
    menuX = 700;
    menuY = 500;
    menuL = 200;
    menuH = 50;
    rect(menuX, menuY, menuL, menuH);
    textSize(20);
    text("Go back to the menu", 700, 500);
  }
  if (start == true) {
    //resetBooleans();
    start = true;
    background(0,0,102);
    textSize(20);
    text("Start", 700, 300);
    circlePlayC = color(255,0,0);
    circlePlayX = 700;
    circlePlayY = 400;
    circlePlaySize = 100;
    ellipse(circlePlayX, circlePlayY, circlePlaySize, circlePlaySize);
    textSize(20);
    text("PLAY!",600,400);
    menuC = color(255,0,0);
    menuX = 700;
    menuY = 500;
    menuL = 200;
    menuH = 50;
    rect(menuX, menuY, menuL, menuH);
    textSize(20);
    text("Go back to the menu", 700, 500);
  }
  if (menuI == true) {
    //resetBooleans();
    menuI = true;
    setup1();
  }
  if (menuS == true) {
    //resetBooleans();
    menuS = true;
    setup1();
  }
  if (circlePlay == true) {
    resetBooleans();
    circlePlayOver = true;
    background(51,153,0);
    setupGame();
    setupPlay();  
    circlePlay = false;
    play = true;
    
    /*
       
    scale(.25);
    //tint(255,255);
    image(img1, column1, 200);
    image(img2, column2, 200);
    image(img1, column3, 200);
    image(img2, column4, 200);
    image(img1, column5, 200);
    image(img2, column6, 200);
    image(img1, column7, 200);
    image(img2, column8, 200);
    //tint(0, 153, 204);
    image(img1, column9, 200);
    //tint(0, 153, 204);
    image(img2, column10, 200);
    if (tinted == true) {
      tint(0, 153, 204);
      //scale(.25);
      image(img1, column1, 200);
      tinted = false;
    }
    else if (tinted == false) {
      tint(255,255);
      //noTint();
      //scale(.25);
      image(img1, column1, 200);
      tinted = true;
    }
    */
  }
  //float x;
  //image(img2, x, 0, 400, 500);
  //x+=0.01;
 
 
}

void resetBooleans() {
    start = false;
    inst = false;
    menuI = false;
    menuS = false;
    circlePlay = false;
}

void resetBooleans2() {
    rectInstOver = false;
    rectStartOver = false;
    rectMenuSOver = false;
    rectMenuIOver = false;
    circlePlayOver = false;  
}

void update(int x, int y) {
  if (overRect(instX, instY, instL, instH)) {
    resetBooleans2();
    rectInstOver = true;
  }
  if (overRect(startX, startY, startL, startH)) {
    resetBooleans2();
    rectStartOver = true;
  }
  if (start == true && overRect(menuX, menuY, menuL, menuH)) {
    resetBooleans2();
    rectMenuSOver = true;
  }
  if (inst == true && overRect(menuX, menuY, menuL, menuH)) {
    resetBooleans2();
    rectMenuIOver = true;
  }
  if (overCircle(circlePlayX, circlePlayY, circlePlaySize)) {
    resetBooleans2();
    circlePlayOver = true;    
  }
  //text ("egwegwer", 600, 600);
  if (play) {
    int tmpX;
    int tmpY;
    for (int i = 0; i<upCards.size(); i++) {
      Node tmp = upCards.get(i);
      tmpX = tmp.getX();
      tmpY = tmp.getY();            /*----- the problem is w these ints??? -----*/
      //text("egeege", 600, 600);
      text(str(tmpX), 600, 600);
              fill(204, 102, 0);
              rect(tmpX, tmpY, 500, 20, 20, 20, 0, 0);     //y = 890 = 900-10
              rect((tmpX+495), tmpY, 20, 760-5, 0, 20, 20, 0);     //y = 890 = 900 - 10
              rect(tmpX-10, tmpY, 20, 760-5, 20, 0, 0, 20);     //y = 890 = 900 - 10
              rect((tmpX), (tmpY-25+760), 500, 20, 0, 0, 20, 20);     //y = 865 = 900 - 35
      if (overSpefCard(mouseX, mouseY, tmpX, tmpY)) {
        clicked = true;
        tmpCard = tmp;
        tint(0, 153, 204);
        image(imgs[tmp.getValue()],tmpX, tmpY);
        
        // width card = 500
        // length card = 760
        fill(204, 102, 0);
        rect(tmpX, tmpY, 500, 20, 20, 20, 0, 0);     //y = 890 = 900-10
        rect((tmpX+495), tmpY, 20, 760-5, 0, 20, 20, 0);     //y = 890 = 900 - 10
        rect(tmpX-10, tmpY, 20, 760-5, 20, 0, 0, 20);     //y = 890 = 900 - 10
        rect((tmpX), (tmpY-25+760), 500, 20, 0, 0, 20, 20);     //y = 865 = 900 - 35
      }
    }
  }
         
}



boolean overRect(int x, int y, int w, int h) {
  if (mouseX >= x && mouseX <= x+w && mouseY >= y && mouseY <= y+h) {
    return true;
  }
  return false;
}

boolean overCircle(int x, int y, int diameter){
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2) {
    return true;
  } else {
    return false;
  }
}

boolean overCard(int x, int y){
    // width card = 500
    // length card = 760
    if (mouseX >= x/1 && mouseX <= (x+500)/1 && mouseY >= y/1 && mouseY <= (y+760)/1){
      return true;
    }
    else {
      return false;
    }
}

boolean overSpefCard(int x1, int y1, int x2, int y2) {
  if (x1 >= x2 && x1 <= (x2+500)/1 && y1 >= y2 && y1 <= (y2+760)/1) 
    return true;
  return false;
}

/*

int validCardCoords(int x, int y) {
  boolean result = false;
  int column = 0;
  for (int i = 0; i<columns.length;i++) 
    if (x==i) {
      result = true;
      column = i;
    }
  if (result == true && (y-150)%150==0) 
    return column;
  return -1;
}  

*/

void mousePressed(){ 
  if (rectInstOver == true){
    resetBooleans();
    inst = true;
  }
  if (rectStartOver == true) {
    resetBooleans();
    start = true;
  }
  if (rectMenuSOver == true) {
    resetBooleans();
    menuS = true;
  }
  if (rectMenuIOver == true) {
    resetBooleans();
    menuI = true;
  }
  if (circlePlayOver == true) {
    resetBooleans();
    circlePlay = true;
  }
  /*
  if (overCard(200, column1)){
    if (tinted == true) 
      tinted = false;
    if (tinted == false)
      tinted = true;
    //tint(0, 153, 204);
    //scale(.25);
    //image(img1, column1, 200);
    //tint(255,255);
    image(img2, column2, 200);
    image(img1, column3, 200);
    image(img2, column4, 200);
    image(img1, column5, 200);
    image(img2, column6, 200);
    image(img1, column7, 200);
    image(img2, column8, 200);
  }
  */
  
  // click on stock
  // this only works when clicked once when game begins but not the next time -- need to fix
  if (overCard(column1, 2200) && !stock.isEmpty()) {
    addFromStock(); 
    setupPlay();
  }
  
  if (clicked) {
    tint(0, 153, 204);
    image(imgs[tmpCard.getValue()],tmpCard.getX(),tmpCard.getY());
    //noTint();
    Node tmp = tmpCard.getNext();
    while (tmp!=null) {
      image(imgs[tmp.getValue()],tmpCard.getX(),tmpCard.getY());
      tmp = tmp.getNext();
    } 
  }

}







void setupPlay() {
  int posY = 150;
  scale(.25);
  for (int i = 0; i<tableaus.length; i++) {
    Node tmp = tableaus[i].getFirst();
    while (tmp != null) {
      if (!tmp.faceUp()) {
        tint(0, 0, 0, 252);
      }
      PImage tmpI = imgs[tmp.getValue()];
      int c = columns[i];
      image(tmpI,c,posY);
      if (!tmp.faceUp()){
        noTint();
      }
      tmp.setX(c);
      tmp.setY(posY);
      tmp = tmp.getNext();
      posY=posY+150;
    }
    posY = 150;
  }
  if (!stock.isEmpty()) {
    Node stocktmp = stock.get(0);
    tint(0, 0, 0, 252);
    image(imgs[stocktmp.getValue()],column1,2200);
    //noTint();
  }
  
  
  // width card = 500
  // length card = 760
  fill(204, 102, 0);
  rect(column1, 890, 500, 20, 20, 20, 0, 0);
  rect((column1+495), 890, 20, 760-5, 0, 20, 20, 0);
  rect(column1-10, 890, 20, 760-5, 20, 0, 0, 20);
  rect((column1), (865+760), 500, 20, 0, 0, 20, 20);
  textSize(100);
  text("testing^", 160, 1800);
  noFill();
}

void makeDeck(int startpos) {
  int pos = startpos;
  for (int i = 0; i < 13; i++ ) {
    cards[pos] = new Node(i+1);
    cards[pos+13] = new Node(i+1);
    cards[pos+26] = new Node(i+1);
    cards[pos+39] = new Node(i+1);
    pos++;
  }
}

void easy() {
  makeDeck(0);
  makeDeck(52);
}

void randomgenerator() {
  // unique number generator 
  // http://stackoverflow.com/questions/8115722/generating-unique-random-numbers-in-java
  for (int i = 0; i < 104; i++) {
    list.add(new Integer(i));
  }
  Collections.shuffle(list);
}

int UQint() {
  int result = list.get(listPos);
  listPos++;
  return result;
}

void setupGame() {
  easy();
  randomgenerator();
  // this sets up the tableaus with random cards
  tableaus = new LL[10];
  for (int i = 0; i < tableaus.length; i++) {
    tableaus[i] = new LL(cards[UQint()]);
    if (i < 4) {
      for (int j = 1; j < 6; j++) {
        Node tmp = cards[UQint()];
        /*
        if (j==5) 
          tmp.setFace(true);
          */
        tableaus[i].add(tmp);
      }
    } else {
      for (int j = 1; j < 5; j++) {
        Node tmp = cards[UQint()];
        /*
        if (j==4) 
          tmp.setFace(true);
          */
        tableaus[i].add(tmp);
      }
    }
  }  
  
  //fills stock
  for (int i = 0; i < 50; i++) {
    Node tmp = cards[UQint()];
    tmp.setFace(true);
    stock.add(tmp);
  }
  
  // turns the last card in each tableau up
  for (int i = 0; i < tableaus.length; i++) {
    LL tmp = tableaus[i];
    Node tmp2 = tmp.getLast();
    tmp2.setFace(true);
    upCards.add(tmp2);
  }
  
}

// when player clicks stock, this method is called to add new cards to the tableaus
void addFromStock() {
  for (int i = 0; i < tableaus.length; i++) {
     LL l = tableaus[i];
     Node n = stock.get(0);
     n.setFace(true);
     l.add(n);
     upCards.add(n);
     stock.remove(0);
  }
}


// checks if face up columns are complete
// returns -1 if no tableaus are complete
// returns index of tableau if there is one complete
int completeTableau() {
  int tableauIndex = -1;
  for (int i = 0; i < tableaus.length; i++) {
    Node tmp = tableaus[i].getFirst();
    while (tmp != null) {
      if (tmp.faceUp() == true) {
         tableauIndex = i;
      }
      if (tableauIndex != -1) 
        break;
    }
  }
  return tableauIndex;
}

// checks if multiple cards can be moved
boolean validMultipleMove(Node card) {
  Node tmp = card;
  Node tmp2 = card.getNext();
  while (tmp2 != null) {
    if (tmp2.getValue() >= tmp.getValue()) {
      return false;
    }
    if (tmp.getValue()-tmp2.getValue()>1) {
      return false;
    }
    tmp = tmp.getNext();
    tmp2 = tmp.getNext();
  }
  return true;
}
  
class Node {
  int value;
  boolean up;
  Node next;
  // tint blue if clicked
  boolean tinted;
  
  int x;
  int y;
  
  PImage card;
  //String cardname;
  
  Node (int v) {
    value = v;
    up = false;
    next = null;
    tinted = false;
  }
  
  void setFace(boolean up1) {
     if (up1) 
      up = true;
     else 
      up = false;
  }
  
  int getValue() {
    return value;
  }
  
  boolean faceUp() {
    return up;
  }
    
  void setNext(Node n) {
    next = n;
  }
  
  Node getNext() {
    return next;
  }
  
  void setX(int tmpx) {
    x = tmpx;
  }
  
  void setY(int tmpy) {
    y = tmpy;
  }
  
  int getX() {
    return x;
  }
  
  int getY() {
    return y;
  }
  
  boolean getTinted() {
    return tinted;
  }
  
  void setTinted(boolean n) {
    if (n==true)
      tinted = true;
    else 
      tinted = false;
  }
  
  /*
  void setImage() {
    String s = Integer.toString(value);
    cardname = s+".png";
  }
  */
  
  PImage getCard() {  
    return imgs[value]; 
  }
   
  
}
  
class LL {
  Node l;
  
  LL(Node n) {
    l = n;
  }
  
  boolean add(Node n) {
    if (l==null) 
      l = n;
    else
      getLast().setNext(n);
    return true;
  }
  
  // remove last card in tableau (player initiated) -- need to write this
  boolean remove() {
    return true;
  }
    
  Node getFirst() {
    return l;
  }  
    
  Node getLast() {
    Node tmp = l;
    while (tmp.getNext() != null) {
      tmp = tmp.getNext();
    }
    return tmp;
  }
    
}








/*

everytime a card gets called again you print it again??? :( ugh
to play:
click one card a, click another card b. if a = b-1, then a goes on top of b
everything on top of a follows a on top of b

once face up cards are 1 to 13, stack of cards 1 t0 13 disappears
one card (king?) appears at bottom of screen

if nontinted card is removed, leaving tinted card on top of pile, tinted card untints

*/
