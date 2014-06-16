class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
    	t.belongs_to	:user
    	t.belongs_to 	:clip
    	t.boolean		:like

    	t.timestamps
    end
  end
end
