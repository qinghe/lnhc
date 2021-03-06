# encoding: utf-8
class User < ActiveRecord::Base
  attr_accessible :login, :name, :lastname, :email, :country, :status, :password, :password_confirmation, :description, :avatar, 
    :company_id,:province_id, :city_id, :cellphone, :id_number,:vercode,  :deposit
  
	has_attached_file :avatar, :styles => { :thumb => "100x100>" }, :default_url => "/images/avatars/missing.png"
	belongs_to :company
  has_many :sent_alerts, :class_name => 'Alert',:foreign_key => :author_id
  has_many :received_alerts, :class_name => 'Alert',:foreign_key => :reader_id
  has_many :auctions, :foreign_key => :owner_id, :include => [:won_offer]
  has_many :won_in_auctions, :class_name => 'Auction', :as => :winner
  has_many :messages, :foreign_key => :owner_id, :order => 'id DESC'
  has_many :written_comments, :class_name => 'Comment', :foreign_key => :author_id
  has_many :received_comments, :class_name => 'Comment', :foreign_key => :receiver_id
  has_many :sent_offers, :class_name => 'Offer', :foreign_key => :offerer_id
  has_many :rated_values, :class_name => 'AuctionRating', :dependent => :delete_all
  has_many :memberships, :dependent => :destroy
  has_many :projects, :through => :memberships
  has_many :roles, :through => :memberships
  has_one :emailver
  has_one :reputation, :dependent => :destroy
  has_many :topics, :dependent => :destroy
  has_many :posts, :dependent => :destroy
  has_many :invitations, :dependent => :destroy
  has_many :relationships, :foreign_key => "watcher_id", :dependent => :destroy
  has_many :watching, :through => :relationships, :source => :watched
  has_many :reverse_relationships, :foreign_key => "watched_id",
                                   :class_name => "Relationship",
                                   :dependent => :destroy
  has_many :watchers, :through => :reverse_relationships, :source => :watcher
  has_many :blogposts
  has_many :blogcomments, :dependent => :destroy
  has_many :bonuspoints, :dependent => :destroy
  has_many :tickets
  has_many :usefuls


  email_regex = /\A[\w+żźćńółęąśŻŹĆĄŚĘŁÓŃ\-.]+@[a-zżźćńółęąś\d\-.]+\.[a-z]+\z/i
  string = /\A[\w+żźćńółęąśŻŹĆĄŚĘŁÓŃß\-.]+\z/
  string2 = /\A[a-zA-ZżźćńółęąśŻŹĆĄŚĘŁÓŃ\- ']+\z/
	
	validates :login, :presence => true,  :length => {:within => 2..40}#, :uniqueness => true
	validates :name, :presence => true, :length => {:within => 2..40}
	#validates :lastname, :presence => true, :format => {:with => string2}, :length => {:within => 3..40}
	validates :email, :presence => true, :format => {:with => email_regex}, :uniqueness => { :case_sensitive => false }, :length => {:within => 6..50}
	validates :password, :presence => true, :confirmation => true, :length => { :within => 5..100 }
  #validates :cellphone, :length=>11
	validates_numericality_of :status, :presence => true
	validates_inclusion_of :role, :in => ["administrator", "user", "insurance","evaluator"]
	
	validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png', 'image/gif']
  validates :province_id, :presence => true
  validates :city_id, :presence => true
  
	before_create :encrypt_password
	before_create :default_data
	before_update :encrypt_password, :if => ->{ self.password_changed? }

  def self.administrator
    self.where(:role=>'administrator').first
  end
  def self.evaluator
    self.where(:role=>'evaluator').first    
  end

  def default_data
 	self.status = 2
	self.role = "user"
  end
	
  def watching?(watched)
    relationships.find_by_watched_id(watched)
  end

  def watch!(watched)
    relationships.create!(:watched_id => watched.id)
  end
  
  def unwatch!(watched)
    relationships.find_by_watched_id(watched).destroy
  end
 
  def to_s
    self.login
  end
  
  def new_message params
    msg = self.messages.new params
    msg.author_id = self.id
    msg
  end
  
  def find_messages folder, page
    unless [:received, :sent].include? folder
      raise Exception.new('Niepoprawny typ wiadomosci')
    end
    
    self.messages.send(folder).paginate(:page => page, :per_page => 15)    
  end
  
    def has_password?(submitted_password)
	    password == encrypt(submitted_password)
    end
     
    def self.authenticate(email, submitted_password)
      user = find_by_email(email)
      return nil  if user.nil?
      return user if user.has_password?(submitted_password)
    end
    
    def self.authenticate_with_salt(id, cookie_salt)
	    user = find_by_id(id)
	    (user && user.salt == cookie_salt) ? user : nil
    end

  def administrator?
    role == "administrator"
  end

  def insurance_agent?
    role == "insurance"
  end

  def evaluator?
    role == "evaluator"
  end

  def address
    if province_id>0 and city_id>0 
    "#{ChineseCities::Province.find(province_id).name}#{ChineseCities::City.find(city_id).name}"
    end
  end

  def company_name
    company ? company.name : "无"
  end
  private

    def encrypt_password
      self.salt = make_salt if new_record?
      self.password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end

end
