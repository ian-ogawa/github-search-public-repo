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

  let(:connection) { GithubConnection.new(params, 'search', '', 'get') }

  describe 'creating' do
    context 'when param received' do
      it 'instant variabe have a value' do
        expect(connection.query_params).to eq(params)
        expect(connection.url).to eq("https://api.github.com/search/repositories")
        expect(connection.request_method).to eq('get')
      end
    end

    context 'when params is not received' do
      it 'raise ArgumentError' do
        expect { GithubConnection.new }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#get_url' do
    context 'params url blank' do
      it 'return repos search url' do
        expect(connection.get_url('search', '')).to eq('https://api.github.com/search/repositories')
      end
    end

    context 'params url not blank' do
      it 'return params url' do
        params_url = 'https://api.github.com/'

        expect(connection.get_url('search', params_url)).to eq(params_url)
      end
    end
  end

  describe '#get_path' do
    context 'params request_type is search' do
      it 'return repos search path' do
        expect(connection.get_path('search')).to eq('search/repositories')
      end
    end

    context 'params request_type is not search' do
      it 'return nil' do
        expect(connection.get_path('list')).to eq(nil)
      end
    end
  end

end