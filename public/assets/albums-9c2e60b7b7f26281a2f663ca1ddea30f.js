var previousIndex;
var nextIndex;

$(document).ready(function(){
    $("#photo_div").justifiedGallery({
      rowHeight : 250,
      lastRow : 'nojustify',
      margins : 3,
      captions : false
    });
  });

$(function () {
  $('.photo_image').click(function () {

    $.ajax({
        type: "GET",
        dataType: "json",
        url: "/photos/" + $(this).attr('id'),
        success: function(data){
          console.log(data);

          $('#zoom').attr("src", data.photo.image);

          $("#comment_list").empty();
          var index, len;
          for (index = 0, len = data.comments.length; index < len; ++index) {
            $("#comment_list").append('<li><strong>' + data.comments[index].commenter +' </strong>' + data.comments[index].body + '</li>');
          }


          $('#zoom_area').show();
          $('#previous').show();
          $('#next').show();

          previousIndex = data.previous_photo;
          nextIndex = data.next_photo;

          if(previousIndex == null) {
            $('#previous').hide();
          }

          if (nextIndex == null) {
            $('#next').hide();
          }
          
        }
    }); 


    return false;
   })

  $('#zoom').click(function () {   
    $('#zoom_area').hide();
    $('#previous').hide();
    $('#next').hide();
    return false;
   })


  $('#previous').click(function () {  

    $.ajax({
        type: "GET",
        dataType: "json",
        url: "/photos/" + previousIndex,
        success: function(data){
          console.log(data);

          $('#zoom').attr("src", data.photo.image);

          $("#comment_list").empty();
          var index, len;
          for (index = 0, len = data.comments.length; index < len; ++index) {
            $("#comment_list").append('<li><strong>' + data.comments[index].commenter +' </strong>' + data.comments[index].body + '</li>');
          }

          $('#zoom').show();
          $('#previous').show();
          $('#next').show();

          previousIndex = data.previous_photo;
          nextIndex = data.next_photo;

          if(previousIndex == null) {
            $('#previous').hide();
          }
        }
    }); 

    return false;
   })

  $('#next').click(function () { 

    $.ajax({
        type: "GET",
        dataType: "json",
        url: "/photos/" + nextIndex,
        success: function(data){
          console.log(data);

          $('#zoom').attr("src", data.photo.image);

          $("#comment_list").empty();
          var index, len;
          for (index = 0, len = data.comments.length; index < len; ++index) {
            $("#comment_list").append('<li><strong>' + data.comments[index].commenter +' </strong>' + data.comments[index].body + '</li>');
          }
          
          $('#zoom').show();
          $('#previous').show();
          $('#next').show();

          previousIndex = data.previous_photo;
          nextIndex = data.next_photo;

          if (nextIndex == null) {
            $('#next').hide();
          }
        }
    }); 

    return false;
   })


});
