require 'rails_helper'

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
end
