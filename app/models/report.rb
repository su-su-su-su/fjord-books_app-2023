# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :active_mentions, class_name: 'Mention', foreign_key: 'mentioning_report_id', dependent: :destroy, inverse_of: :mentioning_report
  has_many :mentioning_reports, through: :active_mentions, source: :mentioned_report
  has_many :passive_mentions, class_name: 'Mention', foreign_key: 'mentioned_report_id', dependent: :destroy, inverse_of: :mentioned_report
  has_many :mentioned_reports, through: :passive_mentions, source: :mentioning_report

  validates :title, presence: true
  validates :content, presence: true

  after_save :check_for_mentions

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  private

  def check_for_mentions
    new_mentions = parse_mentions_from_text(content)
    old_mentions = active_mentions.pluck(:mentioned_report_id)

    to_add = new_mentions - old_mentions
    to_remove = old_mentions - new_mentions

    to_remove.each do |id|
      mention = active_mentions.find_by(mentioned_report_id: id)
      mention&.destroy
    end

    to_add.each do |id|
      active_mentions.create(mentioned_report_id: id)
    end
  end

  def parse_mentions_from_text(text)
    text.scan(%r{http://localhost:3000/reports/(\d+)}).flatten.map(&:to_i)
  end
end
