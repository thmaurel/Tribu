# Ca c'est les valeurs du board de chaque joueur
GAME = {
    aubergine:  [1, 1, 2, 2, 2, 2],
    jambon:     [4, 4, 4, 5, 5, 6],
    olive:      [1, 2, 3, 4, 5, 6],
    tomate:     [0, 1, 1, 2, 2, 3],
    ananas:     [0, 1, 0, 2, 0, 3],
    champi:     [0, 0, 1, 0, 0, 1],
    chevre:     [0, 1, 0, 1, 0, 1],
    salade:     [0, 1, 1, 2, 2, 3]
}

# La je définis un joueur
class Player
    attr_reader :attak, :name, :salade, :tomate, :type
    attr_accessor :pv

    # Ca c'est pr le créer, j'initie mass variables
    def initialize(attr = {})
        @name = attr[:name] || "Player"
        @aubergine = attr[:aubergine] || 0
        @jambon = attr[:jambon] || 0
        @olive = attr[:olive] || 0
        @tomate = attr[:tomate] || 0
        @ananas = attr[:ananas] || 0
        @champi = attr[:champi] || 0
        @chevre = attr[:chevre] || 0
        @salade = attr[:salade] || 0

        @type = attr[:type] || "rand"
        @attak = attr[:attak] || 0
        @pv = attr[:pv] || 0
        @nb_cartes = attr[:nb_cartes] || 4
        @nb_niv2_max = attr[:nb_niv2_max] || 1
        @niv2 = attr[:niv2] || 0
    end

    # Ca c'est ce qu'il fait a chaque tour, en gros il calcule son attaque et il update ses couleurs (atm que rouge ou vert)
    def increment
        # cartes niveau 1 x rand(0..2) + cartes niveau 2 x rand(2..4)
        @attak = (@nb_cartes - [@nb_niv2_max,  @niv2].min) * rand(0..2) + [@nb_niv2_max,  @niv2].min * rand(2..4)
        # et on ajoute la valeur de tomate
        @attak += GAME[:tomate][@tomate]

        # ca c'est la galère de modéliser le tour de notre bot
        case @type
        when "salade"
            @salade += 2 unless @salade == 5
            @salade = 5 if @salade > 5
        when "tomate"
            @tomate += 2 unless @tomate == 5
            @tomate = 5 if @tomate > 5
        end
    end
end


# La je définis ce qu'il se passe pendant un tour
def one_round(players)
    # chaque joueur s'incrémente
    players.each do |player|
        player.increment
    end
    # chaque joueur gagne les pv par rapport à l'attaque des autres
    players.each do |player|
        player.pv += players.select{|p| p.attak < player.attak}.count
    end
    # chaque joueur gagne ses points de salade
    players.each do |player|
        player.pv += GAME[:salade][player.salade]
    end
    # chaque joueur gagne des pv s'il a une attaque sup a 5, 10, 15
    players.each do |player|
        player.pv += 1 if player.attak > 5
        player.pv += 1 if player.attak > 10
        player.pv += 1 if player.attak > 15
    end
end

# ptite fonction pour trouver si qqn a win
def win?(players)
    players.find{|x| x.pv >= 30}
end

# nb de parties de test par essai
nb_game = 200

# et je fais 10 essais donc ya 10 x nb_game parties simulées
10.times do 
    # ca c'est pour savoir qui gagne et le nb de tour
    res = [0, 0, 0, 0]
    t = 0

    nb_game.times do |game|
        # j'crée 4 joueurs ac des strats tomate ou salade
        player1 = Player.new(name: "Player 1", type: "tomate")
        player2 = Player.new(name: "Player 2", type: "tomate")
        player3 = Player.new(name: "Player 3", type: "salade")
        player4 = Player.new(name: "Player 4", type: "salade")

        # hop là, on les fout autour d'une table
        players = [
            player1,
            player2, 
            player3,
            player4
        ]

        # et ca commence!
        tour = 1

        # tant que ya pas de vainqueur bah on spam la fonction qui joue un tour
        until win?(players)
            #puts "TOUR ##{tour}"
            one_round(players)

            #puts players.map{|x| "#{x.name} (type: #{x.type} - salade: #{x.salade} - tomate: #{x.tomate}. Attaque: #{x.attak}. PV: #{x.pv}"}
            tour += 1
        end

        # et la en fonction du vainqueur, on met a jour notre tableau de stat
        case win?(players)
        when player1 then res[0] += 1
        when player2 then res[1] += 1
        when player3 then res[2] += 1
        when player4 then res[3] += 1
        end
        t += tour
    end

    p res
    p t/nb_game.to_f
end
#gg vert