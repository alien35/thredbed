$(function(){
    $(".reply_button").click(function () {
      $(this).parent().children('*').show();
    });
    $(".cancel_btn").click(function(){
      $(this).parent().parent().hide();
    });
});
