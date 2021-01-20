class EduParsesController < ApplicationController
  def index
  end

  def show
    @parse = EduParse.complete.last
    render json: @parse.cached_as_json
  end
end
