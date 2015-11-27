var App, root;

App = (function() {
   function App() {
   }

   App.prototype.init = function() {
      var route = window.location.hash.substr(2);
      this.route(route);
   };

   App.prototype.route = function(route) {
      if(route !== "") {
         this.dashboard(route);
      }
   }

   App.prototype.dashboard = function(name) {
      $.ajax({
         type: 'GET',
         url: '/api/dashboard/' + name,
         dataType: 'json',
         success: this.widgets
      });
   }

   App.prototype.widgets = function(dashboard) {
      var widget, grid;
      grid = $('.container');
      for (i = 0, len = dashboard.widgets.length; i < len; i++) {
         widget = dashboard.widgets[i];
         grid.append("<div data-ss-colspan=\"" + widget.config.x + "\" data-bc-rowspan=\"" + widget.config.y + "\"><div id=\"widget" + widget.id + "\" class=\"widget-container dimgray " + widget.type + "\"><header>" + widget.title + "</header><p></p><footer></footer></div></div>");
         new StatusWidget(widget);
      }

      $('.container').shapeshift({
         minColumns: 2
      });

      $('.container>div').resizable({
        grid: [158, 158],
        minWidth: 148,
        minHeight: 148,
        resize: function (event, ui) {
          colspan = ($(this).width() + 10) / 158;
          rowspan = ($(this).height() + 10) / 158;
          $(this).attr('data-ss-colspan', colspan);
          $(this).attr('data-bc-rowspan', rowspan);
          $(".container").trigger("ss-rearrange");
        },
        stop: function (event, ui) {}
      });
   };

   return App;

})();

root = typeof exports !== "undefined" && exports !== null ? exports : window;

root.App = App;