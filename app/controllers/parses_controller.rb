class ParsesController < ApplicationController
  def index
  end

  def show
    @parse = NonResParse.complete.includes(data: :position).last
    render json: @parse.as_json(include: { data: { include: [:position] } })
  end
end
