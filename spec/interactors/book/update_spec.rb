require 'rails_helper'

RSpec.describe Book::Update, type: :interactor do

  let(:book) { FactoryBot.create(:book, date: Date.new(2000)) }

  context 'success' do

    it do
      result = described_class.call(book_id: book.id, book_params: {name: 'Update Book', surname_author: 'Petrov', name_author: 'Петр', date: 2000})
      expect(result.success?).to be_truthy
    end

  end

  context 'fail' do

    it 'missing params' do
      result = described_class.call(book_id: book.id, book_params: {name: 'New Book', surname_author: 'Petrov', name_author: 'Петр'})
      expect(result.failure?).to be_truthy
    end

    it 'unvalidate surname or name' do
      result = described_class.call(book_id: book.id, book_params: {name: 'New Book', surname_author: '12Petrov', name_author: 'Петр2', date: 2000})
      expect(result.failure?).to be_truthy
    end

    it 'book not found' do
      result = described_class.call(book_id: nil, book_params: {name: 'New Book', surname_author: '12Petrov', name_author: 'Петр2', date: 2000})
      expect(result.failure?).to be_truthy
    end

  end
end