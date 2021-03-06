ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'test/unit/rails/test_help'

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  startup do
    DatabaseRewinder.clean_all
    FactoryGirl.reload
  end

  teardown do
    DatabaseRewinder.clean
  end

  def normalize(response_body)
    normalize_id(normalize_time(response_body))
  end

  def normalize_id(response_body)
    response_body.gsub(/"id":\d+/).with_index do |_match, i|
      "\"id\":#{i + 1}"
    end
  end

  def normalize_time(response_body)
    pattern = /"\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d{3})?(?:Z|[+-]\d{1,2}:\d{2})"/
    response_body.gsub(pattern) do
       "\"0000-01-01T00:00:00.000Z\""
    end
  end
end
