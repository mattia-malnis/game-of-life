require 'rails_helper'
require 'support/models/concerns/matrix_parseable'
require 'support/models/concerns/game_rules'
require 'support/models/concerns/neighbor_countable'

RSpec.describe Generation, type: :model do
  context "associations" do
    it { should belong_to(:game) }
  end

  context "validations" do
    let(:user) { UserSession.create }
    let(:game) { user.games.create }
    subject { described_class.new({ counter: 1, columns: 3, rows: 2, matrix: "...\n.*.", game: game }) }

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    context "when counter is invalid" do
      it "is invalid without counter" do
        subject.counter = nil
        expect(subject).not_to be_valid
      end

      it "is invalid when counter is less than 1" do
        subject.counter = 0
        expect(subject).not_to be_valid
      end
    end

    context "when columns or rows are invalid" do
      it "is invalid without columns" do
        subject.columns = nil
        expect(subject).not_to be_valid
      end

      it "is invalid when columns is less than 2" do
        subject.columns = 1
        expect(subject).not_to be_valid
      end

      it "is invalid without rows" do
        subject.rows = nil
        expect(subject).not_to be_valid
      end

      it "is invalid when rows is less than 2" do
        subject.rows = 1
        expect(subject).not_to be_valid
      end
    end

    context "when matrix format is invalid" do
      it "is invalid with wrong row count" do
        subject.rows = 3
        expect(subject).not_to be_valid
      end

      it "is invalid with wrong column count" do
        subject.columns = 2
        expect(subject).not_to be_valid
      end

      it "is invalid with unexpected characters" do
        subject.matrix = ".X.\n.*."
        expect(subject).not_to be_valid
      end

      it "is invalid when matrix is blank" do
        subject.matrix = nil
        expect(subject).not_to be_valid
      end
    end
  end

  context "concerns" do
    it_behaves_like "MatrixParseable"
    it_behaves_like "GameRules"
    it_behaves_like "NeighborCountable"
  end

  context "new matrix generation" do
    let(:user) { UserSession.create }
    let(:game) { user.games.create }
    let(:generation) { game.generations.create(counter: 1, columns: 5, rows: 3, matrix: "..*..\n.**..\n.*...") }

    it "creates a new matrix" do
      expect(generation.next_generation).to eq(".**..\n.**..\n.**..")
    end

    it "save the new matrix on database" do
      next_generation = generation.find_or_create_next_generation
      expect(next_generation.counter).to eq(2)
      expect(next_generation.matrix).to eq(".**..\n.**..\n.**..")
    end
  end
end