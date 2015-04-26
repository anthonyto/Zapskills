$("#around-me").click(function () {
if ($(this).prop('checked') === true) {
    $('#optional-fields').show();
} else {
    $('#optional-fields').hide();      
}
});