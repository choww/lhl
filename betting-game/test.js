/*** 
 * GAME RULES
 * start w/ 100$
 * game generates a random # [btwn 1-10]
 * game ask player to bet 5-10$ to guess the #
 * if guess exact # --> win by amt they bet
 * if guess off by 1 --> don't loose $
 * if wrong guess --> loose amt they bet
 * game end if player looses all $
***/

//default setting
$(document).ready(function() {

  var bankroll = 100;
  setupGame();
  
  function setupGame() {
    $('#bankroll').text('$' + 100);
    $('#player-input input[type="sumbit"]').prop('disabled', false);
    $('#outcome').empty();
    $('#result').empty();
    $('#game-over').hide();
  }
  
  function endGame() {
    if (bankroll <= 0) {
      game_over = 'You have no money left!';
      $('<h2>').text(game_over).prependTo('#game-over');
      $('#player-input input[type="submit"]').prop('disabled', true);
       
      $('#game-over').show();
      $('#game-btn').show();
    }
  }
  
  $('#game-btn').click(function() {
    setupGame();
  });
  
  $('#player-input').on('submit', function(e) {
    e.preventDefault();
    $('.validation').remove();

    var params = $(this).serializeArray();
    var bet = parseInt(params[0].value);
    var guess = parseInt(params[1].value);
  
    var answer = Math.floor(Math.random() * 10) + 1;
    checkGuess(guess, bet, answer);
  
    $('#result').empty();
    $('<p>').text('Your guess: ' + guess).appendTo('#result');
    $('<p>').text('Answer: ' + answer).appendTo('#result');

    endGame();  
  });

  function checkGuess(guess, bet, answer) {
    $('#outcome').removeClass();

    if (guess == answer) {
      $('#outcome').html('Correct! $' + bet + ' added!');
      $('#outcome').addClass('correct');
      bankroll += bet;
    }
    else if (Math.abs(answer - guess) === 1) {
      $('#outcome').html('You were off by 1!');
      $('#outcome').addClass('off-by-1');
    }
    else {
      $('#outcome').html('Wrong! $' + bet + ' lost!');
      $('#outcome').addClass('wrong');
      bankroll -= bet;
    }
    $('#bankroll').html('$' + bankroll);
  }

});
