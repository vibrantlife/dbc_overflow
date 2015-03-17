class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :title
      t.string :string
      t.string :content
      t.string :text

      t.timestamps null: false
    end
  end
end
