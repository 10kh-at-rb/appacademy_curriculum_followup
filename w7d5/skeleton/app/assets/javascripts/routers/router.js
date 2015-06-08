
TrelloClone.Routers.Router = Backbone.Router.extend({

  initialize: function (options) {
  },

  routes: {
    "": "index"
  },

  index: function () {
    var collection = new TrelloClone.Collections.Boards();
    var indexView = new TrelloClone.Views.BoardsIndex({
      collection: collection
    });

    collection.fetch();

    this._swapView(indexView);
  },

  _swapView: function (newView) {
    this._currentView && this._currentView.remove();
    this._currentView = newView;
    $('#main').html(newView.render().$el);
  }

});
