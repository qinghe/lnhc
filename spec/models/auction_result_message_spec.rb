require 'rails_helper'

describe Pingan::AuctionResultMessage do
  let!( :auction ) { create( :auction  ) }

  it "to json" do

    price_message =  Pingan::AuctionResultMessage.new( auction )
    price_message.to_json.should =~/partnerAccount/

  end


end