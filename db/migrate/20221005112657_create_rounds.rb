class CreateRounds < ActiveRecord::Migration[7.0]
  def change
    create_table :rounds do |t|
      t.integer :number
      t.integer :aubergine
      t.integer :jambon
      t.integer :olive
      t.integer :tomate
      t.integer :ananas
      t.integer :champi
      t.integer :chevre
      t.integer :salade
      t.integer :attaque
      t.integer :pv
      t.references :player, null: false, foreign_key: true

      t.timestamps
    end
  end
end
