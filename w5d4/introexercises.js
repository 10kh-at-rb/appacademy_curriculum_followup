var uniq = function (array) {
  var uniqNumbers = [];
  for(var i = 0; i < array.length; i++) {
    var found = false;
    for(var a = 0; a < uniqNumbers.length; a++) {
      if (array[i] === uniqNumbers[a]) {
        found = true;
      }
    }
    if (!found) {
      uniqNumbers.push(array[i]);
    }
  }

  console.log(uniqNumbers);
};

// uniq([3, 5, 1, 2, 7, 3, 3, 4, 4]);

var twoSum = function (array) {
  var pairs = [];
  for(var i = 0; i < array.length; i++) {
    for(var j = i; j < array.length; j++) {
      if (array[i] + array[j] === 0) {
        pairs.push([i, j]);
      }
    }
  }

  console.log(pairs);
};


// twoSum([3, -3, 1, -7, 18, 9241412])


var transpose = function (array) {

  var answerArray = [];
  for (var counter = 0; counter < array[0].length; counter++) {
    var subArray = [];
    for (var i = 0; i < array.length; i++) {
      subArray.push(array[i][counter]);
    }
    answerArray.push(subArray);
  }

  console.log(answerArray);
};

// transpose([[1, 2, 3], [4, 5, 6], [7, 8, 9]])

Array.prototype.myEach = function(func) {
  for (var i = 0; i < this.length; i++) {
    func(this[i]);
  }
};

Array.prototype.myMap = function(func) {
  this.myEach(func);
};

// NO MEMO NEEDED
Array.prototype.myInject = function(func, memo) {
  memo = memo || this[0];
  for (var i = 0; i < this.length; i++) {
    memo = func(memo, this[i]);
  }
  console.log(memo);
};

var bubbleSort = function (array) {
  var sorted = false;
  while (!sorted) {
    sorted = true;
    for (var i = 0; i < array.length - 1; i++) {
      if (array[i] > array[i+1]) {
        var temp = array[i + 1];
        array[i+1] = array[i];
        array[i] = temp;
        sorted = false;
      }
    }
  }

  console.log(array);
};

var subStrings = function (string) {
  var final = [];
  for (var i = 0; i<string.length; i++) {
    for (var j = i + 1; j < string.length + 1; j++) {
      final.push(string.slice(i, j));
    }
  }

  console.log(final);
};


var range = function (start, end) {
  if (end - start === 0) {
    return [end];
  } else {
    var array = [start];
    return array.concat(range(start + 1, end));
  }
};


var recSum = function (array) {
  if (array.length === 1) {
    return array[0];
  } else {
    return array[0] + recSum(array.slice(1));
  }
};

var iterSum = function (array) {
  var sum = 0;
  for (var i = 0; i < array.length; i++) {
    sum += array[i];
  }

  return sum;
};

var recPow1 = function (base, n) {
  if (n === 0) {
    return 1;
  } else {
    return base * (recPow1(base, n-1));
  }
};

var recPow2 = function (base, n) {
  if (n === 0) {
    return 1;
  } else if (n === 1) {
    return base;
  } else if (n % 2 === 0) {
    return recPow2(base, n/2) * recPow2(base, n/2);
  } else {
    return base * recPow2(base, n/2) * recPow2(base, n/2);
  }
};

var iterFib = function (n) {
  var a = 0, b = 1;
  var fibNums = [];
  while (fibNums.length < n) {
    fibNums.push(a);
    var temp = a;
    a = b;
    b = temp + b;
  }

  return fibNums;
};

var recFib = function (n) {
  if (n === 1) {
    return [0];
  } else if (n === 2) {
    return [0, 1];
  } else {
    var fibArray = recFib(n - 1);
    return fibArray.concat(fibArray[fibArray.length - 2] + fibArray[fibArray.length - 1]);
  }
};

var bsearch = function (array, target) {
  var midpoint = Math.floor(array.length/2);

  if (array.length === 0) {
    return "not found";
  } else if (array[midpoint] === target) {
    return midpoint;
  } else if (array[midpoint] > target) {
    return bsearch(array.slice(0, midpoint), target);
  } else {
    var temp = bsearch(array.slice(midpoint+1), target);
    if (temp === "not found") {
      return temp;
    }
    return midpoint + 1 + temp;
  }
};

var makeChange = function (money, coins) {
  var change = [];
  var biggestCoin = coins[0];

  if (money === 0) {
    return [];
  } else {
    while (money - biggestCoin >= 0) {
      change.push(biggestCoin);
      money -= biggestCoin;
    }
  }

  return change.concat(makeChange(money, coins.slice(1)));
};

var merge = function (leftArray, rightArray) {
  var merged = [];
  while (leftArray.length !== 0 && rightArray.length !== 0 ) {
    if (leftArray[0] > rightArray[0]) {
      merged.push(rightArray.shift());
    } else {
      merged.push(leftArray.shift());
    }
  }

  return merged.concat(leftArray).concat(rightArray);
};

var mergeSort = function (array) {
  var midpoint = Math.floor(array.length/2);
  if (array.length === 1) {
    return array;
  }

  return merge(mergeSort(array.slice(0, midpoint)), mergeSort(array.slice(midpoint)));
};
