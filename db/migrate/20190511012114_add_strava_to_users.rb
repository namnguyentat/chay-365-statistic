# frozen_string_literal: true

class AddStravaToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_admin, :boolean
    add_column :users, :strava_code, :string
    add_column :users, :strava_token, :string
    add_column :users, :strava_athlete_id, :string
    add_column :users, :strava_last_sync_at, :datetime
    add_column :users, :strava_last_token_at, :datetime
    add_column :users, :team, :string
    add_column :users, :strava_refresh_token, :string
    add_column :users, :total_point, :integer, null: false, default: 0
    add_column :users, :level, :integer, null: false, default: 0
  end
end
