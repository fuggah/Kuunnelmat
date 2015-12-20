class TagsAdd < ActiveRecord::Migration
  def change
		create_table :tags do |t|
			t.string :tag, :null => false

			t.timestamps null: false
		end

		create_table :kuunnelmatags do |t|
			t.belongs_to :kuunnelma, :null => false, :index => true
			t.belongs_to :tag, :null => false, :index => true
			
			t.timestamps null: false
		end
  end
end
