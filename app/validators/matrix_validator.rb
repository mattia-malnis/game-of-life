class MatrixValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if record.rows.blank? || record.columns.blank? || value.blank?

    # create a bidimensional array and use it to run validations. (I.e: [[".", ".", "*"], ["*", "*", "."]])
    matrix = value.split.map { |row| row.chars.compact_blank }

    validate_dimensions(record, attribute, matrix)
    validate_chars(record, attribute, matrix)
  end

  private

  def validate_dimensions(record, attribute, matrix)
    # check that the matrix sizes match the `columns` and `rows` attributes
    if matrix.size != record.rows
      record.errors.add(attribute, :wrong_row_count, expected: record.rows, actual: matrix.size)
    end

    unless matrix.all? { |row| row.size == record.columns }
      record.errors.add(attribute, :wrong_column_count, expected: record.columns)
    end
  end

  def validate_chars(record, attribute, matrix)
    # allow only "." and "*" chars
    invalid_chars = matrix.flatten.uniq - [".", "*"]
    if invalid_chars.any?
      record.errors.add(attribute, :invalid_chars, invalid: invalid_chars.join(", "))
    end
  end
end
