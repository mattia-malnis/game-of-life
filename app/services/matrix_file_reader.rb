class MatrixFileReader
  attr_reader :generation_number, :rows, :columns, :data

  def initialize(file_content)
    # use compact_blank to remove extra brake lines inserted by mistake
    @lines = file_content.lines.compact_blank.map(&:strip)
    parse_content
  end

  private

  def parse_content
    @generation_number = parse_generation_number
    @rows, @columns = parse_dimensions
    @data = parse_data
  end

  def parse_generation_number
    r = /Generation: (\d+)/
    return unless @lines[0] && @lines[0].match?(r)

    @lines[0].match(r)[1].to_i
  end

  def parse_dimensions
    return [] if @lines[1].blank?

    @lines[1].split.map(&:to_i)
  end

  def parse_data
    @lines[2..-1].try(:join, "\n")
  end
end
