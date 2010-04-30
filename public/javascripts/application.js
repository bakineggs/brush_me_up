$(document).ready(function() {
  if ($('body.memos.index').length == 0) {
    window.location.href = '/';
    return;
  }

  notification_timeouts = [];
  $.each(['remembering', 'forgetting'], function(index, update) {
    $('form.' + update).submit(function() {
      $('div.notification').slideUp('fast');
      notification_timeouts.map(clearTimeout);
      var memo = {}
      memo[update] = true;
      $.ajax({
        type: 'PUT',
        url: $('form.' + update).attr('action'),
        dataType: 'json',
        data: { memo: memo },
        success: function(response) {
          var notification = $(document.createElement('div')).addClass('notification').html(response.notice);
          $('body').prepend(notification.hide());
          $('.memo .text').html(response.next_memo.text);
          $('form.remembering, form.forgetting').attr('action', response.next_memo.action);
          $('form.remembering input[type=submit], form.forgetting input[type=submit]').attr('disabled', '');
          notification.slideDown();
          notification_timeouts.push(setTimeout("$('div.notification').slideUp()", 3000));
        }
      });
      return false;
    });
  });
});
