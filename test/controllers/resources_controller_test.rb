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
    end

    test "success" do
      mock(Resource).parse(@url) { @resource }
      post :create, url: @url

      assert_response :success
      assert_equal("application/json", response.content_type)
      assert_equal({
                     "resource" => {
                       "id" => 555,
                       "xml_url" => "http://example.com/rss",
                       "title" => "Title",
                       "created_at" => "0000-01-01T00:00:00.000Z",
                       "updated_at" => "0000-01-01T00:00:00.000Z",
                     },
                   },
                   JSON.parse(normalize_time(response.body)))
    end

    test "fail" do
      post :create, url: "aaa"

      assert_response 400
      assert_equal("application/json", response.content_type)
      assert_equal({
                     "error" => {
                       "code" => "0001-400",
                       "message" => "ERROR: Invalid URL <aaa>.",
                       "time" => "0000-01-01T00:00:00.000Z",
                     },
                   },
                   JSON.parse(normalize_time(response.body)))
    end
  end
end
