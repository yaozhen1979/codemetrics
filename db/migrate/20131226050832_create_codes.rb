class CreateCodes < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.string :code_name
      t.string :code_path
      t.string :code_fmt
      t.text :code_analysis

      t.timestamps
    end
  end
end
