$(document).ready(function(){
    //Check if the current URL contains '#'
    if(document.URL.indexOf("#")==-1){
        // Set the URL to whatever it was plus "#".
        url = document.URL+"#";
        location = "#";

        //Reload the page
        location.reload(true);
    }
});

$(document).ready(function() {
  function myFunction() {
    location.reload();
}
  $(".reply_button").click(function () {
      $(this).siblings('.response_form_hide').show();
    });
})
