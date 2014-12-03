// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require moment
//= require moment/es
//= require bootstrap-datetimepicker
//= require highcharts
//= require_tree .


function column_graph (where, title, data_json) {
    var chart;
    $(document).ready(function() {
       chart = new Highcharts.Chart({
          chart: {
             renderTo: where,
             defaultSeriesType: 'column'
          },
          title: {
             text: title + ' per movement type'
          },
          xAxis: {
             categories: ['Moves types']
          },
          yAxis: {
              title: {
                  text: 'Amount'
              }
          },
          tooltip: {
             formatter: function() {
                return ''+
                    '<b>'+this.series.name +'</b>: '+ this.y +'';
             }
          },
          credits: {
             enabled: false
          },
          series: data_json
       });
    });
}


function stack_graph (where,title,data_json) {
    var char;
    jQuery(document).ready(function() {
        chart = new Highcharts.Chart({
            chart: {
                renderTo: where,
                defaultSeriesType: 'column'
            },
            title: {
                text: 'Stacked ' + title + ' %'
            },
            xAxis: {
                categories: ['Total Amount']
            },
            yAxis: {
                title: {
                    text: ''
                }
            },
            tooltip: {
                formatter: function() {
                    return ''+
                         this.series.name +': '+ this.y +' ('+ Math.round(this.percentage) +'%)';
                }
            },
            plotOptions: {
                column: {
                    stacking: 'percent'
                }
            },
            series: data_json
        });
    });
}
