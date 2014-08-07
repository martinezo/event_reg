/**
 * Created with JetBrains RubyMine.
 * User: martinezo
 * Date: 7/24/13
 * Time: 5:54 PM
 * To change this template use File | Settings | File Templates.
 */

// TODO check if require_tree . is necessary
//= require jquery
//= require turbolinks
//= require jquery_ujs
//= require jquery.remotipart
//= require_tree ../../../vendor/assets/javascripts/owl-carousel

//For turbolinks: http://stackoverflow.com/questions/17600093/rails-javascript-not-loading-after-clicking-through-link-to-helper
$(document).on('page:load', function(){
    set_functions_app();
})

$(document).ready(function(){
    set_functions_app();
});


function carousel(){
    $('#carousel').owlCarousel({
        navigation : false, // Show next and prev buttons
        slideSpeed : 300,
        paginationSpeed : 1000,
        singleItem: true,
        autoPlay:  5000
    });
}

function fill_input_file_name() {
    $("#catalogs_course_content_file_tag,#catalogs_course_image_file1_tag,#catalogs_course_image_file2_tag,#catalogs_course_image_file3_tag,#catalogs_participant_upload_file1_tag,#catalogs_participant_upload_file2_tag,#catalogs_participant_upload_file3_tag").change(function() {
        $("#" + this.id.slice(0, -4)).val($(this).val());
    });
};

function clear_input_file() {
    $(".remove-file-button").click(function(event) {
        event.preventDefault();
        $($(this).attr("name")).val("");
        $($(this).attr("name") + "_tag").val("");
    });
};

function set_functions_app(){
    carousel();
    clear_input_file();
    fill_input_file_name();
};

