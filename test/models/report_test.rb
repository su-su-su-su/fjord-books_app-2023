# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'editable?' do
    me = User.create!(email: 'me@example.com', name: 'me', password: 'password')
    she = User.create!(email: 'she@example.com', name: 'she', password: 'password')

    report = Report.create!(user: me, title: 'test', content: 'test')

    assert_equal true, report.editable?(me)
    assert_equal false, report.editable?(she)
  end

  test 'created_on' do
    user = User.create!(email: 'user@example.com', name: 'user', password: 'password')

    report = Report.create!(user:, title: 'test', content: 'test')

    assert_equal Time.zone.today, report.created_at.to_date
  end
end
