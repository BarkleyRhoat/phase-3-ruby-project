class AddUniqueIndexesToPlayersAndCourses < ActiveRecord::Migration[7.2]
  def change
    add_index :players, :name, unique: true
    add_index :courses, :name, unique: true
  end
end
