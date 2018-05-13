function smoothAlert() {
  $(document).ready(function() {
    $('.alert').delay(500).fadeIn('normal', function() {
      $(this).delay(4000).fadeOut();
    });
  });
}

export { smoothAlert };
