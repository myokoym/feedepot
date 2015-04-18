ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'test/unit/rails/test_help'

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  startup do
    FactoryGirl.reload
  end

  def normalize_time(response_body)
    pattern = /"\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d{3})?(?:Z|[+-]\d{1,2}:\d{2})"/
    response_body.gsub(pattern) do
       "\"0000-01-01T00:00:00.000Z\""
    end
  end
end
