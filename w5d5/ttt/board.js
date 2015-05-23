function Board () {
  this.grid = [Array(3), Array(3), Array(3)];
}

Board.prototype.diagonal = function () {
  if (this.grid[0][0] === this.grid[1][1] && this.grid[1][1] === this.grid[2][2] ||
      this.grid[0][2] === this.grid[1][1] && this.grid[1][1] === this.grid[2][0]) {
      if (grid[1][1] === undefined) {
        return false;
      } else {
        return true;
      }
  } else {
    return false;
  }
};

Board.prototype.empty = function(cell) {
  if (this.grid[cell[1]][cell[0]] === undefined) {
    return true;
  } else {
    return false;
  }
};

Board.prototype.gameOver = function () {
  if (this.diagonal() || this.horizontal() || this.vertical()) {
    return true;
  } else {
    return false;
  }
};

Board.prototype.horizontal = function () {
  this.grid.forEach(function (row) {
    var flag = true;

    row.forEach(function (el) {
      if (el !== row[0]) {
        flag = false;
      }
    });

    if (flag) {
      if (row[0] !== undefined) {
        return true;
      }
    }
  });

  return false;
};

Board.prototype.placeMark = function (mark, cell) {
  if (this.empty(cell)) {
    this.grid[cell[1]][cell[0]] = mark;
    return true;
  } else {
    return false;
  }
};

Board.prototype.print = function () {
  this.grid.forEach(function(el){
    console.log(JSON.stringify(el));
  });
};

Board.prototype.vertical = function () {
  var col = 0;

  while (col < 3) {
    var flag = true;

    for (var i = 0; i < 3; i++) {
      if (this.grid[0][col] !== this.grid[i][col]) {
        flag = false;
      }
    }

    if (flag) {
      if (this.grid[0][col] !== undefined) {
        return true;
      }
    }

    col++;
  }

  return false;
};

module.exports = Board;
