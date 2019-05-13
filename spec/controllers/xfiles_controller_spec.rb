require 'rails_helper'

describe XfilesController, :type => :controller do

  # describe "Get files" do
  #   before(:each) do
  #     content = {"a":"b"}.to_s
  #     file1 = Fabricate(:xfile)
  #     file2 = Fabricate(:xfile)
  #     get "/xfiles/#{file1.id}"
  #   end
  #   it 'should return status 200' do
  #     expect(response.status).to eq(200)
  #   end
  #
  # end
  #
  # describe "Destroying files" do
  #   before(:each) do
  #     file1 = Fabricate(:xfile)
  #     file2 = Fabricate(:xfile)
  #     delete "/xfiles/#{file1.id}"
  #   end
  #
  #     it 'should return status 200' do
  #       expect(response.status).to eq(200)
  #     end
  #
  #     it 'should delete the category' do
  #       expect(Xfile.all).to eq(file2)
  #     end
  # end

  describe "Testing for the download Xfile controller action" do
    it 'check if download xfile sets a flash message' do
      content = {"a":"b"}.to_s
      @fake_file = double(Xfile, :name => "fakie", :content => content)
      allow(Xfile).to receive(:find).with("1").and_return(@fake_file)
      get 'download_xfile', {:id => 1}
      expect(flash[:notice]).to match("fakie was successfully downloaded.")
    end

  end

  describe "basic controller actions" do
    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end

    it "Sets a flash message after destroy" do
      content = {"a":"b"}.to_s
      @fake_file = double(Xfile, :name => "fakie", :content => content)
      allow(Xfile).to receive(:find).with("1").and_return(@fake_file)

    end
  end

end
