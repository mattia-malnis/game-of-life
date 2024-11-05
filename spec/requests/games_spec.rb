require 'rails_helper'

RSpec.describe "Games", type: :request do
  let(:user_session) { UserSession.create }

  describe "GET /" do
    it "renders the index template" do
      get root_path
      expect(response).to render_template(:index)
    end
  end

  describe "POST /games" do
    context "with file input" do
      context "when the file has the wrong format" do
        let(:invalid_file) { fixture_file_upload("random_image.jpg", "image/jpeg") }

        it "redirects to the root path with an alert for a non-text file" do
          post games_path, params: { file: invalid_file }
          expect(response).to redirect_to(root_path)
          expect(flash[:alert]).to eq("Only .txt files are allowed")
        end
      end

      context "when the file has valid file type" do
        context "when save succeeds" do
          let(:valid_matrix) { fixture_file_upload("valid_matrix.txt", "text/plain") }

          it "initializes MatrixFileReader with the file content" do
            expect(MatrixFileReader).to receive(:new).with(valid_matrix.read).and_call_original
            post games_path, params: { file: valid_matrix }
          end

          it "creates a new game" do
            expect {
              post games_path, params: { file: valid_matrix }
            }.to change(Game, :count).by(1)
          end
        end

        context "when save fails" do
          let(:invalid_matrix) { fixture_file_upload("invalid_matrix.txt", "text/plain") }

          it "renders upload form with turbo stream" do
            post games_path, params: { file: invalid_matrix }, as: :turbo_stream
            expect(response).to have_rendered(partial: "_upload_form")
          end

          it "renders upload form with turbo stream" do
            post games_path, params: { file: invalid_matrix }
            expect(response).to redirect_to(root_path)
          end
        end
      end
    end

    context "with form input" do
      context "with valid parameters" do
        let(:valid_attributes) do
          {
            game: {
              generations_attributes: [{
                counter: 1,
                columns: 3,
                rows: 3,
                matrix: "...\n.**\n*.*"
              }]
            }
          }
        end

        it "creates a new game with generation" do
          expect {
            post games_path, params: valid_attributes
          }.to change(Game, :count).by(1)
           .and change(Generation, :count).by(1)
        end

        it "redirects to the generation page on success" do
          post games_path, params: valid_attributes
          generation = Generation.order(created_at: :desc).first
          expect(response).to redirect_to(game_generation_path(generation.game, generation))
        end
      end
    end

    context "with form input" do
      context "with valid parameters" do
        let(:invalid_attributes) do
          {
            game: {
              generations_attributes: [{
                columns: 3,
                rows: 4,
                matrix: "...\n.**\n*.*"
              }]
            }
          }
        end

        it "renders the input form with turbo stream" do
          post games_path, params: invalid_attributes, as: :turbo_stream
          expect(response).to have_rendered(partial: "_input_form")
        end

        it "redirects to root with error and html format" do
          post games_path, params: invalid_attributes
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end
end
