module Pingan
  class BiddingMessageParser < MessageParser
    #<?xml version="1.0" encoding="GB2312"?>
    #<Request>
    #<PARTNER_ID>icclm_htbc</PARTNER_ID>
    #<SUITE_NAME>PCIS</SUITE_NAME>
    #<TRAN_CODE>200407</TRAN_CODE>
    #<!--拍卖编号, String, 必填 -->
    #<taskAuctionNo></taskAuctionNo>
    #<!--中标金额, Number, 必填 -->
    #<inquireAmount></inquireAmount>
    #<!--中标人, String, 必填 -->
    #<biddingUser></biddingUser>
    #</Request>
    def xpath
      "Request/*"
    end
  end
end