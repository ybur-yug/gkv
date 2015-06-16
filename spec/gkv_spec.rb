require 'spec_helper'

describe Gkv do

  let(:db) { Gkv::Database.new }

  it 'has a version number' do
    expect(Gkv::VERSION).not_to be nil
  end
  
  it 'Sets a key' do
    db.set("Apples", "10")
    expect(db.get("Apples")).to eq "10"
  end

  it "Modifies a key" do
    db.set("Apples", "12")
    db.set("Apples", "10")
    expect(db.get("Apples")).to eq "10"
  end
end
