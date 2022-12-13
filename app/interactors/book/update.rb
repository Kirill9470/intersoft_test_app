class Book::Update
  include Interactor

  before :validate_params, :set_book

  def call
    unless context.book.update(book_params)
      context.fail!(error: book.error.full_message.first, code: :unprocessable_entity)
    end
  end

  private

  def validate_params
    require_params.each do |params|
      context.fail!(error: "#{params} missing", code: :unprocessable_entity) if context.book_params[params].blank?
    end

    unless NormalizeAuthor.valid?(context.book_params[:surname_author], context.book_params[:name_author])
      context.fail!(error: 'author full name unformatted', code: :unprocessable_entity)
    end
  end

  def book_params
    {
        name: context.book_params[:name],
        author: NormalizeAuthor.normalize(context.book_params[:surname_author], context.book_params[:name_author]),
        date: Date.new(context.book_params[:date].to_i)
    }
  end

  def require_params
    [:name, :surname_author, :name_author, :date]
  end

  def set_book
    context.book = Book.find_by_id(context.book_id)
    context.fail!(error: 'book not found', code: :not_found) if context.book.nil?
  end

end