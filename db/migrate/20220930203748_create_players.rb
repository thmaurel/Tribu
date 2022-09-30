class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.string :name
      t.integer :aubergine, default: 0
      t.integer :jambon, default: 0
      t.integer :olive, default: 0
      t.integer :tomate, default: 0
      t.integer :ananas, default: 0
      t.integer :champi, default: 0
      t.integer :chevre, default: 0
      t.integer :salade, default: 0
      t.integer :attaque, default: 0
      t.integer :pv, default: 0

      t.timestamps
    end
  end
end
