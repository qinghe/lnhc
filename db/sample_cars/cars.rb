# encoding: utf-8
#车辆型号  捷达 1.6 MT   初次登记日期  2011-08-15  过户时效  45天
#户籍所在地   辽宁省-沈阳市   车辆所在地   辽宁省-沈阳市   登记证书  有
#排量  1.6   档位  4WD   购置税   有
#车牌  有   钥匙  有   违章  未确定
#咨询电话  18661770062,18561398597,18561398596,18669850072
#车辆备注  已经完全拆检；钥匙一把；无抵押；有1000服务费和5000的费用需由中标方承担；国四排放标准；其他信息以照片为准；请客户谨慎出价。


#拍卖厅：  倒计时出价大厅 开始：2013-06-14 10:00:00
#距开始：  0天13小时42分36秒  结束：2013-06-14 10:13:00
#拍卖权限  您没有参与拍卖权限   >>点击申请参与拍卖
#起拍价： ￥13000元  加价幅度：￥1000元 保留价：有
#拍卖保证金：￥5000元  车辆承保金：￥90000元 过户保证金：中标价的10%(最低5000元，最高30000元)

cars = [{ :model_id=>1084,
   :variator=>0, :displacement =>'1.6', 
   :registered_at=>'2013-06-12',
   :auctioneer=>1,
   :owner_id=>2,
   :accidents_attributes=>{'0'=>{
     "sunshi_leixing"=>"损失类型1",
     "guohu_shixiao"=>45, 
     :tingche_province_id=>6, :tingche_city_id=>38, :tingche_more=>"",
     :huji_province_id=>1, :huji_city_id=>1, :huji_more=>"",
     :gouzhi_shui=>true, 
     :chepai=>true, :yaoshi=>true, :weizhang=>'',
     :cheliang_beizhu=>"已经完全拆检；钥匙一把；无抵押；有1000服务费和5000的费用需由中标方承担；国四排放标准；其他信息以照片为准；请客户谨慎出价。",
     "chejiaohao_sousun"=>"1", "zeren_rending"=>"1", "duifang_baoxian"=>"", "renshang_qingkuang"=>"0", "pengzhuang_buwei"=>["0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0"], 
     "chuxian_riqi(1i)"=>"2013", "chuxian_riqi(2i)"=>"6", "chuxian_riqi(3i)"=>"13", "chuxian_riqi"=>"0", 
     "chuxian_jingguo"=>"", "chengbao_jine"=>"", "gusun_jine"=>""}
   },   
   :auction_attributes=>{:title=>"上海大众-POLO劲情-POLO劲情 1.4 MT", :description=>"some description",
     :hall=>0,:system=>0, :owner_id => 2,
     :start_at=>"2013-06-14 10:00:00",:expired_at=>"2013-06-14 10:13:00", 
     :starting_price=>13000, :price_increment=>1000, :reserve_price=>14000     
   }  
 }
]

cars.each_index{|idx|
  car = Car.new(cars[idx])
  car.save!  
  #车辆图片
  for file in Dir[File.join(File.dirname(__FILE__),'files', idx.to_s, "a_*.{jpg,gif,png}")]
    open(file) do|f|
      accident_file = car.accident_files.build
      accident_file.car_file = f
      accident_file.save!
    end
  end
}  