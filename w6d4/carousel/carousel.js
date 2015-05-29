$.Carousel = function(el) {
  this.$el = $(el);
  this.activeIdx = 0;
  this.transitioning = false;

  console.log(this.$el.find('.slide-right'));
  this.$el.find('.slide-right').on('click', this.slideRight.bind(this));
  this.$el.find('.slide-left').on('click', this.slideLeft.bind(this));
};

$.Carousel.prototype.slideLeft = function(event) {
  // event.preventDefault();

  this.slide(1);
};

$.Carousel.prototype.slideRight = function(event) {
  // event.preventDefault();

  this.slide(-1);
};

$.Carousel.prototype.slide = function(dir) {
  if (this.transitioning) { return; }
  this.transitioning = true;
  var carousel = this;
  var exitDir = (dir === 1) ? 'left' : 'right';
  var enterDir = (dir !== 1) ? 'left' : 'right';
  var leavingItem = carousel.activeItem();

  carousel.activeIdx = (carousel.activeIdx + dir) % carousel.$el.find('img').length;

  leavingItem.addClass(exitDir);
  carousel.activeItem().addClass(enterDir).addClass('active');

  leavingItem.one("transitionend", function () {
    leavingItem.removeClass(exitDir);
    leavingItem.removeClass('active');

    setTimeout(function() {
      carousel.transitioning = false;
    }, 0);
  });

  setTimeout(function() {
    carousel.activeItem().removeClass(enterDir);
  }, 0);
};

$.Carousel.prototype.activeItem = function () {
  return $(this.$el.find('img').eq(this.activeIdx));
};

$.fn.carousel = function () {
  return this.each(function (el) {
    new $.Carousel(this);
  });
};
