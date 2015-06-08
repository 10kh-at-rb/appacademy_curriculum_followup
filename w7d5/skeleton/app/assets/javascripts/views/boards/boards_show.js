TrelloClone.Views.BoardShow = Backbone.View.extend({

  events: {
    
  },

  template: JST['boards/show'],

  render: function () {
    console.log(this.model);
    this.$el.html(this.template({ board: this.model }));

    return this;
  }

});
