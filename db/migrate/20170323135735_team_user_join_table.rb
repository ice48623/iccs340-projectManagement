class TeamUserJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_join_table :users, :teams do |t|
      t.index [:user_id, :team_id]
      t.index [:team_id, :user_id]
    end
  end
end
