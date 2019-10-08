# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :name, presence: true

  has_many :activities, dependent: :destroy
  has_many :group_user_mappings, dependent: :destroy
  has_many :groups, through: :group_user_mappings
  has_many :challenge_user_mappings, dependent: :destroy
  has_many :challenges, through: :challenge_user_mappings

  scope :order_newest, lambda {
    order(id: :DESC)
  }
  scope :team_run, lambda {
    where(team: 'BNR')
  }

  def total_activities_in_challenge(challenge)
    result = activities.where(kind: 'Run')
                       .where(start_date_local: (challenge.start_date.beginning_of_day..challenge.end_date.end_of_day))
                       .order_newest
    result = result.select do |activity|
      activity.distance >= challenge.min_distance &&
        activity.pace <= challenge.max_pace &&
        activity.pace >= challenge.min_pace
    end
    if challenge.wo_limit
      result = result.select.with_index do |activity, index|
        pre = result[index - 1]
        if pre && pre.start_date_local.to_date == activity.start_date_local.to_date && pre.distance > activity.distance
          next
        end

        pos = result[index + 1]
        if pos && pos.start_date_local.to_date == activity.start_date_local.to_date && pos.distance > activity.distance
          next
        end

        true
      end
    end
    result
  end

  def update_point_in_challenge(challenge)
    activities = total_activities_in_challenge(challenge)
    mapping = ChallengeUserMapping.find_by(user: self, challenge: challenge)
    total_run_days = activities.map(&:start_date_local).map(&:to_date).uniq.count
    wo_5k_count = activities.select { |a| a.distance >= 5000 }.count
    wo_pace8_count = activities.select { |a| a.pace <= 5000 }.count
    wo_start_5am_count = activities.map(&:start_date_local).select do |date|
      date.hour < 5 || (date.hour == 5 && date.min <= 1)
    end.count
    hm_count = activities.select { |a| a.distance >= 21_100 && a.distance < 42_195 }.count
    fm_count = activities.select { |a| a.distance >= 42_195 }.count
    point = 0
    point += challenge.point_wo_day * total_run_days
    point += challenge.point_wo_5k * wo_5k_count
    point += challenge.point_wo_pace8 * wo_pace8_count
    point += challenge.point_wo_start_5am * wo_start_5am_count
    point += challenge.point_wo_21day * (total_run_days > 21 ? 1 : 0)
    point += challenge.point_wo_hm * hm_count
    point += challenge.point_wo_fm * fm_count
    mapping.update!(point: point)
    total_point = ChallengeUserMapping.where(user: self).pluck(:point).sum
    self.update(total_point: total_point)
  end

  def team_run?
    team == 'BNR'
  end
end
