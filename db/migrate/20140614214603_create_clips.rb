class CreateClips < ActiveRecord::Migration
  def change
    create_table :clips do |t|
      t.belongs_to :user
      t.text :clip_link
      t.timestamps
    end
  end
end
