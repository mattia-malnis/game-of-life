require 'rails_helper'

RSpec.describe MatrixFileReader, type: :service do
  let(:valid_file_content) do
    <<~FILE
      Generation: 1
      4 8
      ........
      ....*...
      ...**...
      ........
    FILE
  end

  let(:invalid_file_content) do
    <<~FILE
      Invalid generation header
      2
      .....
    FILE
  end

  context "with valid file content" do
    let(:reader) { described_class.new(valid_file_content) }

    it "correctly parses the generation number" do
      expect(reader.generation_number).to eq(1)
    end

    it "correctly parses the rows number" do
      expect(reader.rows).to eq(4)
    end

    it "correctly parses the columns number" do
      expect(reader.columns).to eq(8)
    end

    it "correctly parses the matrix data" do
      expect(reader.data).to eq("........\n....*...\n...**...\n........")
    end
  end

  context "with invalid file content" do
    let(:reader) { described_class.new(invalid_file_content) }

    it "returns nil if the generation number format is wrong" do
      expect(reader.generation_number).to be_nil
    end

    it "returns nil if the columns are missing" do
      expect(reader.columns).to be_nil
    end

    it "correctly parses the matrix data, even if the format is wrong" do
      expect(reader.data).to eq(".....")
    end
  end

  context "with empty file content" do
    let(:reader) { described_class.new("") }

    it "returns nil if the generation number format is wrong" do
      expect(reader.generation_number).to be_nil
    end

    it "returns nil if the rows are missing" do
      expect(reader.rows).to be_nil
    end

    it "returns nil if the columns are missing" do
      expect(reader.columns).to be_nil
    end

    it "returns nil if the matrix data si missing" do
      expect(reader.data).to be_nil
    end
  end
end
