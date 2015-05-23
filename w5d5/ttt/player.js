function Player(name) {
  this.name = name;
}

Player.prototype.promptForMove = function (reader) {
  reader.question("Pick your cell, b-yatch!", function (answer) {
    return answer.split(",").map(function (el) {parseInt(el);});
  });
};

module.exports = Player;
