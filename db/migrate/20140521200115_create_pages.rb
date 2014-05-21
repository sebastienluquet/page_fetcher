class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :page_id
      t.string :name
      t.string :picture

      t.timestamps
    end
  end
end
