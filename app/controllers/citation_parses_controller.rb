class CitationParsesController < ApplicationController
  def index
  end

  def show
    @parse = CitationParse.complete.last
    render json: @parse.cached_as_json
  end
end
