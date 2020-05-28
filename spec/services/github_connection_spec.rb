require 'rails_helper'

RSpec.describe GithubConnection do
  let(:params) do
    {
      q: 'ruby',
      sort: 'best-match',
      order: 'desc',
      page: 1,
      id: 5
    }
  end

  describe 'creating' do
    it 'instant variabe have a value when param received' do
      connection = GithubConnection.new(params, 'search', '', 'get')

      expect(connection.query_params).to eq(params)
      expect(connection.url).to eq("https://api.github.com/search/repositories")
      expect(connection.request_method).to eq('get')
    end

    it 'raise ArgumentError when params is not received' do
      expect { GithubConnection.new }.to raise_error(ArgumentError)
    end
  end

  describe '#sent_request' do

  end

end