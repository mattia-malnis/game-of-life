require 'rails_helper'

RSpec.shared_examples "GameRules" do
  describe "#calculate_next_state" do
    it "returns the next state based on rules" do
      generation = Generation.new
      # A cell with fewer than two live neighbors dies
      expect(generation.send(:calculate_next_state, true, 1)).to eq(GameRules::DEAD)
      # A cell with two or three live neighbors survives
      expect(generation.send(:calculate_next_state, true, 2)).to eq(GameRules::ALIVE)
      expect(generation.send(:calculate_next_state, true, 3)).to eq(GameRules::ALIVE)
      # A cell with more than three live neighbors dies
      expect(generation.send(:calculate_next_state, true, 4)).to eq(GameRules::DEAD)
      # A dead cell with exactly three live neighbors becomes alive
      expect(generation.send(:calculate_next_state, false, 3)).to eq(GameRules::ALIVE)
    end
  end

  describe "alive?" do
    it "returns true if the cell is alive" do
      generation = Generation.new(matrix: "...\n.*.")
      expect(generation.send(:alive?, 1, 1)).to be_truthy
    end

    it "returns false if the cell is dead" do
      generation = Generation.new(matrix: "...\n.*.")
      expect(generation.send(:alive?, 2, 0)).to be_falsy
    end
  end
end
