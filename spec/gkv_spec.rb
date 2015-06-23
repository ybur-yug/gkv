require 'spec_helper'

describe Gkv do
  let(:db) { Gkv::Database.new }

  def clear_db
    $items = {}
  end

  before(:each) { clear_db }

  it 'has a version number' do
    expect(Gkv::VERSION).not_to be nil
  end

  it 'sets a key' do
    db.set('Apples', 10, 'i')
    expect(db.get('Apples')).to eq 10
  end

  it 'modifies a key' do
    db.set('Apples', 12, 'f')
    db.set('Apples', 10, 'f')
    expect(db.get('Apples')).to eq 10.0
  end

  it 'keeps a history of a keys values' do
    db.set('Pants', 10, 'i')
    db.set('Pants', '14')
    expect(db.get_version(1, 'Pants')).to eq 10
    expect(db.get_version(2, 'Pants')).to eq '14'
  end

  it 'coerces integer input to strings' do
    db.set('Pants', 10)
    expect(db.get('Pants')).to eq '10'
  end

  it 'returns the key when a key is set' do
    expect(db.set('Apples', '10')).to eq 'Apples'
  end

  it 'can get all stored items' do
    db.set('ants', 10, 'i')
    db.set('bob', 10, 'f')
    db.set('cants', 10)
    expect(db.all).to eq [{ 'ants': 10 }, { 'bob': 10.0 }, { 'cants': '10' }]
  end
end
