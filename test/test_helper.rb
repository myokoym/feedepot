ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'test/unit/rails/test_help'

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  startup do
    FactoryGirl.reload
  end
end
