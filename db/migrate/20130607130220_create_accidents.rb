class CreateAccidents < ActiveRecord::Migration
  def self.up
    create_table :accidents do |t|
      t.integer :car_id
      t.integer :sunshi_leixing
      t.date :chuxian_riqi
      t.integer :provice_id
      t.integer :city_id
      t.string :tingche_more
      t.boolean :chejiaohao_sousun
      t.integer :zeren_rending
      t.string :duifang_baoxian
      t.integer :renshang_qingkuang
      t.string :pengzhuang_buwei, :default=>''
      t.string :chuxian_jingguo
      t.integer :chengbao_jine
      t.integer :gusun_jine
      t.integer :chuli_fangshi

      t.timestamps
    end
  end
  def self.down
    drop_table :accidents
  end
end