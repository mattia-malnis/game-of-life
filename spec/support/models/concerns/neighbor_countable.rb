require 'rails_helper'

RSpec.shared_examples "NeighborCountable" do
  describe "count_alive_neighbors" do
    it "counts the number of alive neighbors" do
      generation = Generation.create(counter: 1, columns: 5, rows: 3, matrix: "..*..\n.**..\n.*..*")
      expect(generation.send(:count_alive_neighbors, 2, 0)).to eq(2)
      expect(generation.send(:count_alive_neighbors, 2, 1)).to eq(3)
      expect(generation.send(:count_alive_neighbors, 4, 2)).to eq(0)
    end
  end
end
