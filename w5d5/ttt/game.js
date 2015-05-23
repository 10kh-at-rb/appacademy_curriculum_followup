var Board = require('./board.js');

function Game (reader, player1, player2) {
  this.player1 = player1;
  this.player2 = player2;
  this.player1.mark = "x";
  this.player2.mark = "o";
  this.currentPlayer = player1;
  this.board = new Board();
  this.reader = reader;
}

Game.prototype.flip = function (curPlayer) {
  this.currentPlayer = curPlayer === this.player1 ? this.player2 : this.player1;
};

Game.prototype.isWon = function () {
  if (this.board.gameOver) {
    return true;
  } else {
    return false;
  }
};

Game.prototype.placeMark = function (mark, cell) {
  if (this.board.empty(cell)) {
    this.board.placeMark(mark, cell);
    return true;
  } else {
    return false;
  }
};

Game.prototype.round = function (currentPlayer) {
  var that = this;

  var cell = currentPlayer.promptForMove(this.reader);

  if (that.placeMark(currentPlayer.mark, cell)) {
    return true;
  } else {
    return false;
  }
};

Game.prototype.run = function (completionCallback) {
  var that = this;

  if (that.isWon) {
    console.log("Game over!");
    completionCallback();
  } else {
    that.round(this.currentPlayer);
    that.flip(this.currentPlayer);

    that.run(completionCallback);
  }
};

module.exports = Game;
