class GithubPagesController < ApplicationController
  def index
  end

  def search
  	connection = GithubConnection.new(search_params, 'search', '', 'get')
  	@response = connection.sent_request
  end

  private

  def search_params
  	params.permit(:q, :sort, :order, :page)
  end
end
