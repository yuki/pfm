// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require chosen
//= require highcharts
//= require highcharts/themes/grid
//= require highcharts/modules/exporting

function remove_fields (link) {
    $(link).parent().prev().children("input[type=checkbox]").attr("checked",true);
    $(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g");
    $(link).parent().parent().before(content.replace(regexp, new_id));
}

function show_graphic(container) {
    $(".graphic").hide();
    $("#"+container).toggle();
}
