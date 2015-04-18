require 'test_helper'

class ResourcesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show, id: 1
    assert_response :success
  end

  sub_test_case("post create") do
    setup do
      @url = "http://example.com/rss"
      @resource = {}
      @resource["id"] = 555
      @resource["xml_url"] = @url
      @resource["title"] = "Title"
      @resource["html_url"] = nil
      @resource["description"] = nil
      mock(Resource).parse(@url) { @resource }
    end

    test "success" do
      post :create, url: @url

      assert_response :success
      assert_equal("application/json", response.content_type)
      assert_equal({
                     "resource" => {
                       "category"=>nil,
                       "created"=>nil,
                       "created_at"=> "0000-01-01T00:00:00.000Z",
                       "description"=>nil,
                       "html_url"=>nil,
                       "id" => 555,
                       "is_breakpoint"=>nil,
                       "is_comment"=>nil,
                       "language"=>nil,
                       "text"=>nil,
                       "title"=>"Title",
                       "updated_at"=>"0000-01-01T00:00:00.000Z",
                       "url"=>nil,
                       "version"=>nil,
                       "xml_url"=>"http://example.com/rss",
                     },
                   },
                   JSON.parse(normalize_time(response.body)))
    end
  end
end
