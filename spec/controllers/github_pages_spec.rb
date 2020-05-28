require 'rails_helper'

RSpec.describe GithubPagesController, type: :controller do
  describe 'GET #index' do

    before { get :index }

    it 'render template index' do
      should render_template('index')
    end

    it 'have success status' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #search' do

    before { get :search }

    let(:params) do
      {
        q: 'ruby',
        sort: 'best-match',
        order: 'desc',
        page: 1,
        id: 5
      }
    end

    let(:connection) do
      GithubConnection.new(params, 'search', '', 'get')
    end

    it 'render template index' do
      should render_template('search')
    end

    it 'have success status' do
      expect(response).to have_http_status(:success)
    end

    it 'permit params' do
      should permit(:q, :sort, :order, :page).
        for(:search, params: params, verb: :get)
    end

    context 'github connection' do
      it 'instance of GithubConnection' do
        connection.should be_an_instance_of GithubConnection
      end

      it "raise argument error when no params given" do
        expect { GithubConnection.new }.to raise_error(ArgumentError)
      end

      it 'have sent_request method' do
        allow_any_instance_of(GithubConnection).to receive(:sent_request)
      end

      it 'get total data' do
        results = connection.sent_request
        expect(results[:content['total_count']]).not_to be > 0
      end

    end
  end

end