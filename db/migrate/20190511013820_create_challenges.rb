class CreateChallenges < ActiveRecord::Migration[5.2]
  def change
    create_table :challenges do |t|
      t.string :name
      t.integer :year
      t.integer :month
      t.date :start_date
      t.date :end_date
      t.integer :min_distance, default: 2000
      t.integer :min_pace, default: 2
      t.integer :max_pace, default: 12
      t.integer :min_trail_pace, default: 2
      t.integer :max_trail_pace, default: 30
      t.integer :min_trail_elevation_gain, default: 300
      t.integer :point_wo_day, :integer, null: false, default: 0
      t.integer :point_wo_5k, :integer, null: false, default: 0
      t.integer :point_wo_pace8, :integer, null: false, default: 0
      t.integer :point_wo_start_5am, :integer, null: false, default: 0
      t.integer :point_wo_21day, :integer, null: false, default: 0
      t.integer :point_wo_hm, :integer, null: false, default: 0
      t.integer :point_wo_fm, :integer, null: false, default: 0
      t.integer :point_wo_finish_21day, :integer, null: false, default: 0
      t.boolean :wo_limit, default: false

      t.timestamps
    end
  end
end
