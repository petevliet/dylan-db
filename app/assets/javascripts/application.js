// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .
$(document).ready(function(e){

  // number albums want to display
  var show_per_page = 12;
  // number of total albums set to display
  var number_of_albums = $(".well-albums-index").children().size();
  // number of pages there will be, plus one because #current_page starts on 1
  var number_of_pages = Math.ceil(number_of_albums/show_per_page + 1);
  // set to first page- value will be hidden in html
  $("#current_page").val(1);
  $("#show_per_page").val(show_per_page);
  // page number 1 is default active page
  $("#1").addClass("active_page");
  // initially, make all albums hidden
  $(".well-albums-index").children().css("display", "none");
  // then, show only the first albums in the per page range
  $(".well-albums-index").children().slice(0, show_per_page).css("display", "inline-block");
  // for all page# pagination icons, run go_to_page when clicked on
  for(var x = 1; x < number_of_pages; x++){
    $("#" + x).on("click", function(e){
      go_to_page(parseInt(this.id));
    });
  }
  $("#albums_count").append("<center>Showing albums 1 - 12 of " + number_of_albums + "</center>");

  $("#previous").on("click", function(){
    previous();
  });

  $("#next").on("click", function(){
    next();
  });

  $("input.6270")

  function previous(){
    if (!$("#previous").hasClass("disabled")){
      new_page = parseInt($("#current_page").val()) - 1;
      go_to_page(new_page);
    }
  }

  function next(){
    if (!$("#next").hasClass("disabled")){
      new_page = parseInt($("#current_page").val()) + 1;
      go_to_page(new_page);
    }
  }

  function go_to_page(page_num){
    var start_from = (page_num - 1) * show_per_page;
    var end_on = start_from + show_per_page;
    $(".well-albums-index").children().hide().slice(start_from, end_on).slideDown(800);
    $('body, .well-albums-container').animate({
      scrollTop: $("#albums").offset().top
    }, 1600);
    $('.well-albums-index').animate({scrollTop: "0px"}, 700);
    $("#" + page_num).addClass("active").siblings(".active").removeClass("active");
    $("#current_page").val(page_num);
    if (parseInt($("#current_page").val()) === 1) {
      $("#previous").addClass("disabled");
    }else{
      $("#previous").removeClass("disabled");
    }
    if (parseInt($("#current_page").val()) === number_of_pages - 1){
      $("#albums_count").replaceWith("<div id='albums_count'><center>Showing albums " + (start_from + 1) + " - " + number_of_albums + " of " + number_of_albums + "</center></div>");
      $("#next").addClass("disabled");
    }else{
      $("#albums_count").replaceWith("<div id='albums_count'><center>Showing albums " + (start_from + 1) + " - " + (end_on) + " of " + number_of_albums + "</center></div>");
      $("#next").removeClass("disabled");
    }

  }
});
