TrelloClone.Views.BoardsNew = Backbone.View.extend({

  events: {
    "submit .new-board": "create"
  },

  template: JST['boards/new'],

  render: function () {
    this.$el.html(this.template());

    return this;
  },

  create: function (event) {
    event.preventDefault();

    var that = this;
    var board = new TrelloClone.Models.Board();

    board.save($(event.currentTarget).serializeJSON(), {
      success: function (model, response, options) {
        that.collection.add(model);
      }
    });

  }

});
