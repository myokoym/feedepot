class FeedsController < ApplicationController
  def index
    feeds = Feed.all.collect do |feed|
      feed.attributes.compact
    end

    response_body = {
      "feeds" => feeds
    }

    render json: response_body
  end

  def show
    id = params[:id]
    feed = Feed.find_by(id: id)

    unless feed
      render_error(404, "Not found: <#{id}>")
    end

    response_body = {
      "feed" => feed.attributes.compact
    }

    render json: response_body
  end

  def collect
    begin
      feeds = Feed.parse(Resource.find(params[:resource_id]))
    rescue
      render_error(400, $!.message)
      return
    end

    response_body = {
      feeds: feeds.collect {|feed| {feed: feed.attributes.compact} }
    }

    render json: response_body
  end
end
