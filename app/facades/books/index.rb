class Books::Index

  attr_reader :list

  def initialize(**filters)
    @list = Book.filter_by_name(filters[:name])
                .filter_by_author(filters[:author])
                .filter_by_date(filters[:start_date], filters[:end_date])
  end

  def years_info
    @list.group(:date).count.map {|date, count| [date.year, count]}.to_h
  end

  def authors
    Book.distinct(:author).pluck(:author)
  end

end