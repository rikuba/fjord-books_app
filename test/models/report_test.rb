# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'editable?' do
    report = reports(:alices_report)
    alice = users(:alice)
    bob = users(:bob)
    assert report.editable?(alice)
    assert_not report.editable?(bob)
  end
end
