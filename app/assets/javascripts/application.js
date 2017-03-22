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
$(document).ready(function(){

  var show_per_page = 12;
  var number_of_albums = $(".well-albums-index").children().size();
  var number_of_pages = Math.ceil(number_of_albums/show_per_page + 1);

  $("#current_page").val(1);
  $("#show_per_page").val(show_per_page);
  $("#1").addClass("active_page");

  $(".well-albums-index").children().css("display", "none");
  $(".well-albums-index").children().slice(0, show_per_page).css("display", "inline-block");

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

  $("#narrow-search").on("click", function(){
    var checkedYears = $("#years").find(":checkbox").filter(":checked");
    var checkedTypes = $("#types").find(":checkbox").filter(":checked");
    var albumBoxes = $(".well-albums-index").children()

    if (checkedYears.length === 0 && checkedTypes.length === 0){
      location.reload();
    };
    albumBoxes.hide();
    if (checkedTypes.length > 0 && checkedYears.length > 0){
      $(checkedTypes).each(function(i, type){
        $(albumBoxes).each(function(i, el){
          $($(el).data('types')).each(function(i, albumType){
            if(albumType === $(type).val()){
              $(el).show();
            }
          });
        });
      });
      var checkedTypesInYears = [];
      $(checkedYears).each(function(i, years){
        $(albumBoxes).filter(":visible").each(function(i, el){
          if(parseInt($(el).data('year-released')) >= parseInt($(years).val()) && parseInt($(el).data('year-released')) < parseInt($(years).val()) + 10){
            checkedTypesInYears.push(el);
          }
        });
      });
      albumBoxes.hide();
      $(checkedTypesInYears).each(function(i, element){
        $(element).slideDown(400);
      });
    }
    else if (checkedTypes.length > 0 && checkedYears.length === 0){
      $(checkedTypes).each(function(i, type){
        $(albumBoxes).each(function(i, el){
          $($(el).data('types')).each(function(i, albumType){
            if(albumType === $(type).val()){
              $(el).slideDown(400);
            }
          });
        });
      });
  } else if (checkedYears.length > 0 && checkedTypes.length === 0){
      $(checkedYears).each(function(i, years){
        $(albumBoxes).each(function(i, el){
          if(parseInt($(el).data('year-released')) >= parseInt($(years).val()) && parseInt($(el).data('year-released')) < parseInt($(years).val()) + 10){
            $(el).slideDown(400);
          }
        });
      });
    }
    var visibleAlbums = $("div.panel-body:visible").length;
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

  $(".album-track").hover(
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

  $(".lyric-section").hover(
    function(){
    if (!$(this).hasClass("active")){
      $(this).animate({
        backgroundColor: "#E2F9FB",
        fontSize: "1.2em"
      }, 50);
      $(this).popover("show");
    }
    }, function(){
      if (!$(this).hasClass("active")){
        $(this).animate({
          backgroundColor: "white",
          fontSize: "1.1em"
        }, 50);
      }
      $(this).popover("hide");
    }
  );

  $(".lyric-section").on("click", function(){
    var oldClickedVerse = $(".lyrics").find(".active");
    if (oldClickedVerse.length > 0){
      $(oldClickedVerse[0]).removeClass("active");
      $(oldClickedVerse).animate({
        backgroundColor: "white",
        fontSize: "1.1em"
      }, 100);
    }
    var clickedVerse = this;
    $(clickedVerse).addClass("active");
    $(clickedVerse).animate({
      backgroundColor: "#EEEEEE",
      fontSize: "1.2em"
    }, 100);
    $(".track-show .well").each(function(i, el){
      if ($(clickedVerse).data("verse-comments") == $(el).data("verse-number")){
        $(el).slideDown(200);
      }else{
        $(el).slideUp(100);
      };
    });
  });

  $(".close-comments").on("click", function(){
    $(".track-show .well").slideUp(100);
    var clickedVerse = $(".lyrics").find(".active");
    $(clickedVerse).removeClass("active");
    $(clickedVerse).animate({
      backgroundColor: "white",
      fontSize: "1.1em"
    }, 100);
  });

  $('#newCommentModal').on('show.bs.modal', function (event) {
    $(".verse-section").empty();
    var activeVerseElement = $("#lyrics-scroll").find(".active")[0];
    var verseLyrics = $($(activeVerseElement).find("#verse")[0]).html();
    $(".verse-section").append(verseLyrics);
    var button = $(event.relatedTarget);
    var verseNum = $(button[0]).data('verse-number-comment');
    var verseNumEntry = $(this).find("#verseNumEntry")[0];
    $(verseNumEntry).val(verseNum);
  });

  $(".songs").hover(
    function(){
      $(this).find("a")[0];
      $(this).animate({
        backgroundColor: "#E2F9FB"
      }, 50);
    }, function(){
        $(this).animate({
          backgroundColor: "white"
        }, 50);
    }
  );

  $(".letter-click").hover(
    function(){
      if (!(this.id === "X" || this.id === "Z")){
      $(this).animate({
        backgroundColor: "#6699FF",
        fontSize: "2.5em",
        color: "white"
      }, 100);
    }
    }, function(){
      $(this).animate({
        backgroundColor: "white",
        fontSize: "1.5em",
        color: "black"
      }, 100);
    }
  );

  $(".letter-click").on("click", function(){
    if (!(this.id === "X" || this.id === "Z")){
      var previousSelected = $(".songbox").filter(":visible")[0]
      var currentLetter = this.id;
      var newBox = $(".songs-collection").find("#" + currentLetter)[0]
      $(".active-letter").animate({opacity: 0}, 200, function(){
        $(".active-letter").empty();
        $(".active-letter").text(currentLetter).animate({opacity: 0.4}, 200);
      });
      $(".songbox").animate({opacity: 0}, 200, function(){
        $(previousSelected).hide();
        $(newBox).show();
        $(newBox).animate({opacity: 1}, 200);
      });
    }
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
    $(".well-albums-index").children().hide().slice(start_from, end_on).slideDown(400);
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
