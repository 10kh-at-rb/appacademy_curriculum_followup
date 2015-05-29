$.Tabs = function (el) {
  this.$el = $(el);
  this.$contentTabs = $(this.$el.data('content-tabs'));
  this.$activeTab = this.$contentTabs.find(".active");
  this.activeTabTransitioning = false;

  this.$el.on('click', 'a', this.clickTab.bind(this));

};

$.Tabs.prototype.clickTab = function (event) {
  event.preventDefault();
  if (this.activeTabTransitioning) { return; }
  var tabs = this;
  tabs.activeTabTransitioning = true;

  // tabs.$el.find('a').removeClass('active');
  tabs.$el.find('li').removeClass('active');
  tabs.$activeTab.removeClass("active");
  tabs.$activeTab.addClass("transitioning");

  var $currentTarget = $(event.currentTarget); //.addClass('active');
  $currentTarget.parent().addClass('active');

  tabs.$activeTab.one("transitionend", function () {
    tabs.$activeTab.removeClass("transitioning");
    tabs.$activeTab = $($currentTarget.attr('href')).addClass('active transitioning');
    setTimeout(function(){
      tabs.$activeTab.removeClass('transitioning');
      tabs.activeTabTransitioning = false;
    }, 0);
  });

};

$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};
