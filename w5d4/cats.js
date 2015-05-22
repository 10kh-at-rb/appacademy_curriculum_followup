function Cat(name, owner) {
  this.name = name;
  this.owner = owner;
}

Cat.prototype.cuteStatement = function() {
  return this.owner + " loves " + this.name;
};

var sunny = new Cat("Sunny", "Austin");

console.log(sunny.cuteStatement());

Cat.prototype.cuteStatement = function() {
  return "Everyone loves " + this.name;
};

Cat.prototype.meow = function() {
  return "meow";
};

console.log(sunny.meow());

var tl = new Cat("T.L.", "Austin");

tl.meow = function() {
  return "Bark, I'ma Dawg.";
};

console.log(tl.meow());
console.log(sunny.meow());
