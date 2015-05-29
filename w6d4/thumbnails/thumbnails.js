$.Thumbnails = function(el) {
  this.$el = $(el);
  this.$gutterImages = this.$el.find('.gutter-images');
  this.$images = this.$gutterImages.children();
  this.$activeImg = this.$images.eq(0);
  this.gutterIdx = 0;

  this.activate(this.$activeImg);
  this.fillGutterImages();

  this.$gutterImages.on('click', this.pickImage.bind(this));
  this.$gutterImages.on('mouseenter', 'img', this.showTempImage.bind(this));
  this.$gutterImages.on('mouseleave', 'img', this.hideTempImage.bind(this));

  this.$el.find('.nav').eq(0).on('click', function() {
    if (this.gutterIdx > 0) {
      this.gutterIdx = this.gutterIdx - 1;
    }
    this.fillGutterImages();
  }.bind(this));

  this.$el.find('.nav').eq(-1).on('click', function() {
    if (this.gutterIdx < this.$images.length - 5) {
      this.gutterIdx = this.gutterIdx + 1;
    }
    this.fillGutterImages();
  }.bind(this));

  setInterval(this.randomImage.bind(this), Math.floor(Math.random() * 200 + 100));
};

$.Thumbnails.prototype.fillGutterImages = function () {
  this.$gutterImages.html('');
  var thumbnails = this;
  this.$images.slice(this.gutterIdx, this.gutterIdx + 5).each(function () {
    thumbnails.$gutterImages.append(this);
  });
};

$.Thumbnails.prototype.randomImage = function (first_argument) {
  var activeImgIdx = Math.floor(Math.random() * this.$images.length);
  this.$activeImg = this.$images.eq(activeImgIdx);
  this.activate(this.$activeImg);
};

$.Thumbnails.prototype.activate = function($img) {
  this.$el.find('div.active').html($img.clone());
};

$.Thumbnails.prototype.pickImage = function(event) {
  this.$activeImg = $(event.target);
  this.activate(this.$activeImg);
};

$.Thumbnails.prototype.showTempImage = function(event) {
  this.activate($(event.target));
};

$.Thumbnails.prototype.hideTempImage = function(event) {
  this.activate(this.$activeImg);
};

$.fn.thumbnails = function () {
  this.each(function () {
    new $.Thumbnails(this);
  });
};
