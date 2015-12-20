class KuunnelmaAdd < ActiveRecord::Migration
  def change
		create_table :kuunnelmas do |t|
			t.string :name
			t.string :author
			t.string :composer
			t.string :note
			t.integer :year

			t.timestamps null: false
		end
  end
end
