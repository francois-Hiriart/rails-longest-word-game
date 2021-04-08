require 'json'
require 'open-uri'

class GamesController < ApplicationController

  def new
  @letters = []
  @letters.push(('a'..'z').to_a.sample(10))
  end

  def score

  @word = params[:word]
  @letters = params[:letters]

  retour_api_serialized = open("https://wagon-dictionary.herokuapp.com/#{@word}").read
  @retour_api = JSON.parse(retour_api_serialized)

  if !(@word.upcase.split("").all? { |letter| @letters.count(letter) >= @word.upcase.count(letter) })
    @message = "Sorry, your word is not in the grid..."
    @score = 0
  elsif @retour_api["found"] == false
    @message = "LOL this is not an english word"
    @score = 0
  else
    @message = "Well done, bro"
  end
  end
end
