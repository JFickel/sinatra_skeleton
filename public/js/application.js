$(document).ready(function() {
  $('.load-gif').on('load', function(){
    $.ajax({
      url: '/retrieve_tweets',
      method: 'post',
      data: {twitter_username: window.location.pathname.split('/')[1]}
    }).done(function(response){
      $('.load-gif').css('display', 'none');
      $('.tweet-output').append(response);
    });
  });
});
