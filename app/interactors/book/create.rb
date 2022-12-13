class Book::Create
  include Interactor

  before :validate_params

  def call
    book = Book.new(book_params)
    context.fail!(error: book.errors.full_messages.first, code: :unprocessable_entity) unless book.save
  end

  private

  def validate_params
    p context.book_params
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

end