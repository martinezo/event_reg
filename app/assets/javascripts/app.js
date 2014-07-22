/**
 * Created with JetBrains RubyMine.
 * User: martinezo
 * Date: 7/24/13
 * Time: 5:54 PM
 * To change this template use File | Settings | File Templates.
 */


var show_hide_speed = 700;


//For turbolinks: http://stackoverflow.com/questions/17600093/rails-javascript-not-loading-after-clicking-through-link-to-helper
$(document).on('page:load', function(){
    load_jquery_ui();
})

$(document).ready(function(){
    load_jquery_ui();
    $(document).tooltip();
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

function carousel(){
    $('#carousel').owlCarousel({
        navigation : false, // Show next and prev buttons
        slideSpeed : 300,
        paginationSpeed : 1000,
        singleItem: true,
        autoPlay:  5000
    });
}

function load_jquery_ui(){
    jqbuttons();
    jqdatepicker();
    remote_will_paginate();
    jqmenu();
    carousel();
}
