var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function HanoiGame () {
  this.stacks = [[3, 2, 1], [], []];
}

HanoiGame.prototype.isWon = function () {
  if (this.stacks[1].length === 3 || this.stacks[2].length === 3) {
    return true;
  } else {
    return false;
  }
};

HanoiGame.prototype.isValidMove = function (startIdx, endIdx) {
  var startStack = this.stacks[startIdx];
  var endStack = this.stacks[endIdx];

  if ( endStack.length === 0 ||
       startStack[startStack.length - 1] < endStack[endStack.length -1]) {
    return true;
  } else {
    return false;
  }
};

HanoiGame.prototype.move = function (startIdx, endIdx) {
  var startStack = this.stacks[startIdx];
  var endStack = this.stacks[endIdx];

  if (this.isValidMove(startIdx, endIdx)) {
    endStack.push(startStack.pop());
    return true;
  }

  return false;
};

HanoiGame.prototype.print = function () {
  var that = this;
  console.log(JSON.stringify(that.stacks));
};

HanoiGame.prototype.promptMove = function (callback) {
  var startIdx = null;
  var endIdx = null;

  this.print();

  reader.question("From: ", function (answer) {
    startIdx = answer;

    reader.question("To: ", function (answer) {
      endIdx = answer;

      callback(startIdx, endIdx);
    });
  });
};

HanoiGame.prototype.run = function (completionCallback) {
  var that = this;
  that.promptMove(function (startIdx, endIdx) {
    if (that.move(startIdx, endIdx)) {
      if (that.isWon()) {
        console.log("You won!");
        completionCallback();
      } else {
        that.run(completionCallback);
      }
    } else {
      console.log("Something went wrong! Move failed.");
    }
  });
};

var hanoiGame = new HanoiGame();

hanoiGame.run(function () {
  reader.close();
});
