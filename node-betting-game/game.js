var prompt = require('sync-prompt').prompt;

var bankroll = 100;
startGame();

function setupGame() {
  bankroll = 100;
}

function endGame() {
  if (bankroll <= 0) {
    console.log("Game over-you have no money left!");
    return true;
  }
}

function startGame() {
  var bet = prompt("Place a bet between $5-10: ");
  var guess = prompt("Guess a number between 1-10: ");
  var answer = Math.floor(Math.random() * 10) + 1;
    
  guess = parseInt(guess);
  bet = parseInt(bet);
  checkGuess(guess, bet, answer);

  if (!endGame()) {
    startGame();
  } 
}

function checkGuess(guess, bet,answer) {
  if (guess === answer) {
    console.log("Correct! You won $", bet);
    bankroll += bet;
  }
  else if (Math.abs(answer - guess) === 1) {
    console.log("You were off by 1");
  }
  else {
    console.log("Wrong! The correct answer was", answer);
    console.log("You lost $", bet);
    bankroll -= bet;
  }
  
  console.log("You have $", bankroll, "left \n");
}
