class AddViewCountToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :view_count, :integer # , default: 0
  end
end
