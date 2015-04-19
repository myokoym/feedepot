require 'test_helper'

class FeedsControllerTest < ActionController::TestCase
  sub_test_case("get index") do
    test "one feed" do
      create(:feed)
      get :index
      assert_response :success
      assert_equal({
                     "feeds" => [
                       {
                         "id" => 1,
                         "link" => "http://example.com/1",
                         "created_at" => "0000-01-01T00:00:00.000Z",
                         "updated_at" => "0000-01-01T00:00:00.000Z",
                       },
                     ],
                   },
                   JSON.parse(normalize(response.body)))
    end
  end

  sub_test_case("get show") do
    test "one feed" do
      feed = create(:feed)
      get :show, id: feed.id
      assert_response :success
      assert_equal({
                     "feed" => {
                       "id" => 1,
                       "link" => "http://example.com/1",
                       "created_at" => "0000-01-01T00:00:00.000Z",
                       "updated_at" => "0000-01-01T00:00:00.000Z",
                     },
                   },
                   JSON.parse(normalize(response.body)))
    end
  end

  sub_test_case("post collect") do
    setup do
      @resource = create(:resource, id: 222)
      @feeds = []
      feed = create(:feed,
                    {
                      id: 777,
                      title: "Title",
                      link: "http://example.com/777",
                      description: "Description",
                      date: Time.now,
                      resource: @resource,
                    })
      @feeds << feed
    end

    test "success" do
      mock(Feed).parse(@resource) { @feeds }
      post :collect, resource_id: @resource.id

      assert_response :success
      assert_equal("application/json", response.content_type)
      assert_equal({
                     "feeds" => [
                       "feed" => {
                         "id" => 777,
                         "link" => "http://example.com/777",
                         "title" => "Title",
                         "description" => "Description",
                         "date" => "0000-01-01T00:00:00.000Z",
                         "resource_id" => 222,
                         "created_at" => "0000-01-01T00:00:00.000Z",
                         "updated_at" => "0000-01-01T00:00:00.000Z",
                       },
                     ],
                   },
                   JSON.parse(normalize_time(response.body)))
    end

    test "failure" do
      post :collect, resource: nil

      assert_response 400
      assert_equal("application/json", response.content_type)
      assert_equal({
                     "error" => {
                       "code" => "0001-400",
                       "message" => "Couldn't find Resource with 'id'=",
                       "time" => "0000-01-01T00:00:00.000Z",
                     },
                   },
                   JSON.parse(normalize_time(response.body)))
    end
  end
end
