require 'rails_helper'

RSpec.shared_examples "MatrixParseable" do
  describe "#matrix_array" do
    it "returns the matrix as a bidimensional array" do
      generation = Generation.build(matrix: ".*.\n..*\n*..")
      expect(generation.matrix_array).to eq([[".", "*", "."], [".", ".", "*"], ["*", ".", "."]])
    end
  end

  describe "#normalize_fields" do
    it "returns strip the matrix" do
      generation = Generation.build(matrix: ".*.\n..*\n*..\n")
      generation.valid?
      expect(generation.matrix).to eq(".*.\n..*\n*..")
    end
  end
end
