require 'rails_helper'

RSpec.describe Group, type: :model do
  describe "make sure associations with xfiles work" do
    it "should have many xfiles" do
      group = Group.reflect_on_association(:xfiles)
      expect(group.macro).to eq(:has_and_belongs_to_many)
    end
  end
end
