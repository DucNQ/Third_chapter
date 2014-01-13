class RemoveUniqueContextToRelationship < ActiveRecord::Migration
  def change
  	 remove_index :relationships, [:follower_id, :follower_id]
  end
end
