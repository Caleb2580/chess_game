int[][] grid = new int[8][8];
int heighty = 700;
int widthy = 600;
String resignMessage = "";
boolean resigned = false;
boolean blackKingMoved = false;
boolean whiteKingMoved = false;
boolean whiteSide = true;
boolean pressed = false;
boolean promptedWhite = false;
boolean mainScreen = true;
int timeMode = 180;
int white_time = timeMode;
int black_time = timeMode;
int start = millis() / 1000;
boolean timeout = false;
int[] promptSpot = new int[2];
boolean prompted = false;
ArrayList<Integer> whiteTaken = new ArrayList<Integer>();
ArrayList<PImage> whiteTakenImgs = new ArrayList<PImage>();
ArrayList<Integer> blackTaken = new ArrayList<Integer>();
ArrayList<PImage> blackTakenImgs = new ArrayList<PImage>();
int[] oldSpot = new int[2];
int[] newSpot = new int[2];
boolean movedYet = false;
int top_margin = 50;
boolean whiteTurn = true;
boolean checkMate = false;
boolean whiteCheckMate = false;
int empty = 0;
int size = 75;
int white_king = 1;
int white_queen = 2;
int white_bishop = 3;
int white_knight = 4;
int white_rook = 5;
int white_pawn = 6;
int black_king = 11;
int black_queen = 22;
int black_bishop = 33;
int black_knight = 44;
int black_rook = 55;
int black_pawn = 66;

PImage white_king_img;
PImage white_queen_img;
PImage white_bishop_img;
PImage white_rook_img;
PImage white_knight_img;
PImage white_pawn_img;

PImage black_king_img;
PImage black_queen_img;
PImage black_bishop_img;
PImage black_rook_img;
PImage black_knight_img;
PImage black_pawn_img;

PImage white_taken_king_img;
PImage white_taken_queen_img;
PImage white_taken_bishop_img;
PImage white_taken_rook_img;
PImage white_taken_knight_img;
PImage white_taken_pawn_img;

PImage black_taken_king_img;
PImage black_taken_queen_img;
PImage black_taken_bishop_img;
PImage black_taken_rook_img;
PImage black_taken_knight_img;
PImage black_taken_pawn_img;

PImage resign_img;

int[] selectedSquare = new int[2];
boolean selected = false;

void setup()
{
  size(600, 700);
  background(255, 255, 255);
  
  white_king_img = loadImage("imgs\\white_king.png");
  white_king_img.resize(75, 75);
  white_queen_img = loadImage("imgs\\white_queen.png");
  white_queen_img.resize(75, 75);
  white_bishop_img = loadImage("imgs\\white_bishop.png");
  white_bishop_img.resize(75, 75);
  white_rook_img = loadImage("imgs\\white_rook.png");
  white_rook_img.resize(75, 75);
  white_knight_img = loadImage("imgs\\white_knight.png");
  white_knight_img.resize(75, 75);
  white_pawn_img = loadImage("imgs\\white_pawn.png");
  white_pawn_img.resize(75, 75);
  
  black_king_img = loadImage("imgs\\black_king.png");
  black_king_img.resize(75, 75);
  black_queen_img = loadImage("imgs\\black_queen.png");
  black_queen_img.resize(75, 75);
  black_bishop_img = loadImage("imgs\\black_bishop.png");
  black_bishop_img.resize(75, 75);
  black_rook_img = loadImage("imgs\\black_rook.png");
  black_rook_img.resize(75, 75);
  black_knight_img = loadImage("imgs\\black_knight.png");
  black_knight_img.resize(75, 75);
  black_pawn_img = loadImage("imgs\\black_pawn.png");
  black_pawn_img.resize(75, 75);
  
  white_taken_king_img = loadImage("imgs\\white_king.png");
  white_taken_king_img.resize(75, 75);
  white_taken_queen_img = loadImage("imgs\\white_queen.png");
  white_taken_queen_img.resize(75, 75);
  white_taken_bishop_img = loadImage("imgs\\white_bishop.png");
  white_taken_bishop_img.resize(75, 75);
  white_taken_rook_img = loadImage("imgs\\white_rook.png");
  white_taken_rook_img.resize(75, 75);
  white_taken_knight_img = loadImage("imgs\\white_knight.png");
  white_taken_knight_img.resize(75, 75);
  white_taken_pawn_img = loadImage("imgs\\white_pawn.png");
  white_taken_pawn_img.resize(75, 75);
  
  black_taken_king_img = loadImage("imgs\\black_king.png");
  black_taken_king_img.resize(75, 75);
  black_taken_queen_img = loadImage("imgs\\black_queen.png");
  black_taken_queen_img.resize(75, 75);
  black_taken_bishop_img = loadImage("imgs\\black_bishop.png");
  black_taken_bishop_img.resize(75, 75);
  black_taken_rook_img = loadImage("imgs\\black_rook.png");
  black_taken_rook_img.resize(75, 75);
  black_taken_knight_img = loadImage("imgs\\black_knight.png");
  black_taken_knight_img.resize(75, 75);
  black_taken_pawn_img = loadImage("imgs\\black_pawn.png");
  black_taken_pawn_img.resize(75, 75);
  
  resign_img = loadImage("imgs\\resign.png");
  resign_img.resize(30, 30);
  
  newGrid(whiteSide);
}

void draw()
{
  background(75, 75, 75);
  if (!mainScreen) {
    boolean check = inCheck(grid, whiteTurn);
    // System.out.println(check);
    if (check && whiteTurn) {
      System.out.println("White is in check");
    } else if (check && !whiteTurn) {
      System.out.println("Black is in check");
    }
    if (check) {
      if (inCheckMate(whiteTurn)) {
        checkMate = true;
        whiteCheckMate = whiteTurn;
        println("IN CHECKMATE");
      } else {
        println("NOT IN CHECKMATE");
      }
    }
    
    drawBoard();
    displayTaken();
    
    int white_tm_turn = white_time - ((millis() / 1000) - start);
    int black_tm_turn = black_time - ((millis() / 1000) - start);
    
    if (whiteTurn && white_tm_turn <= 0) {
      timeout = true;
    } else if (!whiteTurn && black_tm_turn <= 0) {
      timeout = true;
    }
    
    if (!timeout && !checkMate) {
      if (whiteTurn) {
        textAlign(CENTER);
        fill(255);
        textSize(30);
        int tm = (millis() / 1000) - start;
        String tmStr;
        if ((white_time - tm)%60 > 9)
          tmStr = "" + (white_time - tm)/60 + ":" + (white_time - tm)%60;
        else
          tmStr = "" + (white_time - tm)/60 + ":0" + (white_time - tm)%60;
        if (whiteSide)
          text(tmStr, widthy - 80, heighty - top_margin/3);
        else
          text(tmStr, widthy - 80, (top_margin/4)*3);
        
        textAlign(CENTER);
        fill(255);
        textSize(30);
        if (black_time%60 > 9)
          tmStr = "" + black_time/60 + ":" + black_time%60;
        else 
          tmStr = "" + black_time/60 + ":0" + black_time%60;
        if (whiteSide)
          text(tmStr, widthy - 80, (top_margin/4)*3);
        else
          text(tmStr, widthy - 80, heighty - top_margin/3);
        
      } else {
        textAlign(CENTER);
        fill(255);
        textSize(30);
        int tm = (millis() / 1000) - start;
        String tmStr;
        if ((black_time - tm)%60 > 9)
          tmStr = "" + (black_time - tm)/60 + ":" + (black_time - tm)%60;
        else
          tmStr = "" + (black_time - tm)/60 + ":0" + (black_time - tm)%60;
        if (whiteSide)
          text(tmStr, widthy - 80, (top_margin/4)*3);
        else
          text(tmStr, widthy - 80, heighty - top_margin/3);
        
        textAlign(CENTER);
        fill(255);
        textSize(30);
        if (white_time%60 > 9) 
          tmStr = "" + white_time/60 + ":" + white_time%60;
        else
          tmStr = "" + white_time/60 + ":0" + white_time%60;
        if (whiteSide)
          text(tmStr, widthy - 80, heighty - top_margin/3);
        else
          text(tmStr, widthy - 80, (top_margin/4)*3);
      }
      
      image(resign_img, widthy - 40, top_margin/4);
      image(resign_img, widthy - 40, heighty - (top_margin/5) * 4);
      
    }
    
    if (prompted) {
      noStroke();
      color c = color(0, 0, 0, 180);
      fill(c);
      rect(0, 0, widthy, heighty);
      
      noFill();
      stroke(255);
      strokeWeight(5);
      rect(widthy/2 - size, heighty/2 - size, size, size);
      rect(widthy/2, heighty/2 - size, size, size);
      rect(widthy/2 - size, heighty/2, size, size);
      rect(widthy/2, heighty/2, size, size);
      if (promptedWhite) {
        image(white_queen_img, widthy/2 - size, heighty/2 - size);
        image(white_rook_img, widthy/2, heighty/2 - size);
        image(white_bishop_img, widthy/2 - size, heighty/2);
        image(white_knight_img, widthy/2, heighty/2);
      } else {
        image(white_queen_img, widthy/2 - size, heighty/2 - size);
        image(white_rook_img, widthy/2, heighty/2 - size);
        image(white_bishop_img, widthy/2 - size, heighty/2);
        image(white_knight_img, widthy/2, heighty/2);
      }
      
    }
    
    if (checkMate) {
      noStroke();
      color c = color(0, 0, 0, 180);
      fill(c);
      rect(0, 0, widthy, heighty);
      String winText = "";
      if (whiteCheckMate) {
        winText = "Black wins by checkmate";
      } else {
        winText = "White wins by checkmate";
      }
      println(winText);
      fill(255);
      textSize(40);
      textAlign(CENTER);
      text(winText, widthy/2, heighty/2 - 30);
      textSize(20);
      text("[Press anywhere to go back to main menu]", widthy/2, heighty/2 + 10);
    }
    
    if (timeout) {
      noStroke();
      color c = color(0, 0, 0, 180);
      fill(c);
      rect(0, 0, widthy, heighty);
      String winText = "";
      if (!resigned) {
        if (whiteTurn) {
          winText = "Black wins by timeout";
        } else {
          winText = "White wins by timeout";
        }
      } else {
        winText = resignMessage;
      }
      println(winText);
      fill(255);
      textSize(40);
      textAlign(CENTER);
      text(winText, widthy/2, heighty/2 - 30);
      textSize(20);
      text("[Press anywhere to go back to main menu]", widthy/2, heighty/2 + 10);
    }
  } else {
    mainScreen();
  }
}

void mainScreen() {
  strokeWeight(0);
  for (int r = 0; r < grid.length; r++) {
    for (int c = 0; c < grid[r].length; c++) {
      if ((r + c) % 2 == 0) {
        fill(255);
      } else {
        fill(0, 150, 60);
      }
      rect(r * size, c * size + top_margin, size, size);
    }
  }
  
  if (movedYet) {
    fill(255, 234, 97);
    rect(oldSpot[0] * size, oldSpot[1] * size + top_margin, size, size);
    fill(255, 212, 0);
    rect(newSpot[0] * size, newSpot[1] * size + top_margin, size, size);
  }
  
  for (int r = 0; r < grid.length; r++) {
    for (int c = 0; c < grid[r].length; c++) {
      if (grid[r][c] != empty) {
        PImage ig = getImg(grid[r][c]);
        if (ig != null) {
          image(ig, r*size, c*size + top_margin);
        }
      }
    }
  }
  
  noStroke();
  color c = color(0, 0, 0, 200);
  fill(c);
  rect(0, 0, widthy, heighty);
  
  fill(220, 220, 255);
  textSize(50);
  textAlign(CENTER);
  text("Chess", width/2, height/2 - 210);
  
  //rect(widthy/2 - size, heighty/2 - size, size, size);
  //rect(widthy/2, heighty/2 - size, size, size);
  //rect(widthy/2 - size, heighty/2, size, size);
  //rect(widthy/2, heighty/2, size, size);
  
  noFill();
  stroke(220, 220, 255);
  strokeWeight(5);
  rect(widthy/2 - (2.5 * size), heighty/2 - (2 * size), size*2, size*2);
  fill(220, 220, 255);
  textSize(50);
  textAlign(CENTER);
  text("1:00", size*2.5, heighty/2 - (.75 * size));
  noFill();
  stroke(220, 220, 255);
  strokeWeight(5);
  rect(widthy/2 + size/2, height/2 - (2 * size), size*2, size*2);
  fill(220, 220, 255);
  textSize(50);
  textAlign(CENTER);
  text("3:00", width/2 + size*1.5, heighty/2 - (.75 * size));
  noFill();
  stroke(220, 220, 255);
  strokeWeight(5);
  rect(widthy/2 - (2.5 * size), heighty/2 + size, size*2, size*2);
  fill(220, 220, 255);
  textSize(50);
  textAlign(CENTER);
  text("5:00", size*2.5, heighty/2 + (2.25 * size));
  noFill();
  stroke(220, 220, 255);
  strokeWeight(5);
  rect(widthy/2 + size/2, heighty/2 + size, size*2, size*2);
  fill(220, 220, 255);
  textSize(50);
  textAlign(CENTER);
  text("10:00", width/2 + size*1.5, heighty/2 + (2.25 * size));
  
}

boolean inCheck(int[][] gri, boolean white) {
  for(int r = 0; r < gri.length; r++) {
    for (int c = 0; c < gri[r].length; c++) {
      if ((white && isWhite(new int[]{r, c}) == 1) || (!white && isWhite(new int[]{r, c}) == 0)) {
        ArrayList<int[]> arr = availableMoves(r, c);
        int[] king = getKing(grid, white);
        for (int[] p: arr) {
          if (p[0] == king[0] && p[1] == king[1]) {
            return true;
          }
        }
      }
    }
  }
  return false;
}

boolean inChecki(int[][] gri, boolean white) {
  for(int r = 0; r < gri.length; r++) {
    for (int c = 0; c < gri[r].length; c++) {
      if ((white && isWhite(new int[]{r, c}) == 1) || (!white && isWhite(new int[]{r, c}) == 0)) {
        ArrayList<int[]> arr = availableMoves(r, c);
        int[] king = getKing(grid, white);
        for (int[] p: arr) {
          if (p[0] == king[0] && p[1] == king[1]) {
            return true;
          }
        }
      }
    }
  }
  return false;
}

int[] getKing(int[][] gri, boolean white) {
  for(int r = 0; r < gri.length; r++) {
    for (int c = 0; c < gri[r].length; c++) {
      if ((white && gri[r][c] == white_king) || (!white && gri[r][c] == black_king)) {
        return new int[]{r, c};
      }
    }
  }
  return null;
}

boolean inCheckMate(boolean white) {
  
  int[] king = getKing(grid, white);
  ArrayList<int[]> aval = availableMoves(king[0], king[1]);
  for (int[] mov: aval) {
    int tempO = grid[king[0]][king[1]];
    int tempN = grid[mov[0]][mov[1]];
    grid[mov[0]][mov[1]] = tempO;
    grid[king[0]][king[1]] = empty;
    if (inCheck(grid, whiteTurn)) {
      grid[mov[0]][mov[1]] = tempN;
      grid[king[0]][king[1]] = tempO;
    } else {
      grid[mov[0]][mov[1]] = tempN;
      grid[king[0]][king[1]] = tempO;
      return false;
    }
  }
  
  for(int r = 0; r < grid.length; r++) {
    for (int c = 0; c < grid[r].length; c++) {
      if ((white && isWhite(new int[]{r, c}) == 0) || (!white && isWhite(new int[]{r, c}) == 1)) {
        ArrayList<int[]> arr = availableMoves(r, c);
        for (int[] p: arr) {
          int tempO = grid[r][c];
          int tempN = grid[p[0]][p[1]];
          grid[p[0]][p[1]] = tempO;
          grid[r][c] = empty;
          if (!inCheck(grid, white)) {
            grid[p[0]][p[1]] = tempN;
            grid[r][c] = tempO;
            return false;
          }
          grid[p[0]][p[1]] = tempN;
          grid[r][c] = tempO;
        }
      }
    }
  }
  
  return true;
}

void drawBoard() {
  strokeWeight(0);
  for (int r = 0; r < grid.length; r++) {
    for (int c = 0; c < grid[r].length; c++) {
      if ((r + c) % 2 == 0) {
        fill(255);
      } else {
        fill(0, 150, 60);
      }
      rect(r * size, c * size + top_margin, size, size);
    }
  }
  
  if (movedYet) {
    fill(255, 234, 97);
    rect(oldSpot[0] * size, oldSpot[1] * size + top_margin, size, size);
    fill(255, 212, 0);
    rect(newSpot[0] * size, newSpot[1] * size + top_margin, size, size);
  }
  
  for (int r = 0; r < grid.length; r++) {
    for (int c = 0; c < grid[r].length; c++) {
      if (grid[r][c] != empty) {
        PImage ig = getImg(grid[r][c]);
        if (ig != null) {
          image(ig, r*size, c*size + top_margin);
        }
      }
    }
  }
  
  if (selected) {
    noFill();
    stroke(50, 50, 50);
    strokeWeight(5);
    rect(selectedSquare[0] * size, selectedSquare[1] * size + top_margin, size, size);
    strokeWeight(0);
    color c = color(50, 50, 50, 150);
    fill(c);
    ArrayList<int[]> arrTemp = availableMoves(selectedSquare[0], selectedSquare[1]);
    if (grid[selectedSquare[0]][selectedSquare[1]] == white_king || grid[selectedSquare[0]][selectedSquare[1]] == black_king) {
      for (int[] pointTemp: getCastleMove(whiteTurn, selectedSquare[0], selectedSquare[1])) {
        arrTemp.add(pointTemp);
      }
    }
    
    for (int[] pa: arrTemp) {
      int tempO = grid[selectedSquare[0]][selectedSquare[1]];
      int tempN = grid[pa[0]][pa[1]];
      grid[pa[0]][pa[1]] = tempO;
      grid[selectedSquare[0]][selectedSquare[1]] = empty;
      if (!inCheck(grid, whiteTurn)) {
        circle(pa[0] * size + (.5 * size), pa[1] * size + (.5 * size) + top_margin, size/3);
      }
      grid[pa[0]][pa[1]] = tempN;
      grid[selectedSquare[0]][selectedSquare[1]] = tempO;
    }
  }
  
}

ArrayList<Integer> sortTaken(ArrayList<Integer> pieces) {
  ArrayList<Integer> new_pieces = new ArrayList<Integer>();
  for(int p: pieces) {
    if (p == white_queen || p == black_queen) {
      new_pieces.add(p);
    }
  }
  for(int p: pieces) {
    if (p == white_rook || p == black_rook) {
      new_pieces.add(p);
    }
  }
  for(int p: pieces) {
    if (p == white_knight || p == black_knight) {
      new_pieces.add(p);
    }
  }
  for(int p: pieces) {
    if (p == white_bishop || p == black_bishop) {
      new_pieces.add(p);
    }
  }
  for(int p: pieces) {
    if (p == white_pawn || p == black_pawn) {
      new_pieces.add(p);
    }
  }
  return new_pieces;
}

void displayTaken() {
  whiteTaken = sortTaken(whiteTaken);
  blackTaken = sortTaken(blackTaken);
  whiteTakenImgs.clear();
  blackTakenImgs.clear();
  for (int w: whiteTaken) {
    PImage tempImg = getTakenImg(w);
    tempImg.resize(25, 25);
    whiteTakenImgs.add(tempImg);
  }
  for (int b: blackTaken) {
    PImage tempImg = getTakenImg(b);
    tempImg.resize(25, 25);
    blackTakenImgs.add(tempImg);
  }
  
  if (whiteSide) {
    int i = 0;
    for (PImage img: blackTakenImgs) {
      image(img, i*(top_margin/2) + top_margin/4, top_margin/4);
      i++;
      
    }
    i = 0;
    for (PImage img: whiteTakenImgs) {
      image(img, i*(top_margin/2) + top_margin/4, top_margin/4 + (8 * size + top_margin));
      i++;
      
    }
  } else {
    int i = 0;
    for (PImage img: whiteTakenImgs) {
      image(img, i*(top_margin/2) + top_margin/4, top_margin/4);
      i++;
      
    }
    i = 0;
    for (PImage img: blackTakenImgs) {
      image(img, i*(top_margin/2) + top_margin/4, top_margin/4 + (8 * size + top_margin));
      i++;
      
    }
  }
}

void newGrid(boolean white) {
  grid = new int[8][8];
  
  for (int r = 0; r < grid.length; r++) {
    for (int c = 0; c < grid[r].length; c++) {
      grid[r][c] = empty;
    }
  }
  
  if (white) {
    grid[0][0] = black_rook;
    grid[1][0] = black_knight;
    grid[2][0] = black_bishop;
    grid[3][0] = black_queen;
    grid[4][0] = black_king;
    grid[5][0] = black_bishop;
    grid[6][0] = black_knight;
    grid[7][0] = black_rook;
    for (int i = 0; i < 8; i++) {
      grid[i][1] = black_pawn;
    }
    
    grid[0][7] = white_rook;
    grid[1][7] = white_knight;
    grid[2][7] = white_bishop;
    grid[3][7] = white_queen;
    grid[4][7] = white_king;
    grid[5][7] = white_bishop;
    grid[6][7] = white_knight;
    grid[7][7] = white_rook;
    for (int i = 0; i < 8; i++) {
      grid[i][6] = white_pawn;
    }
  } else {
    grid[0][0] = white_rook;
    grid[1][0] = white_knight;
    grid[2][0] = white_bishop;
    grid[3][0] = white_queen;
    grid[4][0] = white_king;
    grid[5][0] = white_bishop;
    grid[6][0] = white_knight;
    grid[7][0] = white_rook;
    for (int i = 0; i < 8; i++) {
      grid[i][1] = white_pawn;
    }
    
    grid[0][7] = black_rook;
    grid[1][7] = black_knight;
    grid[2][7] = black_bishop;
    grid[3][7] = black_queen;
    grid[4][7] = black_king;
    grid[5][7] = black_bishop;
    grid[6][7] = black_knight;
    grid[7][7] = black_rook;
    for (int i = 0; i < 8; i++) {
      grid[i][6] = black_pawn;
    }
  }
  
}

PImage getTakenImg(int p) {
  if (p == white_king) {
    return white_taken_king_img;
  } else if (p == white_queen) {
    return white_taken_queen_img;
  } else if (p == white_bishop) {
    return white_taken_bishop_img;
  } else if (p == white_rook) {
    return white_taken_rook_img;
  } else if (p == white_knight) {
    return white_taken_knight_img;
  } else if (p == white_pawn) {
    return white_taken_pawn_img;
  } else if (p == black_king) {
    return black_taken_king_img;
  } else if (p == black_queen) {
    return black_taken_queen_img;
  } else if (p == black_bishop) {
    return black_taken_bishop_img;
  } else if (p == black_rook) {
    return black_taken_rook_img;
  } else if (p == black_knight) {
    return black_taken_knight_img;
  } else if (p == black_pawn) {
    return black_taken_pawn_img;
  } else {
    return null;
  }
}

PImage getImg(int p) {
  if (p == white_king) {
    return white_king_img;
  } else if (p == white_queen) {
    return white_queen_img;
  } else if (p == white_bishop) {
    return white_bishop_img;
  } else if (p == white_rook) {
    return white_rook_img;
  } else if (p == white_knight) {
    return white_knight_img;
  } else if (p == white_pawn) {
    return white_pawn_img;
  } else if (p == black_king) {
    return black_king_img;
  } else if (p == black_queen) {
    return black_queen_img;
  } else if (p == black_bishop) {
    return black_bishop_img;
  } else if (p == black_rook) {
    return black_rook_img;
  } else if (p == black_knight) {
    return black_knight_img;
  } else if (p == black_pawn) {
    return black_pawn_img;
  } else {
    return null;
  }
}

boolean isValid(int[] p, boolean white) {
  if (p[0] < 0 || p[1] < 0 || p[0] > 7 || p[1] > 7) {
    return false;
  }
  boolean sameTurn = false;
  if (isWhite(p) == 0 && white) {
    sameTurn = true;
  } else if (isWhite(p) == 1 && !white) {
    sameTurn = true;
  }
  if (sameTurn) {
    return false;
  }
  return true;
}

int isWhite(int[] point) {
  if (grid[point[0]][point[1]] == white_king || grid[point[0]][point[1]] == white_queen || grid[point[0]][point[1]] == white_bishop || grid[point[0]][point[1]] == white_rook || grid[point[0]][point[1]] == white_knight || grid[point[0]][point[1]] == white_pawn) {
    return 0;
  } else if (grid[point[0]][point[1]] == black_king || grid[point[0]][point[1]] == black_queen || grid[point[0]][point[1]] == black_bishop || grid[point[0]][point[1]] == black_rook || grid[point[0]][point[1]] == black_knight || grid[point[0]][point[1]] == black_pawn) {
    return 1;
  }
  return 2;
}

ArrayList<int[]> availableMoves(int x, int y) {
  ArrayList<int[]> arrBef = new ArrayList<int[]>();
  int p = grid[x][y];
  boolean white = false;
  
  if (p == white_king || p == white_queen || p == white_bishop || p == white_rook || p == white_knight || p == white_pawn) {
    white = true;
  }
  
  if (p == white_king || p == black_king) {
    arrBef.add(new int[]{x, y-1});
    arrBef.add(new int[]{x, y+1});
    arrBef.add(new int[]{x-1, y});
    arrBef.add(new int[]{x+1, y});
    arrBef.add(new int[]{x-1, y-1});
    arrBef.add(new int[]{x-1, y+1});
    arrBef.add(new int[]{x+1, y+1});
    arrBef.add(new int[]{x+1, y-1});
  } else if (p == white_queen || p == black_queen || p == white_rook || p == black_rook) {
    for (int c = y-1; c >= 0; c--) {
      if (grid[x][c] != empty) {
        int isWhite = isWhite(new int[]{x, c});
        if (white && isWhite != 0) {
          arrBef.add(new int[]{x, c});
        } else if (!white && isWhite != 1) {
          arrBef.add(new int[]{x, c});
        }
        break;
      } else {
        arrBef.add(new int[]{x, c});
      }
    }
    for (int c = y+1; c <= 7; c++) {
      if (grid[x][c] != empty) {
        int isWhite = isWhite(new int[]{x, c});
        if (white && isWhite != 0) {
          arrBef.add(new int[]{x, c});
        } else if (!white && isWhite != 1) {
          arrBef.add(new int[]{x, c});
        }
        break;
      } else {
        arrBef.add(new int[]{x, c});
      }
    }
    for (int r = x+1; r <= 7; r++) {
      if (grid[r][y] != empty) {
        int isWhite = isWhite(new int[]{r, y});
        if (white && isWhite != 0) {
          arrBef.add(new int[]{r, y});
        } else if (!white && isWhite != 1) {
          arrBef.add(new int[]{r, y});
        }
        break;
      } else {
        arrBef.add(new int[]{r, y});
      }
    }
    for (int r = x-1; r >= 0; r--) {
      if (grid[r][y] != empty) {
        int isWhite = isWhite(new int[]{r, y});
        if (white && isWhite != 0) {
          arrBef.add(new int[]{r, y});
        } else if (!white && isWhite != 1) {
          arrBef.add(new int[]{r, y});
        }
        break;
      } else {
        arrBef.add(new int[]{r, y});
      }
    }
  }
  if (p == white_queen || p == black_queen || p == white_bishop || p == black_bishop) {
    // UpLeft Diagonal
    int rr = x-1;
    int cc = y-1;
    for(int i = 0; i < 8; i++) {
      if (isValid(new int[]{rr, cc}, white)) {
        if (grid[rr][cc] != empty) {
          int isWhite = isWhite(new int[]{rr, cc});
          if (white && isWhite != 0) {
            arrBef.add(new int[]{rr, cc});
          } else if (!white && isWhite != 1) {
            arrBef.add(new int[]{rr, cc});
          }
          break;
        } else {
          arrBef.add(new int[]{rr, cc});
        }
        rr--;
        cc--;
      }
    }
    // UpRight Diagonal
    rr = x+1;
    cc = y-1;
    for(int i = 0; i < 8; i++) {
      if (isValid(new int[]{rr, cc}, white)) {
        if (grid[rr][cc] != empty) {
          int isWhite = isWhite(new int[]{rr, cc});
          if (white && isWhite != 0) {
            arrBef.add(new int[]{rr, cc});
          } else if (!white && isWhite != 1) {
            arrBef.add(new int[]{rr, cc});
          }
          break;
        } else {
          arrBef.add(new int[]{rr, cc});
        }
        rr++;
        cc--;
      }
    }
    // BottomRight Diagonal
    rr = x+1;
    cc = y+1;
    for(int i = 0; i < 8; i++) {
      if (isValid(new int[]{rr, cc}, white)) {
        if (grid[rr][cc] != empty) {
          int isWhite = isWhite(new int[]{rr, cc});
          if (white && isWhite != 0) {
            arrBef.add(new int[]{rr, cc});
          } else if (!white && isWhite != 1) {
            arrBef.add(new int[]{rr, cc});
          }
          break;
        } else {
          arrBef.add(new int[]{rr, cc});
        }
        rr++;
        cc++;
      }
    }
    // BottomLeft Diagonal
    rr = x-1;
    cc = y+1;
    for(int i = 0; i < 8; i++) {
      if (isValid(new int[]{rr, cc}, white)) {
        if (grid[rr][cc] != empty) {
          int isWhite = isWhite(new int[]{rr, cc});
          if (white && isWhite != 0) {
            arrBef.add(new int[]{rr, cc});
          } else if (!white && isWhite != 1) {
            arrBef.add(new int[]{rr, cc});
          }
          break;
        } else {
          arrBef.add(new int[]{rr, cc});
        }
        rr--;
        cc++;
      }
    }
  } else if (p == white_knight || p == black_knight) {
    arrBef.add(new int[] {x-1, y-2});
    arrBef.add(new int[] {x+1, y-2});
    arrBef.add(new int[] {x+2, y-1});
    arrBef.add(new int[] {x+2, y+1});
    arrBef.add(new int[] {x-1, y+2});
    arrBef.add(new int[] {x+1, y+2});
    arrBef.add(new int[] {x-2, y+1});
    arrBef.add(new int[] {x-2, y-1});
  } else if (p == white_pawn) {
    if (whiteSide) {
      if (y > 0) {
        if (grid[x][y-1] == empty) {
          if (y == 6 && grid[x][y-2] == empty) {
            arrBef.add(new int[]{x, y-1});
            arrBef.add(new int[]{x, y-2});
          } else {
            arrBef.add(new int[]{x, y-1});
          }
        }
        if (x > 0) {
          if (isWhite(new int[]{x-1, y-1}) == 1) {
            arrBef.add(new int[]{x-1, y-1});
          }
        }
        if (x < 7) {
          if (isWhite(new int[]{x+1, y-1}) == 1) {
            arrBef.add(new int[]{x+1, y-1});
          }
        }
      } else {
        // Prompt for change pawn
      }
    } else {
      if (y < 7) {
        if (grid[x][y+1] == empty) {
          if (y == 1 && grid[x][y+2] == empty) {
            arrBef.add(new int[]{x, y+1});
            arrBef.add(new int[]{x, y+2});
          } else {
            arrBef.add(new int[]{x, y+1});
          }
        }
        if (x > 0) {
          if (isWhite(new int[]{x-1, y+1}) == 1) {
            arrBef.add(new int[]{x-1, y+1});
          }
        }
        if (x < 7) {
          if (isWhite(new int[]{x+1, y+1}) == 1) {
            arrBef.add(new int[]{x+1, y+1});
          }
        }
      } else {
        // Prompt for change pawn
      }
    }
  } else if (p == black_pawn) {
    if (whiteSide) {
      if (y < 7) {
        if (grid[x][y+1] == empty) {
          if (y == 1 && grid[x][y+2] == empty) {
            arrBef.add(new int[]{x, y+1});
            arrBef.add(new int[]{x, y+2});
          } else {
            arrBef.add(new int[]{x, y+1});
          }
        }
        if (x > 0) {
          if (isWhite(new int[]{x-1, y+1}) == 0) {
            arrBef.add(new int[]{x-1, y+1});
          }
        }
        if (x < 7) {
          if (isWhite(new int[]{x+1, y+1}) == 0) {
            arrBef.add(new int[]{x+1, y+1});
          }
        }
      } else {
        // Prompt for change pawn
      }
    } else {
      if (y > 0) {
        if (grid[x][y-1] == empty) {
          if (y == 6 && grid[x][y-2] == empty) {
            arrBef.add(new int[]{x, y-1});
            arrBef.add(new int[]{x, y-2});
          } else {
            arrBef.add(new int[]{x, y-1});
          }
        }
        if (x > 0) {
          if (isWhite(new int[]{x-1, y-1}) == 0) {
            arrBef.add(new int[]{x-1, y-1});
          }
        }
        if (x < 7) {
          if (isWhite(new int[]{x+1, y-1}) == 0) {
            arrBef.add(new int[]{x+1, y-1});
          }
        }
      } else {
        // Prompt for change pawn
      }
    }
  }
  
  ArrayList<int[]> arr = new ArrayList<int[]>();
  
  for (int[] point: arrBef) {
    if (isValid(point, white)) {
      arr.add(point);
    }
  }
  
  return arr;
}

ArrayList<int[]> getCastleMove(boolean white, int x, int y) {
  ArrayList<int[]> arrBef = new ArrayList<int[]>();
  if (white && !whiteKingMoved && !inChecki(grid, white)) {
    try {
      if (grid[x-3][y] == white_rook && grid[x-2][y] == empty && grid[x-1][y] == empty) {
        arrBef.add(new int[]{x-2, y});
      }
    } catch (Exception ArrayIndexOutOfBoundsException) {
      ;
    }
    try {
      if (grid[x-4][y] == white_rook && grid[x-3][y] == empty && grid[x-2][y] == empty && grid[x-1][y] == empty) {
        arrBef.add(new int[]{x-2, y});
      }
    } catch (Exception ArrayIndexOutOfBoundsException) {
      ;
    }
    try {
      if (grid[x+3][y] == white_rook && grid[x+2][y] == empty && grid[x+1][y] == empty) {
        arrBef.add(new int[]{x+2, y});
      }
    } catch (Exception ArrayIndexOutOfBoundsException) {
      ;
    }
    try {
      if (grid[x+4][y] == white_rook && grid[x+3][y] == empty && grid[x+2][y] == empty && grid[x+1][y] == empty) {
        arrBef.add(new int[]{x+2, y});
      }
    } catch (Exception ArrayIndexOutOfBoundsException) {
      ;
    }
  } else if (!white && !blackKingMoved && !inChecki(grid, white)) {
    try {
      if (grid[x-3][y] == black_rook && grid[x-2][y] == empty && grid[x-1][y] == empty) {
        arrBef.add(new int[]{x-2, y});
      }
    } catch (Exception ArrayIndexOutOfBoundsException) {
      ;
    }
    try {
      if (grid[x-4][y] == black_rook && grid[x-3][y] == empty && grid[x-2][y] == empty && grid[x-1][y] == empty) {
        arrBef.add(new int[]{x-2, y});
      }
    } catch (Exception ArrayIndexOutOfBoundsException) {
      ;
    }
    try {
      if (grid[x+3][y] == black_rook && grid[x+2][y] == empty && grid[x+1][y] == empty) {
        arrBef.add(new int[]{x+2, y});
      }
    } catch (Exception ArrayIndexOutOfBoundsException) {
      ;
    }
    try {
      if (grid[x+4][y] == black_rook && grid[x+3][y] == empty && grid[x+2][y] == empty && grid[x+1][y] == empty) {
        arrBef.add(new int[]{x+2, y});
      }
    } catch (Exception ArrayIndexOutOfBoundsException) {
      ;
    }
  }
  return arrBef;
}

int getColSquare(int r, int c) {
  if ((r + c) % 2 != 0) {
    return 1;
  } else {
    return 0;
  }
}

void move(int[] op, int[] np) {
  ArrayList<int[]> arr = availableMoves(op[0], op[1]);
    if (grid[op[0]][op[1]] == white_king || grid[op[0]][op[1]] == black_king) {
      for (int[] pointTemp: getCastleMove(whiteTurn, selectedSquare[0], selectedSquare[1])) {
        arr.add(pointTemp);
      }
    }
  // ArrayList<int[]> arrTemp = getCastleMove(whiteTurn, 
  boolean contains = false;
  for (int[] p: arr) {
    if (p[0] == np[0] && p[1] == np[1]) {
      contains = true;
      break;
    }
  }
  if (contains) {
    
    boolean taking = false;
    if (isWhite(np) == 1 && whiteTurn) {
      taking = true;
      println("White is taking");
    } else if (isWhite(np) == 0 && !whiteTurn) {
      taking = true;
      println("Black is taking");
    }
    
    int tempO = grid[op[0]][op[1]];
    int tempN = grid[np[0]][np[1]];
    grid[np[0]][np[1]] = tempO;
    grid[op[0]][op[1]] = empty;
    if (inCheck(grid, whiteTurn)) {
      println("MOVED INTO CHECK");
      noFill();
      stroke(200, 0, 0);
      strokeWeight(5);
      rect(np[0] * size, np[1] * size + top_margin, size, size);
      grid[np[0]][np[1]] = tempN;
      grid[op[0]][op[1]] = tempO;
    } else {
      oldSpot[0] = op[0];
      oldSpot[1] = op[1];
      newSpot[0] = np[0];
      newSpot[1] = np[1];
      movedYet = true;
      
      if (whiteTurn && grid[np[0]][np[1]] == white_pawn) {
        if (whiteSide && np[1] == 0) {
          promptSpot[0] = np[0];
          promptSpot[1] = np[1];
          prompted = true;
          println("PROMPT FOR A QUEEN");
        } else if (!whiteSide && np[1] == 7) {
          promptSpot[0] = np[0];
          promptSpot[1] = np[1];
          prompted = true;
          println("PROMPT FOR A QUEEN");
        }
        promptedWhite = true;
      }
      if (!whiteTurn && grid[np[0]][np[1]] == black_pawn) {
        if (whiteSide && np[1] == 7) {
          promptSpot[0] = np[0];
          promptSpot[1] = np[1];
          prompted = true;
          println("PROMPT FOR A QUEEN");
        } else if (!whiteSide && np[1] == 0) {
          promptSpot[0] = np[0];
          promptSpot[1] = np[1];
          prompted = true;
          println("PROMPT FOR A QUEEN");
        }
        promptedWhite = false;
      }
      
      if (grid[np[0]][np[1]] == white_king && (np[0] == op[0]-2 || np[0] == op[0]+2)) {
        println("CASTLING");
        int[] rookSpot = new int[2];
        if (np[0] > op[0]) {
          if (grid[np[0] + 1][np[1]] == white_rook) {
            rookSpot[0] = np[0] + 1;
            rookSpot[1] = np[1];
          } else if (grid[np[0] + 2][np[1]] == white_rook) {
            rookSpot[0] = np[0] + 2;
            rookSpot[1] = np[1];
          }
          grid[np[0]-1][np[1]] = white_rook;
        } else {
          if (grid[np[0] - 1][np[1]] == white_rook) {
            rookSpot[0] = np[0] - 1;
            rookSpot[1] = np[1];
          } else if (grid[np[0] - 2][np[1]] == white_rook) {
            rookSpot[0] = np[0] - 2;
            rookSpot[1] = np[1];
          }
          grid[np[0]+1][np[1]] = white_rook;
        }
        
        grid[rookSpot[0]][rookSpot[1]] = empty;
      }
      
      if (grid[np[0]][np[1]] == black_king && (np[0] == op[0]-2 || np[0] == op[0]+2)) {
        println("CASTLING");
        int[] rookSpot = new int[2];
        if (np[0] > op[0]) {
          if (grid[np[0] + 1][np[1]] == black_rook) {
            rookSpot[0] = np[0] + 1;
            rookSpot[1] = np[1];
          } else if (grid[np[0] + 2][np[1]] == black_rook) {
            rookSpot[0] = np[0] + 2;
            rookSpot[1] = np[1];
          }
          grid[np[0]-1][np[1]] = black_rook;
        } else {
          if (grid[np[0] - 1][np[1]] == black_rook) {
            rookSpot[0] = np[0] - 1;
            rookSpot[1] = np[1];
          } else if (grid[np[0] - 2][np[1]] == black_rook) {
            rookSpot[0] = np[0] - 2;
            rookSpot[1] = np[1];
          }
          grid[np[0]+1][np[1]] = black_rook;
        }
        
        grid[rookSpot[0]][rookSpot[1]] = empty;
      }
      
      if (whiteTurn) {
        if (taking) {
          whiteTaken.add(tempN);
        }
        if (grid[np[0]][np[1]] == white_king) {
          println("Moved White King");
          whiteKingMoved = true;
        }
        whiteTurn = false;
        white_time -= (millis() / 1000) - start;
        start = (millis() / 1000);
      } else {
        if (taking) {
            blackTaken.add(tempN);
        }
        if (grid[np[0]][np[1]] == black_king) {
          println("Moved Black King");
          blackKingMoved = true;
        }
        whiteTurn = true;
        black_time -= (millis() / 1000) - start;
        start = (millis() / 1000);
      }
    }
  } else {
    selected = false;
  }
}

void mReleased() {
  int[] temp = new int[2];
  temp[0] = mouseX / size;
  temp[1] = (mouseY - top_margin) / size;
  if (temp[0] >= 0 && temp[0] <= 7 && temp[1] >= 0 && temp[1] <= 7) {
    int white = isWhite(temp);
    boolean sameTurn = false;
    if (isWhite(selectedSquare) == 0 && whiteTurn) {
      sameTurn = true;
    } else if (isWhite(selectedSquare) == 1 && !whiteTurn) {
      sameTurn = true;
    }
    if ((whiteTurn && white == 0) || (!whiteTurn && white == 1)) {
      if(!selected || sameTurn) {
        selectedSquare[0] = mouseX / size;
        selectedSquare[1] = (mouseY - top_margin) / size;
        if (grid[selectedSquare[0]][selectedSquare[1]] == empty) {
          selected = false;
        } else {
          selected = true;
        }
      }
    } else {
      move(selectedSquare, temp);
      selectedSquare = new int[2];
      selected = false;
    }
  
  }
}

void mousePressed() {
  if (!mainScreen) {
    if (!prompted) {
      image(resign_img, widthy - 40, top_margin/4);
      image(resign_img, widthy - 40, heighty - (top_margin/5) * 4);
      if (mouseX >= widthy-40 && mouseX <= widthy - 10) {
        if (mouseY >= top_margin/4 && mouseY <= top_margin/4 + 30) {
          if (whiteSide) {
            resignMessage = "Black has resigned";
          }
          else {
            resignMessage = "White has resigned";
          }
          resigned = true;
        } else if (mouseY >= heighty - (top_margin/5) * 4 && mouseY <= (heighty - (top_margin/5) * 4) + 30) {
          if (whiteSide) {
            resignMessage = "White has resigned";
          }
          else {
            resignMessage = "Black has resigned";
          }
          resigned = true;
        }
      }
      if (!checkMate && !timeout) {
        if (mouseY > top_margin)
          mReleased();
      } else {
        mainScreen = true;
      }
    } else {
      rect(widthy/2 - size, heighty/2 - size, size, size);
      rect(widthy/2, heighty/2 - size, size, size);
      rect(widthy/2 - size, heighty/2, size, size);
      rect(widthy/2, heighty/2, size, size);
      if (promptedWhite) {
        if (mouseX >= widthy/2 - size && mouseX <= widthy/2 && mouseY >= heighty/2 - size && mouseY <= heighty/2) {
          grid[promptSpot[0]][promptSpot[1]] = white_queen;
        } else if (mouseX >= widthy/2 && mouseX <= widthy/2 + size && mouseY >= heighty/2 - size && mouseY <= heighty/2) {
          grid[promptSpot[0]][promptSpot[1]] = white_rook;
        } else if (mouseX >= widthy/2 - size && mouseX <= widthy/2  && mouseY >= heighty/2 && mouseY <= heighty/2 + size) {
          grid[promptSpot[0]][promptSpot[1]] = white_bishop;
        } else if (mouseX >= widthy/2 && mouseX <= widthy/2 + size && mouseY >= heighty/2 && mouseY <= heighty/2 + size) {
          grid[promptSpot[0]][promptSpot[1]] = white_knight;
        }
      } else if (!promptedWhite) {
        if (mouseX >= widthy/2 - size && mouseX <= widthy/2 && mouseY >= heighty/2 - size && mouseY <= heighty/2) {
          grid[promptSpot[0]][promptSpot[1]] = black_queen;
        } else if (mouseX >= widthy/2 && mouseX <= widthy/2 + size && mouseY >= heighty/2 - size && mouseY <= heighty/2) {
          grid[promptSpot[0]][promptSpot[1]] = black_rook;
        } else if (mouseX >= widthy/2 - size && mouseX <= widthy/2  && mouseY >= heighty/2 && mouseY <= heighty/2 + size) {
          grid[promptSpot[0]][promptSpot[1]] = black_bishop;
        } else if (mouseX >= widthy/2 && mouseX <= widthy/2 + size && mouseY >= heighty/2 && mouseY <= heighty/2 + size) {
          grid[promptSpot[0]][promptSpot[1]] = black_knight;
        }
      }
      
      if (mouseX >= widthy/2 - size && mouseX <= widthy/2 + size && mouseY >= heighty/2 - size && mouseY <= heighty/2 + size) {
        prompted = false;
        promptedWhite = false;
        promptSpot = new int[2];
      }
    }
  } else {
    boolean sel = false;
    if (mouseX >= widthy/2 - (2.5 * size) && mouseX <= widthy/2 - (size * .5)) {
      if (mouseY >= heighty/2 - (2 * size) && mouseY <= heighty/2) {
        sel = true;
        timeMode = 60;
        println("1:00");
      }
      if (mouseY >= heighty/2 + size && mouseY <= heighty/2 + (3 * size)) {
        sel = true;
        timeMode = 300;
        println("5:00");
      }
    }
    if (mouseX >= widthy/2 + (size * .5) && mouseX <= widthy/2 + (size * 2.5)) {
      if (mouseY >= heighty/2 - (2 * size) && mouseY <= heighty/2) {
        sel = true;
        timeMode = 180;
        println("3:00");
      }
      if (mouseY >= heighty/2 + size && mouseY <= heighty/2 + (3 * size)) {
        sel = true;
        timeMode = 600;
        println("10:00");
      }
    }
    if (sel) {
      mainScreen = false;
      resignMessage = "";
      resigned = false;
      whiteKingMoved = false;
      blackKingMoved = false;
      newGrid(whiteSide);
      checkMate = false;
      timeout = false;
      white_time = timeMode;
      black_time = timeMode;
      start = (millis() / 1000);
      oldSpot = new int[2];
      newSpot = new int[2];
      movedYet = false;
      whiteTurn = true;
      whiteTaken = new ArrayList<Integer>();
      whiteTakenImgs = new ArrayList<PImage>();
      blackTaken = new ArrayList<Integer>();
      blackTakenImgs = new ArrayList<PImage>();
    }
  }
  if (resigned) {
    timeout = true;
  }
}
