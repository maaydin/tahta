var App, root;

App = (function() {
   function App() {
      console.log('App initialized.');
   }

   App.prototype.init = function() {
      console.log('init method invoked.');

      $('.container').shapeshift({
        minColumns: 2
      });

      $('.container>div').resizable({
        grid: [158, 158],
        minWidth: 148,
        minHeight: 148,
        resize: function (event, ui) {
          colspan = ($(this).width() + 10) / 158;
          $(this).attr('data-ss-colspan', colspan);
          $(".container").trigger("ss-rearrange");
        },
        stop: function (event, ui) {}
      });
      this.simulate();
   };

   App.prototype.simulate = function() {
      var series = new TimeSeries();
      var series2 = new TimeSeries();
      var series3 = new TimeSeries();
      var series4 = new TimeSeries();
      var chart = new SmoothieChart({enableDpiScaling: false, grid:{millisPerLine:10000,fillStyle:'transparent',strokeStyle:'transparent',verticalSections:5,borderVisible:false},labels: {fontSize: 9, precision: 60, disabled: true},timestampFormatter:SmoothieChart.timeFormatter, millisPerPixel: 100}),
      canvas = $('#lineChart').get(0);

      chart.addTimeSeries(series, {lineWidth:2,fillStyle:'rgba(251,220,20,0.40)', strokeStyle:'rgba(251,220,20,0.80)'});
      chart.addTimeSeries(series2, {lineWidth:2,fillStyle:'rgba(221,102,93,0.40)', strokeStyle:'rgba(221,102,93,0.80)'});
      chart.addTimeSeries(series3, {lineWidth:2,fillStyle:'rgba(158,251,145,0.40)', strokeStyle:'rgba(158,251,145,0.80)'});
      chart.addTimeSeries(series3, {lineWidth:2,fillStyle:'rgba(147,220,220,0.40)', strokeStyle:'rgba(147,220,220,0.80)'});
      chart.streamTo(canvas, 1000);
      setInterval(function() {
         var time = new Date().getTime()
         var value = Math.floor((Math.random() * 100) + 1);
         series.append(time, value);
      }, 1000);
      setInterval(function() {
         var time = new Date().getTime()
         var value = Math.floor((Math.random() * 100) + 1);
         series2.append(time, value);
      }, 2000);
      setInterval(function() {
         var time = new Date().getTime()
         var value = Math.floor((Math.random() * 100) + 1);
         series3.append(time, value);
      }, 3000);
      setInterval(function() {
         var time = new Date().getTime()
         var value = Math.floor((Math.random() * 100) + 1);
         series4.append(time, value);
      }, 4000);
   }

   return App;

})();

root = typeof exports !== "undefined" && exports !== null ? exports : window;

root.App = App;