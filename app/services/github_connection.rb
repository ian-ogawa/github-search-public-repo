class GithubConnection
  include PaginationTally
  attr_reader :query_params, :request_method, :url
  URL = 'https://api.github.com'

  def initialize(request_params, request_type, url, request_method = 'get')
    @query_params = request_params
    @url = get_url(request_type, url)
    @request_method = request_method
  end

  def sent_request
    hydra = Typhoeus::Hydra.hydra

    request = Typhoeus::Request.new(url,
      method: request_method.to_sym,
      params: query_params.to_query
    )

    hydra.queue request
    hydra.run

    { code: request.response.code, content: request.response.code == 200 ? JSON.parse(request.response.body) : {}, pagination: get_pagination(request.response.headers, JSON.parse(request.response.body)) }
  end

  def get_url(request_type, url)
    return url.blank? ? "#{URL}/#{get_path(request_type)}" : url
  end

  def get_path(request_type)
    return 'search/repositories' if request_type.eql?('search')
  end

  def get_pagination(headers, body)
    if headers['link'].present?
      cleaned_string = headers['link'].gsub(/[<>\;]/, '')
      splitted_link = cleaned_string.split(', ')
      next_page = splitted_link.find { |e| /next/ =~ e }
      last_page = get_last_page(splitted_link)
      total = (body['total_count'].to_i / 30.0).ceil
      min_page = get_min(query_params[:page].to_i, last_page)

      {
        prev: query_params[:page].to_i - 1,
        next: next_page.nil? ? 0 : next_page.match(/page=(\d+).*$/)[1],
        last: last_page == 0 ? query_params[:page].to_i : last_page,
        current: query_params[:page],
        total: total,
        min: min_page,
        max: get_max(query_params[:page].to_i, last_page)
      }
    end
  end
end
