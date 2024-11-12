require 'rails_helper'

RSpec.describe MatrixGenerator, type: :service do
  describe "#generator" do
    subject { described_class.new(["..**", "*..*", ".*.*"], 3, 4) }

    it "returns the new matrix" do
      expect(subject.generate).to eq("..**\n.*.*\n..*.")
    end
  end

  describe "#should_be_alive?" do
    subject { described_class.new(["*..*", "...*", ".**."], 3, 4) }

    it "returns true if the cell should be alive" do
      expect(subject.send(:should_be_alive?, 2, 2)).to be_truthy
    end

    it "returns false if the cell should be dead" do
      expect(subject.send(:should_be_alive?, 3, 0)).to be_falsy
    end
  end

  describe "#is_next_state_alive?" do
    subject { described_class.new(["..", ".."], 2, 2) }

    it "returns true if the cell is alive based on the game rules" do
      expect(subject.send(:is_next_state_alive?, true, 2)).to be_truthy
      expect(subject.send(:is_next_state_alive?, true, 3)).to be_truthy
      expect(subject.send(:is_next_state_alive?, false, 3)).to be_truthy
    end

    it "returns false if the cell is dead based on the game rules" do
      expect(subject.send(:is_next_state_alive?, false, 1)).to be_falsy
      expect(subject.send(:is_next_state_alive?, false, 2)).to be_falsy
      expect(subject.send(:is_next_state_alive?, true, 4)).to be_falsy
      expect(subject.send(:is_next_state_alive?, true, 5)).to be_falsy
    end
  end

  describe "#count_alive_neighbors" do
    it "counts alive neighbors of a cell" do
      generation = described_class.new([".*.", "..*", "..*"], 3, 3)
      expect(generation.send(:count_alive_neighbors, 2, 1)).to eq(2)
    end
  end

  describe "#alive?" do
    subject { described_class.new(["..*", "..*", "*.*"], 3, 3) }

    it "returns true if the cell is alive" do
      expect(subject.send(:alive?, 2, 0)).to be_truthy
      expect(subject.send(:alive?, 0, 2)).to be_truthy
    end

    it "returns false if the cell is dead" do
      expect(subject.send(:alive?, 0, 1)).to be_falsy
      expect(subject.send(:alive?, 1, 2)).to be_falsy
    end
  end
end
