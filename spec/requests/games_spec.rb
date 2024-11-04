require 'rails_helper'

RSpec.describe "Games", type: :request do
  let(:user_session) { UserSession.create }
  let(:valid_matrix) { fixture_file_upload("valid_matrix.txt", "text/plain") }
  let(:invalid_matrix) { fixture_file_upload("invalid_matrix.txt", "text/plain") }
  let(:invalid_file) { fixture_file_upload("random_image.jpg", "image/jpeg") }

  describe "GET /" do
    it "renders the index template" do
      get root_path
      expect(response).to render_template(:index)
    end
  end

  describe "POST /games" do
    context "when the file is missing or has the wrong format" do
      it "redirects to the root path with an alert for a missing file" do
        post games_path
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq("File missing or wrong format")
      end

      it "redirects to the root path with an alert for a non-text file" do
        post games_path, params: { file: invalid_file }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq("File missing or wrong format")
      end
    end

    context "when the file is valid" do
      it "initializes MatrixFileReader with the file content" do
        expect(MatrixFileReader).to receive(:new).with(valid_matrix.read).and_call_original
        post games_path, params: { file: valid_matrix }
      end
    end

    context "when the file is valid but matrix format is invalid" do
      it "redirects to the root path with an alert" do
        post games_path, params: { file: invalid_matrix }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to be_present
      end
    end
  end
end
