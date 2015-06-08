
TrelloClone.Routers.Router = Backbone.Router.extend({

  initialize: function (options) {
    this.$rootEl = options.$rootEl;
    this.collection = options.collection;
  },

  routes: {
    "": "index",
    "boards/:id": "show"
  },

  index: function () {
    this.collection.fetch();

    var indexView = new TrelloClone.Views.BoardsIndex({
      collection: this.collection
    });

    this._swapView(indexView);
  },

  show: function (id) {
    var board = this.collection.getOrFetch(id);
    var showView = new TrelloClone.Views.BoardShow({
      model: board
    });

    this._swapView(showView);
  },

  _swapView: function (newView) {
    this._currentView && this._currentView.remove();
    this._currentView = newView;
    this.$rootEl.html(newView.render().$el);
  }

});
