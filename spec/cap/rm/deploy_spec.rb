require 'spec_helper'

describe Capistrano::Rmdeploy do
  it 'has a version number' do
    expect(Capistrano::Rmdeploy::VERSION).not_to be nil
  end

  describe "#configure" do
    before(:each) do
      Capistrano::Rmdeploy.configure do |config|
        config.user = 'user3'
        config.site = 'http://localhost:3000'
        config.password = 'admin'
        config.status_id_to_update = [1,3]
        config.done_status_id = 3
        config.key = 'qSHC6HhOiAAQVECJv4Ig'
      end
    end

    it "ensures that user is admin" do
      i = Capistrano::Rmdeploy::Issue.new
      expect(i.singleton_class.send(:user)).to eq('user3')
    end

    it "ensures that site is http://localhost:3000" do
      i = Capistrano::Rmdeploy::Issue.new
      expect(i.singleton_class.send(:site)).to eq(URI('http://localhost:3000'))
    end
  end

  it 'does something useful' do
    expect(true).to eq(true)
  end
end
