class BooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    books_facade = Books::Index.new(name: params[:name],
                                    author: params[:author],
                                    start_date: params[:start_date],
                                    end_date: params[:end_date])

    render json: books_facade.list,
           each_serializer: BookSerializer,
           root: :books, adapter: :json,
           meta: { books_years_info: books_facade.years_info, authors: books_facade.authors },
           status: :ok
  end

  def create
    p book_params
    result = Book::Create.call(book_params: book_params.to_h.symbolize_keys)

    if result.success?
      render json: { message: 'ok' }, status: :ok
    else
      render json: { error: result.error }, status: result.code
    end
  end

  def update
    result = Book::Update.call(book_id: params[:id],
                               book_params: book_params.to_h.symbolize_keys)

    if result.success?
      render json: { message: 'ok' }, status: :ok
    else
      render json: { error: result.error }, status: result.code
    end
  end

  private

  def book_params
    params.permit(:name, :date, :surname_author, :name_author)
  end

end
