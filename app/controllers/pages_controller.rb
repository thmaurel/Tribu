class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :home ]

  SIDES = ["aubergine", "jambon", "olive", "tomate", "ananas", "champi", "chevre", "salade", "white"]
  def home
    session[:round] = 1
    @tuiles = []
    6.times do 
      tuile = []
      3.times {tuile << SIDES.sample}
      @tuiles << tuile
    end
    @tuiles << ["", "", ""]
    @tuiles << ["", "", ""]
    @player = Player.new
    @player = Player.find(params[:player]) if params[:player]


  end

  def rotate
    tuile_init =  params["tuile"].split(",")
    p "LA BOMBASSS"
    p params["miror"]
    tuile_finale = [tuile_init.last, tuile_init.first, tuile_init.second]
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "tuile", locals: {tuile: tuile_finale, attaque: params["attaque"], miror: params["miror"]}, formats: [:html] }
    end
  end

  def start
    @player = Player.create
    redirect_to root_path(player: @player.id)
  end
end