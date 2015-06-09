TrelloClone.Models.Board = Backbone.Model.extend({

  urlRoot: "api/boards",

  lists: function () {
    var lists = this.get('lists') || [];

    return lists;
  }

});
