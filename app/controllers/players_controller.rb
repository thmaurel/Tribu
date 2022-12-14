class PlayersController < ApplicationController
  GAME = {
    aubergine: [1, 1, 2, 2, 2, 2],
    jambon: [4, 4, 4, 5, 5, 6],
    olive: [1, 2, 3, 4, 5, 6],
    tomate: [0, 1, 1, 2, 2, 3],
    ananas: [0, 1, 0, 2, 0, 3],
    champi: [0, 0, 1, 0, 0, 1],
    chevre: [0, 1, 0, 1, 0, 1],
    salade: [0, 1, 1, 2, 2, 3]
  }

  def create
    @player = Player.create(player_params)
    redirect_to root_path(player: @player.id)
  end

  def play
    players = []
    stats = %w(aubergine jambon olive ananas champi chevre tomate salade attaque)
    @player = Player.find(params[:player])
    @round = Round.new
    @old_tomate = @player.tomate
    @round.number = @player.rounds.empty? ? 1 : @player.rounds.last.number + 1
    @round.player = @player
    increment_ingredients
    earn_salade
    earn_attaque(players)
    @round.save
    if @player.pv < 30
      render json: {player: @player}
    else
      render json: {win: true, player: @player}
    end
  end

  private

  def player_params
    params.require(:player).permit(:name)
  end

  def earn_salade
    @player.pv += GAME[:salade][@player.salade]
    @round.pv += GAME[:salade][@player.salade]
    @player.save
  end

  def earn_attaque(players)
    @player.attaque = params["attaque"].to_i

    if @old_tomate < 1 && @player.tomate >= 1
      @player.attaque += 1
    end
    if @old_tomate < 3 && @player.tomate >= 3
      @player.attaque += 1
    end
    if @old_tomate < 5 && @player.tomate >= 5
      @player.attaque += 1
    end

    @round.attaque = params["attaque"].to_i

    @player.pv += 1 if @player.attaque > 5
    @round.pv += 1 if @player.attaque > 5

    @player.pv += 1 if @player.attaque > 10
    @round.pv += 1 if @player.attaque > 10

    @player.pv += 1 if @player.attaque > 15
    @round.pv += 1 if @player.attaque > 10

    @player.pv += players.select { |p| p < player.attak }.count
    @round.pv += players.select { |p| p < player.attak }.count

    @player.save
  end

  def increment_ingredients
    @player.aubergine += params["aubergine"].to_i unless params["aubergine"] == ""
    @round.aubergine = params["aubergine"].to_i unless params["aubergine"] == ""

    @player.jambon += params["jambon"].to_i unless params["jambon"] == ""
    @round.jambon = params["jambon"].to_i unless params["jambon"] == ""

    @player.olive += params["olive"].to_i unless params["olive"] == ""
    @round.olive = params["olive"].to_i unless params["olive"] == ""

    @player.ananas += params["ananas"].to_i unless params["ananas"] == ""
    @round.ananas = params["ananas"].to_i unless params["ananas"] == ""

    @player.champi += params["champi"].to_i unless params["champi"] == ""
    @round.champi = params["champi"].to_i unless params["champi"] == ""

    @player.chevre += params["chevre"].to_i unless params["chevre"] == ""
    @round.chevre = params["chevre"].to_i unless params["chevre"] == ""

    @player.tomate += params["tomate"].to_i unless params["tomate"] == ""
    @round.tomate = params["tomate"].to_i unless params["tomate"] == ""

    @player.salade += params["salade"].to_i unless params["salade"] == ""
    @round.salade = params["salade"].to_i unless params["salade"] == ""

    @player.aubergine = 5 if @player.aubergine > 5
    @player.jambon = 5 if @player.jambon > 5
    @player.olive = 5 if @player.olive > 5
    @player.ananas = 5 if @player.ananas > 5
    @player.champi = 5 if @player.champi > 5
    @player.chevre = 5 if @player.chevre > 5
    @player.tomate = 5 if @player.tomate > 5
    @player.salade = 5 if @player.salade > 5

    @player.save
  end
end
