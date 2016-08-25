
$(function(){


  $(".new_link").submit(function(e){
    var linkTarget = $("#link_target")

    if( linkTarget.val().replace(/ /g, "" ) === "" ){
      e.preventDefault();
      console.log("empty!");

      var alertDiv = $("<div>");
      alertDiv.addClass("alert");
      alertDiv.addClass("alert-status");
      alertDiv.attr("role", "alert");
      alertDiv.html("<p>URL Field cannot be blank.</p>");
      $(".new_link").append(alertDiv);
      linkTarget.val("");

    } else {
      console.log( "Submitted: " + linkTarget );
    }


  });

});
