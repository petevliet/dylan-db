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
  // append album count above pagination icons
  $("#albums_count").append("<center>Showing albums 1 - 12 of " + number_of_albums + "</center>");

  $("#previous").on("click", function(){
    previous();
  });

  $("#next").on("click", function(){
    next();
  });
  // narrow search according to checkboxes on albums#index when 'narrow' button clicked
  $("#narrow-search").on("click", function(){
    // place year and type selected checkboxes into separate arrays
    var checkedYears = $("#years").find(":checkbox").filter(":checked");
    var checkedTypes = $("#types").find(":checkbox").filter(":checked");
    var albumBoxes = $(".well-albums-index").children()
    // reload page if no checkboxes selected and narrowsearch is clicked
    if (checkedYears.length === 0 && checkedTypes.length === 0){
      location.reload();
    };
    albumBoxes.hide();
    // iterate through each selected album type checkbox, album, and album type and show if values match
    if (checkedTypes.length > 0){
      $(checkedTypes).each(function(i, type){
        $(albumBoxes).each(function(i, el){
          $($(el).data('types')).each(function(i, albumType){
            if(albumType === $(type).val()){
              // if album type matches selected checkbox type, make album visible
              $(el).show();
            }
          });
        });
      });
    // for each checked box, iterate through each albumBox
  } if (checkedYears.length > 0){
      $(checkedYears).each(function(i, years){
        $(albumBoxes).each(function(i, el){
          // if album year falls within checkedBox range, make album visible
          if(parseInt($(el).data('year-released')) >= parseInt($(years).val()) && parseInt($(el).data('year-released')) < parseInt($(years).val()) + 10){
            $(el).show();
          }
        });
      });
    }
    // assign variable to num of visible albums
    var visibleAlbums = $("div.panel-body:visible").length;
    // results will be shown in one well container
    $(".pagination").remove();
    $("#albums_count").replaceWith("<div id='albums_count'><center>Showing albums 1 - " + visibleAlbums + " of " + visibleAlbums + "</center></div>");
    $('html, body').animate({
      scrollTop: $("#albums").offset().top
    }, 1000);
  });

  $(".album-box").hover(
    function(){
      $(this).removeClass("panel-default");
      $(this).addClass("panel-info album-box-active");
      $($(this).find(".btn-xs")[0]).removeClass("btn-link");
      $($(this).find(".btn-xs")[0]).addClass("btn-info album-box-active-button");
      $($(this).find("img")).fadeTo(200, 1.0);
    }, function(){
      $(this).removeClass("panel-info album-box-active");
      $(this).addClass("panel-default");
      $($(this).find(".btn-xs")[0]).removeClass("btn-info album-box-active-button");
      $($(this).find(".btn-xs")[0]).addClass("btn-link");
      $($(this).find("img")).fadeTo(200, 0.6);
    }
  );

  $(function () {
    $('[data-toggle="popover"]').popover()
  });

  $(".list-group-item").hover(
    function(){
      $(this).addClass("active");
      $($(this).children()[0]).removeClass("btn-link");
      $($(this).children()[0]).addClass("btn-primary album-show-active-button");
      $(this).popover('show');
    }, function(){
      $(this).removeClass("active");
      $($(this).children()[0]).removeClass("btn-primary album-show-active-button");
      $($(this).children()[0]).addClass("btn-link");
      $(this).popover('hide');
    }
  );

  $("#album-art").load(function(){
    $('html, body').animate({
      scrollTop: $(".breadcrumb").offset().top
    }, 1500);
  });

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
