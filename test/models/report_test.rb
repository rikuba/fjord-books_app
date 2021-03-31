# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'editable?' do
    alice = create(:user, email: 'alice@example.com')
    bob = create(:user, email: 'bob@example.com')
    report = alice.reports.create(attributes_for(:report))
    assert report.editable?(alice)
    assert_not report.editable?(bob)
  end
end
