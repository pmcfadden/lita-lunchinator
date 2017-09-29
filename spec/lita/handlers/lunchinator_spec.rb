require "spec_helper"
require 'byebug'

describe Lita::Handlers::Lunchinator, lita_handler: true do
  it "should add names to a list" do
    send_message "lita lunchinator add Bobby"
    expect(replies.last).to eq("Adding Bobby to the lunchinator rotation")
  end

  it 'should list out all the names' do
    send_message 'lita lunchinator add jane'
    send_message 'lita lunchinator add bobby'
    send_message 'lita lunchinator list'
    expect(replies.last).to eq('Current individuals added are jane, bobby.')
  end

  it 'should choose a name from the list' do
    send_message 'lita lunchinator add jane'
    send_message 'lita lunchinator roll'
    expect(replies.last).to eq('jane is the winner!')
  end
end
