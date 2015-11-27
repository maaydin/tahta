var StatusWidget, root;

StatusWidget = (function() {
   function StatusWidget(widget) {
      this.header = $('#widget' + widget.id + ' header');
      this.content = $('#widget' + widget.id + ' p');
      this.footer = $('#widget' + widget.id + ' footer');
      var widgetObj = this;
      
      var ws = new WebSocket('ws://localhost:5556/index?subscribe=true&query='+ encodeURIComponent(widget.config.query))
      ws.onmessage = function(event) {
         event = $.parseJSON(event.data)
         widgetObj.render(widgetObj, event);
      };
   }

   StatusWidget.prototype.render = function(widget, event) {
      widget.content.attr('class', event.state);
      widget.footer.text(event.time);
   };

   return StatusWidget;

})();

root = typeof exports !== "undefined" && exports !== null ? exports : window;

root.StatusWidget = StatusWidget;