class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  SIDES = ["aubergine", "jambon", "olive", "tomate", "ananas", "champi", "chevre", "salade", "white"]
  def home
    session[:round] = 1
    @tuiles = []
    6.times do 
      tuile = []
      3.times {tuile << SIDES.sample}
      @tuiles << tuile
    end
  end
end