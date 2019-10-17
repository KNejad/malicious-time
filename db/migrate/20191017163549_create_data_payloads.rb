class CreateDataPayloads < ActiveRecord::Migration[6.0]
  def change
    create_table :data_payloads do |t|
      t.string :data

      t.timestamps
    end
  end
end
