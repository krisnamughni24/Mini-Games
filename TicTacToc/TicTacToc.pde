//inisialisasi variabel
int rows = 3;
int cols = 3;
int cellSize = 100;
int[][] board = new int[rows][cols];
int currentPlayer = 1;
boolean gameOver = false;

void setup() {
  size(300, 300); // mengatur ukuran jendela aplikasi
}

void draw() {
  background(255);
  //menggambar kotak pada setiap cell
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      fill(255);
      rect(j * cellSize, i * cellSize, cellSize, cellSize);
      
      //menandai kotak yang sudah diisi oleh pemain
      if (board[i][j] != 0) {
        fill(board[i][j] == 1 ? color(0, 0, 255) : color(255, 0, 0));
        ellipse(j * cellSize + cellSize/2, i * cellSize + cellSize/2, cellSize/2, cellSize/2);
      }
    }
  }
  
  //mengecek kondisi gameover
  int winner = checkWinner();
  if (winner != 0 || isBoardFull()) {
    gameOver = true;
    String message = winner != 0 ? "Player " + winner + " wins!" : "It's a tie!";
    textSize(32);
    textAlign(CENTER);
    fill(0);
    text(message, width/2, height/2);
  }
}

//mengecek apakah board sudah penuh
boolean isBoardFull() {
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      if (board[i][j] == 0) {
        return false;
      }
    }
  }
  return true;
}

//mengecek pemenang
int checkWinner() {
  for (int i = 0; i < rows; i++) {
    //mengecek horizontal
    if (board[i][0] != 0 && board[i][0] == board[i][1] && board[i][0] == board[i][2]) {
      return board[i][0];
    }
    
    //mengecek vertikal
    if (board[0][i] != 0 && board[0][i] == board[1][i] && board[0][i] == board[2][i]) {
      return board[0][i];
    }
  }
  
  //mengecek diagonal
  if (board[0][0] != 0 && board[0][0] == board[1][1] && board[0][0] == board[2][2]) {
    return board[0][0];
  }
  if (board[2][0] != 0 && board[2][0] == board[1][1] && board[2][0] == board[0][2]) {
    return board[2][0];
  }
  
  return 0;
}

//memainkan game
void mousePressed() {
  if (!gameOver) {
    int row = floor(mouseY / cellSize);
    int col = floor(mouseX / cellSize);
    
    if (board[row][col] == 0) {
      board[row][col] = currentPlayer;
      currentPlayer = currentPlayer == 1 ? 2 : 1;
    }
  }
}

//mengatur ulang board untuk game baru
void keyPressed() {
  if (gameOver && key == ' ') {
    board = new int[rows][cols];
    currentPlayer = 1;
    gameOver = false;
  }
}
