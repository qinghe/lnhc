module Pingan
  class TrustMessageParser < MessageParser
  #  <?xml version="1.0" encoding="GB2312"?>
  #  <Request>
  #  <PARTNER_ID>icclm_htbc</PARTNER_ID>
  #  <SUITE_NAME>PCIS</SUITE_NAME>
  #  <TRAN_CODE>200408</TRAN_CODE>
  #  <!--拍卖编号, String, 必填 -->
  #  <taskAuctionNo></taskAuctionNo>
  #  <!--是否委托拍卖, Boolean, 必填 -->
  #  <isEntrust></isEntrust>
  #  </Request>
    def xpath
      "Request/*"
    end

  end
end