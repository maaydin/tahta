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
         context: this,
         success: this.widgets
      });
   }

   App.prototype.widgets = function(dashboard) {
      var widget, grid;
      grid = $('.container');
      grid.html("");
      for (i = 0, len = dashboard.widgets.length; i < len; i++) {
         widget = dashboard.widgets[i];
         grid.append("<div data-ss-colspan=\"" + widget.config.x + "\" data-bc-rowspan=\"" + widget.config.y + "\"><div id=\"widget" + widget.id + "\" class=\"widget-container dimgray " + widget.type + "\"><header>" + widget.title + "</header><p></p><footer></footer></div></div>");
         this.render(widget)
      }
      this.grid();
   };

   App.prototype.grid = function(widget) {
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

   App.prototype.render = function(widget) {
      var query = widget.config.query;
      if (query === "") {
         query = 'true';
      }
      var widgetObj = eval('new StatusWidget(widget);');
      this.bind(widgetObj, query)
   };


   App.prototype.bind = function(widget, query) {
      var app = this;
      var ws = new WebSocket('ws://localhost:5556/index?subscribe=true&query='+ encodeURIComponent('state != "expired" and ' + query))
      ws.onopen = function() {
         console.log('WebSocket connection established...');
         widget.connected();
      };
      ws.onmessage = function(event) {
         event = $.parseJSON(event.data)
         widget.render(event);
      };
      ws.onerror = function(error) {
         console.error('WebSocket error occured: ' + error);
         this.close();
      };
      ws.onclose = function() {
         console.error('WebSocket connection closed...');
         widget.disconnected();
         setTimeout(function() { app.bind(widget, query); }, 10000);
      };
   };
   return App;

})();

root = typeof exports !== "undefined" && exports !== null ? exports : window;

root.App = App;