class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
    	t.belongs_to :user
    	t.belongs_to :clip
    	t.boolean :like, default: false
    	t.boolean :visible, default: false
    end
  end
end
