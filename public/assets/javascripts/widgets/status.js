var StatusWidget, root;

StatusWidget = (function() {
  function StatusWidget(config, widget) {
    this.header = $('#' + widget.elementid + ' header');
    this.content = $('#' + widget.elementid + ' p');
    this.footer = $('#' + widget.elementid + ' footer');
  }

  StatusWidget.prototype.render = function(event) {
    this.content.attr('class', event.state);
    this.footer.text(event.time);
  };

  return StatusWidget;

})();

root = typeof exports !== "undefined" && exports !== null ? exports : window;

root.StatusWidget = StatusWidget;