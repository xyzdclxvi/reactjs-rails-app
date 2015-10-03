class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.integer :user_id
      t.integer :announcement_id
      t.string :status

      t.timestamps
    end
  end
end
