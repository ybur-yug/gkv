require 'spec_helper'

describe Gkv do
  let(:db) { Gkv::Database.new }

  before(:each) { clear_db }

  context "as a gem" do
    it 'has a version number' do
      expect(Gkv::VERSION).not_to be nil
    end
  end

  context "git functions" do
    it 'hash does not have excess newlines' do
      data = Gkv::GitFunctions::hash_object("hello")
      expect(data).to eq data.strip
    end
  end

  context "on set" do
    it 'sets a key' do
      load_db([{ 'Apples' => 10 }])
      expect(db.get('Apples')).to eq 10
    end

    it 'sets a key with hash syntax' do
      db['Apples'] = 10
      expect(db['Apples']).to eq 10
    end

    it 'modifies a key' do
      load_db([{ 'Apples' => 12 }, { 'Apples' => 10 }])
      expect(db.get('Apples')).to eq 10
    end

    it 'modifies a key with hash syntax' do
      db['Apples'] = 12
      db['Apples'] = 10
      expect(db['Apples']).to eq 10
    end

    it 'keeps a history of a keys values' do
      load_db([{ 'Pants' => 10 }, { 'Pants' => 'oats' }])
      expect(db.get_version(1, 'Pants')).to eq 10
      expect(db.get_version(2, 'Pants')).to eq 'oats'
    end

    it 'can return a float type' do
      load_db([{ 'Pants' => 10.0 }])
      expect(db.get('Pants')).to eq 10.0
    end

    it 'can return an integer type' do
      load_db([{ 'Pants' => 10 }])
      expect(db.get('Pants')).to eq 10
    end

    context "when saving hashes" do
      it 'deals with ruby 2 hashes' do
        load_db([{ 'stuff' => { key: "value" } }])
        expect(db.get('stuff')).to be_an_instance_of Hash
        expect(db.get('stuff')).to eq({ key: 'value' })
      end

      it 'deals with old hash syntax' do
        load_db([{ 'stuff' => { :key => "value" } }])
        expect(db.get('stuff')).to be_an_instance_of Hash
        expect(db.get('stuff')).to eq({ key: 'value' })
      end

      it 'can set hashes in a list' do
        load_db([{ 'stuff' => [{ :key => "value" }, { :stuff => "value" }] }])
        expect(db.get('stuff')).to eq [{ key: 'value' }, { stuff: 'value' }]
      end
    end

    it 'can return an array type' do
      load_db([{ 'favorites' => ['pants', 'lack of pants', 'party pants'] }])
      expect(db.get('favorites')).to eq ['pants', 'lack of pants', 'party pants']
    end

    it 'can return a bool type' do
      load_db([{ 'stuff' => true }])
      expect(db.get('stuff')).to eq true
    end

    it 'does not freak out when it sees quotes' do
      load_db([ { 'stuff" 7' => 'pants' }])
      expect(db.get('stuff" 7')).to eq 'pants'
    end
  end

  context "on get" do
    it 'returns the key when a key is set' do
      expect(db.set('Apples', '10')).to eq 'Apples'
    end

    it 'can get all stored items' do
      load_db([{ 'ants' => 10 }, { 'bob' => 'pants' }, { 'cants' => 10 } ])
      expect(db.all).to eq [{ 'ants' => 10 }, { 'bob' => 'pants' }, { 'cants' => 10 }]
    end

    it 'can get all versions of a given item' do
      load_db([{ 'ants' => 10 }, { 'ants' => 'pants' }, { 'ants' => 10 } ])
      expect(db.all_versions('ants')).to eq [10, 'pants', 10]
    end
  end

  context "on save" do
    it 'returns a hash' do
      load_db([{ 'hello' => 'world' }])
      expect(db.save).to be_an_instance_of String
    end

    it 'saves the hash to a dotfile for persistance' do
      load_db([{ 'hello' => 'world' }])
      db.save
      expect(`ls -a`.include?(".database")).to be true
    end

    it 'can be loaded given a hash' do
      load_db([{ 'hello' => 'world' }])
      db.save
      clear_db
      db.load(File.open('.database').read)
      expect(db.get('hello')).to eq 'world'
      expect($ITEMS.keys).to eq ['hello']
    end
  end
end
