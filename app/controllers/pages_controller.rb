class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :home ]

  SIDES = ["aubergine", "jambon", "olive", "tomate", "ananas", "champi", "chevre", "salade", "white"]

  def home
    session[:round] = 1
    @tuiles = []
    @attaques = []
    6.times do
      tuile = []
      3.times { tuile << SIDES.sample }
      @tuiles << tuile
      @attaques << compute_attaque(tuile)
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
    attaque = compute_attaque(tuile)
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "tuile", locals: { tuile:, attaque:, miror: "" }, formats: [:html] }
    end
  end

  def piocheup
    tuile = [SIDES.sample, SIDES.sample, SIDES.sample]
    attaque = [compute_attaque(tuile) + 2, 3].max
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "tuile2", locals: { tuile:, attaque:, miror: "" }, formats: [:html] }
    end
  end

  private

  def compute_attaque(tuile)
    if tuile.uniq.reject{ |c| c == "white" }.length == 3
      rand(0..2).zero? ? 1 : 0
    elsif tuile.uniq.length == 2 && !tuile.include?("white")
      rand(0..2).zero? ? 0 : 1
    elsif tuile.uniq.length == 3
      rand(0..2).zero? ? 2 : 1
    elsif tuile.uniq.length < 3 && tuile.count { |t| t == "white" } < 2
      rand(0..2).zero? ? 1 : 2
    elsif tuile.uniq.length == 2 && tuile.count { |t| t == "white" } == 2
      rand(0..2).zero? ? 3 : 2
    elsif tuile.uniq == ["white"]
      3
    else
      10
    end
  end
end
