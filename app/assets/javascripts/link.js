
$(function(){


  $(".new_link").submit(function(e){
    var linkTarget = $("#link_target")
    var target_text = linkTarget.val();

    target_text.replace(/ /g, "");
    linkTarget.val( target_text );

    if( target_text === "" ){
      createError("URL Field cannot be blank.");
    } else {
      console.log( "Submitted: " + linkTarget );
    }


  });

  function createError(msg){
    e.preventDefault();
    var alertDiv = $("<div>");
    alertDiv.addClass("alert");
    alertDiv.addClass("alert-status");
    alertDiv.attr("role", "alert");
    alertDiv.html("<p>" + msg + "</p>");
    $(".new_link").append(alertDiv);
    $("#link_target").val("");
  }

});
