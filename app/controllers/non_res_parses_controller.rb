class NonResParsesController < ApplicationController
  def index
  end

  def show
    @parse = NonResParse.complete.last
    render json: @parse.cached_as_json
  end
end
