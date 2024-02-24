class AddAttributesToStudents < ActiveRecord::Migration[7.1]
  def change
    add_column :students, :descricao, :string
  end
end
