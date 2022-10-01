class PlayersController < ApplicationController
    def create
        @player = Player.create
        redirect_to root_path(player: @player.id)
    end
end
