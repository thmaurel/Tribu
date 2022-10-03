class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :home ]

  SIDES = ["aubergine", "jambon", "olive", "tomate", "ananas", "champi", "chevre", "salade", "white"]
  def home
    session[:round] = 1
    @tuiles = []
    6.times do
      tuile = []
      3.times { tuile << SIDES.sample }
      @tuiles << tuile
    end
    @player = Player.new
    @player = Player.find(params[:player]) if params[:player]
    @attributes = {
      aubergine: @player.aubergine,
      jambon: @player.jambon,
      olive: @player.olive,
      ananas: @player.ananas,
      champi: @player.champi,
      chevre: @player.chevre,
      tomate: @player.tomate,
      salade: @player.salade,
      pv: @player.pv
    }
  end

  def rotate
    tuile_init = params["tuile"].split(",")
    tuile_finale = [tuile_init.last, tuile_init.first, tuile_init.second]
    partial = params["lvl"] == "2" ? "tuile2" : "tuile"
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial:, locals: { tuile: tuile_finale, attaque: params["attaque"], miror: params["miror"] }, formats: [:html] }
    end
  end

  def pioche
    tuile = [SIDES.sample, SIDES.sample, SIDES.sample]
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "tuile", locals: { tuile:, attaque: rand(0..2), miror: "" }, formats: [:html] }
    end
  end

  def piocheup
    tuile = [SIDES.sample, SIDES.sample, SIDES.sample]
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "tuile2", locals: { tuile:, attaque: rand(2..4), miror: "" }, formats: [:html] }
    end
  end
end
