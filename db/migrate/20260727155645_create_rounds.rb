class CreateRounds < ActiveRecord::Migration[7.2]
  def change
    create_table :rounds do |t|
      t.integer :score, null: false
      t.string :date
      t.integer :player_id, null: false
      t.integer :course_id, null: false
      t.timestamps
    end
  end
end
