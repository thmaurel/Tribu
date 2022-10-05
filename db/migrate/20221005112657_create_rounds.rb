class CreateRounds < ActiveRecord::Migration[7.0]
  def change
    create_table :rounds do |t|
      t.integer :number
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
      t.references :player, null: false, foreign_key: true

      t.timestamps
    end
  end
end
