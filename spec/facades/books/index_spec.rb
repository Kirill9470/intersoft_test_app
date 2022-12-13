require 'rails_helper'

RSpec.describe Books::Index, type: :facade do

  let!(:books) do
    year = rand(2000..2022)
    FactoryBot.create_list(:book, 30, date: Date.new(year))
  end

  let!(:book_2021_author_1) { FactoryBot.create(:book, author: 'Иван Иванов', date: Date.new(2021), name: 'Приключения в ночи') }
  let!(:book_2021_author_2) { FactoryBot.create(:book, author: 'Harry Potter', date: Date.new(2021), name: 'Хорошие приключения') }
  let!(:book_2021_author_3) { FactoryBot.create(:book, author: 'Петр Петров', date: Date.new(2021), name: 'Новые приключения друзей') }
  let!(:book_2022_author_1) { FactoryBot.create(:book, author: 'Марк Жуков', date: Date.new(2022), name: 'Приключения') }

  context '#list' do

    it 'with filters' do
      facade_1 = described_class.new(name: 'приключения',
                                   author: ['Иван Иванов', 'Harry Potter', 'Петр Петров', 'Марк Жуков'],
                                   start_date: '2021',
                                   end_date: '2022')

      facade_2 = described_class.new(name: 'приключения',
                                   author: 'Иван Иванов',
                                   start_date: '2021',
                                   end_date: '2022')
      list_1 = facade_1.list
      list_2 = facade_2.list

      expect(list_1.count).to eq(4)
      expect(list_1.pluck(:author) - ['Иван Иванов', 'Harry Potter', 'Петр Петров', 'Марк Жуков']).to eq([])
      expect(list_1.pluck(:date).map(&:year) - [2021, 2022]).to eq([])

      expect(list_2.count).to eq(1)
    end

    it 'without filters' do
      facade = described_class.new(name: nil,
                                   author: nil,
                                   start_date: nil,
                                   end_date: nil)
      expect(facade.list.count).to eq(Book.count)
    end

  end

  context '#year_info' do

    it do
      facade = described_class.new(name: nil,
                                   author: nil,
                                   start_date: 2021,
                                   end_date: 2022)
      year_info = facade.years_info
      expect(year_info[2021] > 0).to be_truthy
      expect(year_info[2022] > 0).to be_truthy
    end

  end

end