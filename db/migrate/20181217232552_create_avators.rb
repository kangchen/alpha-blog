class CreateAvators < ActiveRecord::Migration[5.2]
  def change
    create_table :avators do |t|
      t.string :uid

      t.timestamps
    end
  end
end
