var TTT = require('../ttt');
var Player = require('./player.js');
var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var austin = new Player("Austin");
var carl = new Player("Carl");

var game = new TTT.Game(reader, austin, carl);

game.run(function () {
  reader.close();
});
