module NormalizeAuthor
  extend self

  def valid?(surname, name)
    regx = /^[a-zA-Zа-яА-Я]/
    return false unless surname.match?(regx)
    return false unless name.match?(regx)

    true
  end

  def normalize(surname, name)
    "#{name.capitalize} #{surname.capitalize}"
  end

end