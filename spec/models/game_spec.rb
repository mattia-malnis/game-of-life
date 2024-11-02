require 'rails_helper'

RSpec.describe Game, type: :model do
  context "associations" do
    it { should belong_to(:user_session) }
  end
end
