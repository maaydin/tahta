var StatusWidget, root;

StatusWidget = (function() {
   function StatusWidget(widget) {
      this.header = $('#widget' + widget.id + ' header');
      this.content = $('#widget' + widget.id + ' p');
      this.footer = $('#widget' + widget.id + ' footer');
   }

   StatusWidget.prototype.render = function(event) {
      this.content.attr('class', event.state);
      this.footer.text('Last update time: ' + event.time.substr(11,8));
   };

   StatusWidget.prototype.connected = function(event) {
      this.footer.text('Connection established.');
   };

   StatusWidget.prototype.disconnected = function(event) {
      this.content.removeClass();
      this.footer.text('Disconnected...');
   };

   return StatusWidget;

})();

root = typeof exports !== "undefined" && exports !== null ? exports : window;

root.StatusWidget = StatusWidget;