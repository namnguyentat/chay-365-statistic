class CreateChallengeUserMappings < ActiveRecord::Migration[5.2]
  def change
    create_table :challenge_user_mappings do |t|
      t.references :user, foreign_key: true
      t.references :challenge, foreign_key: true
      t.integer :target, default: 0
      t.float :total, default: 0
      t.integer :point, default: 0

      t.timestamps
    end
  end
end
