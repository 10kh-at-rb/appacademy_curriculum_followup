TrelloClone.Views.BoardsNew = Backbone.View.extend({

  events: {
    "click .newBoard": "create"
  },

  template: JST['boards/new'],

  render: function () {
    this.$el.html(this.template());
    debugger;
    return this;
  }

});
