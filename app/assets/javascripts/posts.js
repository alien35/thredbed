$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})

$(function () {
  $('[data-toggle="popover"]').popover()
})

$('#search').keypress(function (e) {
    var str = $('#search').val();
    var domain = "http://www.thredbed.com";
    var url = domain+"default.aspx?search=" + str;
    if (e.keyCode == 13) {
        location.href = url;
    }
});
