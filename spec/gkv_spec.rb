require 'spec_helper'

describe Gkv do
  let(:db) { Gkv::Database.new }

  def clear_db
    $items = {}
  end

  before(:each) { clear_db }

  context "as a gem" do
    it 'has a version number' do
      expect(Gkv::VERSION).not_to be nil
    end
  end

  context "on set" do
    it 'sets a key' do
      db.set('Apples', 10)
      expect(db.get('Apples')).to eq 10
    end

    it 'modifies a key' do
      db.set('Apples', 12)
      db.set('Apples', 'test')
      expect(db.get('Apples')).to eq 10.0
    end

    it 'keeps a history of a keys values' do
      db.set('Pants', 10)
      db.set('Pants', 'stuff')
      expect(db.get_version(1, 'Pants')).to eq 10
      expect(db.get_version(2, 'Pants')).to eq 'stuff'
    end

    it 'coerces integer input to strings by default' do
      db.set('Pants', 10)
      expect(db.get('Pants')).to eq '10'
   end

    it 'can set a float type' do
      db.set('Pants', 10.0)
      expect(db.get('Pants')).to eq 10.0
    end

    it 'can set an integer type' do
      db.set('Pants', '10')
      expect(db.get('Pants')).to eq 10
    end
  end

  context "on get" do
    it 'returns the key when a key is set' do
      expect(db.set('Apples', '10')).to eq 'Apples'
    end

    it 'can get all stored items' do
      db.set('ants', 10)
      db.set('bob', 10)
      db.set('cants', 10)
      expect(db.all).to eq [{ 'ants': 10 }, { 'bob': 10.0 }, { 'cants': '10' }]
    end
  end
end
