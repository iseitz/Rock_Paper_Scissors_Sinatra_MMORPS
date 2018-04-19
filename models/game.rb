class Game

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @player1_score = 0
    @player2_score = 0
    @player1_choice = ""
    @player2_choice = ""
    @players = [player1, player2]
  end

  def play
    params[:computer_choice] = ["rock", "paper", "scissors"].sample

   if  params[:player_choice] == "rock" && params[:computer_choice] == "scisssors"
     session[:message] = "You chose rock, computer chose scissors. Rock beats scissors, you win!"
     session[:player_score] = session[:player_score].to_i + 1
   elsif params[:player_choice] == "paper" && params[:computer_choice] == "rock"
     session[:message] = "You chose paper, computer chose rock. Paper beats rock, you win!"
     session[:player_score] = session[:player_score].to_i + 1
   elsif params[:player_choice] == "scissiors" && params[:computer_choice] == "paper"
     session[:message] = "You chose scissors, computer chose paper. Scissors beat paper, you win!"
       session[:player_score] = session[:player_score].to_i + 1
   elsif params[:player_choice] == "paper" && params[:computer_choice] == "scissors"
     session[:message] = "You chose paper, computer chose scissors. Scissors beat paper, Computer wins!"
     session[:computer_score] = session[:computer_score].to_i + 1
   elsif params[:player_choice] == "rock" && params[:computer_choice] == "paper"
     session[:message] = "You chose rock, computer chose paper. Paper beats rock, Computer wins!"
     session[:computer_score] = session[:computer_score].to_i + 1
   elsif params[:player_choice] == "scissors" && params[:computer_choice] == "rock"
     session[:message] = "You chose scissors, computer chose rock. Rock beats scissors, Computer wins!"
     session[:computer_score] = session[:computer_score].to_i + 1
   else
     session[:message] =  "You and computer chose #{params[:player_choice]}, it's a tie!"
   end
  end

  def computer_wins?
    if @computer_score == 2
      return true
    end
  end

  def player_wins?
    if @player_score == 2
      return true
    end
  end
end
