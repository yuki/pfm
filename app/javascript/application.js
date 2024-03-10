// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// import "@hotwired/turbo-rails"
import "controllers"
import "jquery"
import "jquery_ujs"
import  "highcharts"

/*!
* Color mode toggler for Bootstrap's docs (https://getbootstrap.com/)
* Copyright 2011-2022 The Bootstrap Authors
* Licensed under the Creative Commons Attribution 3.0 Unported License.
* 
* Ruben: There are few modifications because my HTML template is different.
*/

(() => {
    'use strict'

    const storedTheme = localStorage.getItem('theme')
    
    const getPreferredTheme = () => {
        if (storedTheme) {
        return storedTheme
        }
    
        return window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light'
    }
    
    const setTheme = function (theme) {
        if (theme === 'auto' && window.matchMedia('(prefers-color-scheme: dark)').matches) {
        document.documentElement.setAttribute('data-bs-theme', 'dark')
        } else {
        document.documentElement.setAttribute('data-bs-theme', theme)
        }
    }
    
    setTheme(getPreferredTheme())
    
    const showActiveTheme = theme => {
        const activeThemeIcon = document.querySelector('.theme-icon-active')
        //this line doesn't work for me, so I changed a bit
        //const btnToActive = document.querySelector(`[data-bs-theme-value="${theme}"]`)
        const btnToActive = document.querySelector('[data-bs-theme-value="'+theme+'"]')
        const svgOfActiveBtn = btnToActive.getAttribute('href')
    
        document.querySelectorAll('[data-bs-theme-value]').forEach(element => {
            element.classList.remove('active')
        })
    
        btnToActive.classList.add('active')
        activeThemeIcon.innerHTML=""
        activeThemeIcon.setAttribute('href', svgOfActiveBtn)
        const i = document.createElement("i")
        i.setAttribute('class','opacity-50 theme-icon '+svgOfActiveBtn)
        activeThemeIcon.append(i)
    }
    
    window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', () => {
        if (storedTheme !== 'light' || storedTheme !== 'dark') {
        setTheme(getPreferredTheme())
        }
    })
    
    window.addEventListener('DOMContentLoaded', () => {
        showActiveTheme(getPreferredTheme())
    
        document.querySelectorAll('[data-bs-theme-value]')
        .forEach(toggle => {
            toggle.addEventListener('click', () => {
            const theme = toggle.getAttribute('data-bs-theme-value')
            localStorage.setItem('theme', theme)
            setTheme(theme)
            showActiveTheme(theme)
            })
        })
    })
})()

// tooltips
const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))


export function column_graph (where, title, data_json) {
    var chart;
    $(document).ready(function() {
       chart = new Highcharts.Chart({
          chart: {
             renderTo: where,
             defaultSeriesType: 'column'
          },
          title: {
             text: title + ' '
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

export function drilldown_column_graph (where, title, data_json, drilldown) {
    var chart;
    $(document).ready(function() {
       chart = new Highcharts.Chart({
          chart: {
             renderTo: where,
             defaultSeriesType: 'column'
          },
          title: {
             text: title + ' '
          },
          accessibility: {
              announceNewData: {
                  enabled: true
              }
          },
          xAxis: {
             type: 'category'
          },
          yAxis: {
              title: {
                  text: 'Amount'
              }
          },
          plotOptions: {
            series: {
              borderWidth: 0,
              dataLabels: {
                enabled: true,
                format: '{point.y:.2f}'
              },
              cursor: 'pointer',
              point: {
                  // events: {
                  //     click: function () {
                  //         alert('Category: ' + this.category + ', value: ' + this.y);
                  //     }
                  // }
              }
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
          series: data_json ,
          drilldown:  drilldown
       });
    });
}


export function stack_graph (where,title,data_json) {
    var char;
    jQuery(document).ready(function() {
        var chart = new Highcharts.Chart({
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
