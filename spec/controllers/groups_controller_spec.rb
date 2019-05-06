require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  describe "basic controller actions" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end

end
