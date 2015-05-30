$.FollowToggle = function (el) {
  this.$el = $(el);
  this.userId = this.$el.data('user-id');
  this.followState = this.$el.data('initial-follow-state');

  this.render();
  this.$el.on('click', this.handleClick.bind(this));
};

$.FollowToggle.prototype.render = function () {
  if (this.followState === "following" || this.followState === "unfollowing") {
    this.$el.prop('disabled', 'true');
  } else if (this.followState === "unfollowed") {
    this.$el.removeAttr('disabled');
    this.$el.html('Follow!');
  } else {
    this.$el.removeAttr('disabled');
    this.$el.html('Unfollow!');
  }
};

$.FollowToggle.prototype.handleClick = function (event) {
  event.preventDefault();

  if (this.followState === "unfollowed") {
    this.followState = "following";
    this.render();

    $.ajax({type: 'POST',
            url: '/users/' + this.userId + '/follow',
            dataType: 'json',
            success: function () {
              this.followState = "followed";

              this.render();
            }.bind(this)
    });
  } else {
    this.followState = "unfollowing";
    this.render();

    $.ajax({type: 'DELETE',
            url: '/users/' + this.userId + '/follow',
            dataType: 'json',
            success: function () {
              this.followState = "unfollowed";

              this.render();
            }.bind(this)
      });
    }
  };


$.fn.followToggle = function () {
  return this.each(function () {
    new $.FollowToggle(this);
  });
};

$(function () {
  $("button.follow-toggle").followToggle();
});
