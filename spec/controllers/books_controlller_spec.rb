require 'rails_helper'

RSpec.describe BooksController, type: :controller do

  let!(:books) { FactoryBot.create_list(:book, 30, date: Date.new(2000)) }

  let!(:book_2021_author_1) { FactoryBot.create(:book, author: 'Иван Иванов', date: Date.new(2021), name: 'Приключения в ночи') }
  let!(:book_2021_author_2) { FactoryBot.create(:book, author: 'Harry Potter', date: Date.new(2021), name: 'Хорошие приключения')}
  let!(:book_2021_author_3) { FactoryBot.create(:book, author: 'Петр Петров', date: Date.new(2021), name: 'Новые приключения друзей') }
  let!(:book_2022_author_1) { FactoryBot.create(:book, author: 'Марк Жуков', date: Date.new(2022), name: 'Приключения') }

  let!(:update_book) { FactoryBot.create(:book, author: 'Иван Иванов', date: Date.new(2021), name: 'Update Book') }

  context 'GET#index' do

    it 'returns 200 HTTP status' do
      get :index, params: { name: 'приключения',
                            author: ['Иван Иванов', 'Harry Potter', 'Петр Петров', 'Марк Жуков'],
                            start_date: '2021',
                            end_date: '2022' }

      body = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(body['books'].count).to eq(4)
    end

  end

  context 'POST#create' do

    it 'returns 200 HTTP status' do
      post :create, params: { name: 'New Book', surname_author: 'Petrov', name_author: 'Петр', date: 2000 }
      expect(response).to have_http_status(:ok)
    end

    it 'returns 4** HTTP status' do
      post :create, params: { name: 'New Book', surname_author: 'Petrov', name_author: 'Петр' }
      expect(response).to have_http_status(:unprocessable_entity)
    end

  end

  context 'PUT#update' do

    it 'returns 200 HTTP status' do
      put :update, params: { id: update_book.id, name: 'New Book', surname_author: 'Petrov', name_author: 'Петр', date: 2000 }
      expect(response).to have_http_status(:ok)
    end

    it 'returns 404 HTTP status' do
      put :update, params: { id: 1000023234, name: 'New Book', surname_author: 'Petrov', name_author: 'Петр', date: 2000 }
      expect(response).to have_http_status(:not_found)
    end

    it 'returns 422 HTTP status' do
      put :update, params: { id: update_book.id, name: 'New Book', surname_author: 'Petrov', name_author: 'Петр' }
      expect(response).to have_http_status(:unprocessable_entity)
    end

  end

end