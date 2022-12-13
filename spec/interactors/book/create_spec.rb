require 'rails_helper'

RSpec.describe Book::Create, type: :interactor do

  context 'success' do

    it do
      result = described_class.call(book_params: {name: 'New Book', surname_author: 'Petrov', name_author: 'Петр', date: 2000})
      expect(result.success?).to be_truthy
    end
  end

  context 'fail' do

    it 'missing params' do
      result = described_class.call(book_params: {name: 'New Book', surname_author: 'Petrov', name_author: 'Петр'})
      expect(result.failure?).to be_truthy
    end

    it 'unvalidate surname or name' do
      result = described_class.call(book_params: {name: 'New Book', surname_author: '12Petrov', name_author: 'Петр2', date: 2000})
      expect(result.failure?).to be_truthy
    end

  end

end