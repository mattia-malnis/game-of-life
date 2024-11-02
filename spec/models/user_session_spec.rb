require 'rails_helper'

RSpec.describe UserSession, type: :model do
  context "associations" do
    it { should have_many(:games).dependent(:destroy) }
  end
end
