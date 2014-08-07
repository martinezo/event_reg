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
// jquery.remotipart Necessary for uploading files with ajax response (remote: true). Add in Gemfile: gem 'remotipart'
// TODO check if require_tree . is necessary
//= require ../../../vendor/assets/javascripts/jquery-ui.min
//= require ../../../vendor/assets/javascripts/colpick

var show_hide_speed = 700;

//For turbolinks: http://stackoverflow.com/questions/17600093/rails-javascript-not-loading-after-clicking-through-link-to-helper
$(document).on('page:load', function(){
    set_functions_admin();
})

$(document).ready(function(){
    set_functions_admin();
//    $(document).tooltip();
});

function remote_will_paginate(){
    $(".pagination a").attr('data-remote', 'true');
}

function jqdatepicker(){
    $('.jq-datepicker').datepicker({ dateFormat: 'yy/mm/dd' });
}

function jqbuttons(){
    $(".jq-button").each(function(){
//        alert($(this).attr("jq-icon") == null);
        if($(this).attr("jq-icon") != null){
            $(this).button({
                icons: {
                    primary: "ui-icon-" + $(this).attr("jq-icon")
                }
            });
        };
        $(this).button({
            text: $(this).attr("jq-text") == 'true'
        })
    });
}

function center_ui_dialog(){
    $('.ui-dialog:visible').css('top', ($(window).height()-$('.ui-dialog:visible').height())/2);
    $('.ui-dialog:visible').css('left', ($(window).width()-$('.ui-dialog:visible').width())/2);
}

function jqmenu(){
    $('#admin-menu').menu({position: { of: $('#admin-menu'), my: "right top", at: "right bottom", collision: "none none" }});
}

function set_functions_admin(){
    jqbuttons();
    jqdatepicker();
    remote_will_paginate();
    jqmenu();
}