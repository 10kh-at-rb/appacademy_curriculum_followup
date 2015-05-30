$.UsersSearch = function (el) {
  this.$el = $(el);
  this.$inputEl = this.$el.find('input');
  this.ul = this.$el.find('.users');

  this.$el.on('keypress', this.handleInput.bind(this));
};

$.UsersSearch.prototype.handleInput = function (event) {
  event.preventDefault();
  var string = String.fromCharCode(event.keyCode);

  $.ajax({
    type: "GET",
    url: "/users/search",
    data: {value: string},
    dataType: 'json',
    success: function (jsonData) {
      JSON.parse(jsonData);
      // $(<li>).append
    }.bind(this)
  });
};

$.UsersSearch.prototype.renderResults = function () {

};

$.fn.usersSearch = function () {
  return this.each (function () {
    new $.UsersSearch(this);
  });
};

$(function () {
    $('div.users-search').usersSearch();
});
