class ResourcesController < ApplicationController
  def index
    resources = Resource.all.collect do |resource|
      resource.attributes.compact
    end

    response_body = {
      "resources" => resources
    }

    render json: response_body
  end

  def show
    id = params[:id]
    resource = Resource.find_by(id: id)

    unless resource
      render_error(404, "Not found: <#{id}>")
    end

    response_body = {
      "resource" => resource.attributes.compact
    }

    render json: response_body
  end

  def create
    begin
      columns = Resource.parse(params[:url])
    rescue
      render_error(400, $!.message)
      return
    end
    resource = Resource.create(columns)

    response_body = {
      resource: resource.attributes.compact
    }

    render json: response_body
  end
end
