# encoding: utf-8
class CreateCars < ActiveRecord::Migration
  def self.up
    create_table :cars do |t|
      t.integer :model_id
      t.string :model_name
      t.string :serial_no
      t.date :registered_at
      t.integer :variator, :default=>0
      t.string :displacement, :length=>24 #排量
      t.string :plate_number
      t.string :engine_number
      t.string :frame_number
      t.integer :publisher_id
      t.integer :evaluator_id
      t.integer :status,:default=>0
      
      t.float :chengbao_jine,:default=>0 #车辆承保金额
      t.float :gusun_jine,:default=>0  #车辆估损金额      
      t.float :shiji_jiazhi,:default=>0 #实际价值
      t.float :canzhi_jiazhi,:default=>0 #残值价值
      t.float :ershou_jiazhi,:default=>0 #二手车价值
      t.float :bidding_price,:default=>0 #中标价格
      t.float :final_compensate_price,:default=>0 #最终赔付金额
      t.string :owner_name
      t.string :owner_phone
      t.string :pickup_contact_person
      t.string :pickup_contact_phone
      t.integer :pay_method #车款支付方式
      t.date :pickup_start_at
      t.date :pickup_expired_at
      t.string :pickup_address
      t.string :giveup_auction_reason
      t.string :giveup_pickupcar_reason
      t.string :giveup_transfer_reason
      t.string :type
      t.timestamps
    end
  end
  def self.down
    drop_table :cars
  end
end
