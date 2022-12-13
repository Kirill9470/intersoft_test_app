class BookSerializer < ActiveModel::Serializer
  attributes :id, :name, :author, :date

  def date
    object.date.strftime('%Y')
  end

end
