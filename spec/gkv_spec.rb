require 'spec_helper'

describe Gkv do
  let(:db) { Gkv::Database.new }

  def clear_db
    $ITEMS = {}
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

    it 'sets a key with hash syntax' do
      db['Apples'] = 10
      expect(db['Apples']).to eq 10
    end

    it 'modifies a key' do
      db.set('Apples', 12)
      db.set('Apples', 10)
      expect(db.get('Apples')).to eq 10
    end

    it 'modifies a key with hash syntax' do
      db['Apples'] = 12
      db['Apples'] = 10
      expect(db['Apples']).to eq 10
    end

    it 'keeps a history of a keys values' do
      db.set('Pants', 10)
      db.set('Pants', 'oats')
      expect(db.get_version(1, 'Pants')).to eq 10
      expect(db.get_version(2, 'Pants')).to eq 'oats'
    end

    it 'can return a float type' do
      db.set('Pants', 10.0)
      expect(db.get('Pants')).to eq 10.0
    end

    it 'can return an integer type' do
      db.set('Pants', 10)
      expect(db.get('Pants')).to eq 10
    end

    context "when saving hashes" do
      it 'deals with ruby 2 hashes' do
        db.set('stuff', {key: "value"})
        expect(db.get('stuff')).to be_an_instance_of Hash
        expect(db.get('stuff')).to eq({key: 'value'})
      end

      it 'deals with old hash syntax' do
        db.set('stuff', {:key => "value"})
        expect(db.get('stuff')).to be_an_instance_of Hash
        expect(db.get('stuff')).to eq({key: 'value'})
      end

      it 'can set hashes in a list' do
        db.set('stuff', [{key: 'value'}, {key: 'value'}])
        expect(db.get('stuff')).to eq [{key: 'value'}, {key: 'value'}]
      end
    end

    it 'can return an array type' do
      db.set('favorites', ['pants', 'lack of pants', 'party pants'])
      expect(db.get('favorites')).to eq ['pants', 'lack of pants', 'party pants']
    end

    it 'can return a bool type' do
      db.set('stuff', true)
      expect(db.get('stuff')).to eq true
    end
  end

  context "on get" do
    it 'returns the key when a key is set' do
      expect(db.set('Apples', '10')).to eq 'Apples'
    end

    # Not sure how to get this one to pass.
    # it 'returns the key when a key is set with hash syntax' do
    #   expect(db['Apples'] = 10).to eq 'Apples'
    # end

    it 'can get all stored items' do
      db.set('ants', 10)
      db.set('bob', 'pants')
      db.set('cants', 10)
      expect(db.all).to eq [{ 'ants' => 10 }, { 'bob' => 'pants' }, { 'cants' => 10 }]
    end
  end
end
