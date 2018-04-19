require 'sinatra'
require 'sinatra/cookies'
require 'pry'
require 'openssl'
require 'uri'
require 'time'
require "openssl"

Dir[settings.root + "/models/*.rb"]. each {|file| require file}


set :bind, '0.0.0.0'  # bind to all interfaces

use Rack::Session::Cookie, {
  secret: "keep_it_secret_keep_it_safe",
}

def generate_hmac(data, secret)
  OpenSSL::HMAC.hexdigest(OpenSSL::Digest::SHA1.new, secret, data)
end

def decode_session(str)
  Marshal.load(URI.decode_www_form_component(str).unpack("m").first)
end
get '/tempered' do

  # session_data = "session[:player_score] = 2"
  @supplied_hmac = "6df4a65ff0eac94f1012e8e3e6ecbb0b36af46e4"
  @session_data = decode_session(@supplied_hmac)
  @secret = "nobody_will_ever_find_me"
  @valid_hmac = generate_hmac(session_data, secret)
  erb :_tempered

end

get '/' do
  if session[:player_score].nil?
    session[:player_score] = 0
    session[:computer_score] = 0
    session[:message] = "Choose: Rock, Paper or Scissors!"
    erb :_choice
  end
  @message = session[:message]

  if session[:player_score] == 2
    session[:winner] = "Human"
    redirect '/_reset'
    erb :_reset
  end

  if session[:computer_score] == 2
    session[:winner] = "Computer"
    redirect '/_reset'
    erb :_reset
  end

  erb :_choice
 end


post '/' do
  params[:computer_choice] = ["rock", "paper", "scissors"].sample

  if  params[:player_choice] == "rock" && params[:computer_choice] == "scisssors"
    session[:player_score] += 1
    session[:message] = "You chose rock, computer chose scissors. Rock beats scissors, you win!"
  elsif params[:player_choice] == "paper" && params[:computer_choice] == "rock"
    session[:player_score] += 1
    session[:message] = "You chose paper, computer chose rock. Paper beats rock, you win!"
  elsif params[:player_choice] == "scissiors" && params[:computer_choice] == "paper"
    session[:player_score] += 1
    session[:message] = "You chose scissors, computer chose paper. Scissors beat paper, you win!"
  elsif params[:player_choice] == "paper" && params[:computer_choice] == "scissors"
    session[:computer_score] += 1
    session[:message] = "You chose paper, computer chose scissors. Scissors beat paper, Computer wins!"
  elsif params[:player_choice] == "rock" && params[:computer_choice] == "paper"
    session[:computer_score] += 1
    session[:message] = "You chose rock, computer chose paper. Paper beats rock, Computer wins!"
  elsif params[:player_choice] == "scissors" && params[:computer_choice] == "rock"
    session[:computer_score] += 1
    session[:message] = "You chose scissors, computer chose rock. Rock beats scissors, Computer wins!"
  else
    session[:message] =  "You and computer chose #{params[:player_choice]}, it's a tie!"
  end
  redirect '/'
  erb :_choice
end


post '/_reset' do
  if params[:player_choice] == "play_again"
    session.delete(:player_score)
    redirect '/'
    erb :_choice
  end
end

get '/_reset' do
  @message = session[:message]
  @end_message = "#{session[:winner]} won this game. Woud you like to play again?"
  erb :_reset
end

# def computer_wins?
#   if
#
#   end
#   return true
# end
#
# def player_wins?
#   if
#
#   end
#   return true
# end
