$(document).ready(function() {
  if ($('body.memos.index').length == 0) {
    window.location.href = '/';
    return;
  }

  notification_timeouts = [];
  $.each(['remembering', 'forgetting'], function(index, update) {
    $('form.' + update).submit(function() {
      $('form.remembering input[type=submit], form.forgetting input[type=submit]').attr('disabled', 'disabled');
      $('div.notification').slideUp('fast', function() { $(this).remove(); });
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
          var to_go = parseInt($('#to_go .count').html());
          if (to_go > 0) {
            to_go--;
            $('#to_go .count').html(to_go);
          }
          notification.slideDown();
          notification_timeouts.push(setTimeout("$('div.notification').slideUp(function() { $(this).remove(); })", 3000));
        }
      });
      return false;
    });
  });

  $('a.new_memo').click(function() {
    $('form.new_memo').show();
    return false;
  });

  $('form.new_memo a.cancel').click(function() {
    $('form.new_memo').hide();
    return false;
  });

  $('form.new_memo').submit(function() {
    $('form.new_memo input[type=submit]').attr('disabled', 'disabled');
    $('div.notification').slideUp('fast', function() { $(this).remove(); });
    notification_timeouts.map(clearTimeout);
    $('form.new_memo').hide();
    $.ajax({
      type: 'POST',
      url: $('form.new_memo').attr('action'),
      dataType: 'json',
      data: { memo: { text: $('form.new_memo textarea').val() } },
      success: function(response) {
        var notification = $(document.createElement('div')).addClass('notification').html(response.notice);
        $('body').prepend(notification.hide());
        $('form.new_memo input[type=submit]').attr('disabled', '');
        notification.slideDown();
        notification_timeouts.push(setTimeout("$('div.notification').slideUp(function() { $(this).remove(); })", 3000));
      }
    });
    return false;
  });
});
