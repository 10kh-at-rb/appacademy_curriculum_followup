TrelloClone.Views.BoardsIndex = Backbone.View.extend({

  template: JST['boards/index'],

  initialize: function () {
    this.listenTo(this.collection, 'sync', this.render);
  },

  render: function () {
    this.$el.html(this.template({ boards: this.collection }));

    var newBoard = new TrelloClone.Views.BoardsNew({
      collection: this.collection
    });
    this.$el.append(newBoard.render().$el);

    return this;
  }

});
