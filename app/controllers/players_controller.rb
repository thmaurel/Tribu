class PlayersController < ApplicationController
    def create
        @player = Player.create
        redirect_to root_path(player: @player.id)
    end

    def play
        stats = %w(aubergine jambon olive ananas champi chevre tomate salade attaque)
        @player = Player.find(params[:player])
        increment_ingredients

        render json: {player: @player}
    end

    private

    def increment_ingredients
        @player.aubergine += params["aubergine"].to_i unless params["aubergine"] == ""
        @player.jambon += params["jambon"].to_i unless params["jambon"] == ""
        @player.olive += params["olive"].to_i unless params["olive"] == ""
        @player.ananas += params["ananas"].to_i unless params["ananas"] == ""
        @player.champi += params["champi"].to_i unless params["champi"] == ""
        @player.chevre += params["chevre"].to_i unless params["chevre"] == ""
        @player.tomate += params["tomate"].to_i unless params["tomate"] == ""
        @player.salade += params["salade"].to_i unless params["salade"] == ""

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
