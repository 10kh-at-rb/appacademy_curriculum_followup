var sum = function () {
  var result = 0;
  for (var i = 0; i < arguments.length; i++) {
    result += arguments[i];
  }
  return result;
};

//console.log(sum(1, 2, 3, 4));
//console.log(sum(1,2,3,4,5));

Function.prototype.myBind = function (context) {
  var fn = this;
  var args = Array.prototype.slice.call(arguments).slice(1);
  return function () {
    var args2 = Array.prototype.slice.call(arguments);
    return fn.apply(context, args.concat(args2));
  };
};


// var myObj = {
//   startingVal: 10,
//
//   myFunction: function (a, b, c) {
//     console.log(this.startingVal + a + b + c);
//   }
// };
//
// var myBoundFunction = (myObj.myFunction).myBind(myObj, 1, 2);
// myBoundFunction(3);
// myObj.myFunction(1, 2, 3);

var curriedSum = function (numArgs) {
  var numbers = [];
  var _curriedSum = function (num) {
    numbers.push(num);

    if (numbers.length === numArgs) {
      var sum = 0;

      numbers.forEach(function (el) {
        sum += el;
      });
a
      return sum;
    } else {
      return _curriedSum;
    }
  };

  return _curriedSum;
};

//var sum = curriedSum(4);
//console.log(sum(5)(30)(20)(1));

Function.prototype.curry = function (numArgs) {
  var args = [];
  var that = this;
  var _curry = function () {
    args = args.concat(Array.prototype.slice.call(arguments));

    if (args.length === numArgs){
      return that.apply("poopsicle", args);
    } else {
      return _curry;
    }
  };

  return _curry;
};

function sumThree(num1, num2, num3) {
  return num1 + num2 + num3;
}

sumThree(4, 20, 6); // == 30

// you'll write `Function#curry`!
var f1 = sumThree.curry(3);
var f2 = f1(4);
var f3 = f2(20);
var result = f3(6); // = 30
console.log(result);

// or more briefly:
console.log(sumThree.curry(3)(4)(20)(6)); // == 30
