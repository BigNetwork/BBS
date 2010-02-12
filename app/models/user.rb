require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  #validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  #validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  #validates_length_of       :name,     :maximum => 100

  #validates_presence_of     :email
  #validates_length_of       :email,    :within => 6..100 #r@a.wk
  #validates_uniqueness_of   :email
  #validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  has_many :deliveries
  has_many :purchases

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation

  def sold_for
    if purchases.nil?
      return 0.0
    else
      sum = 0.0
      for purchase in purchases
        sum += purchase.sum
      end
      sum
    end
  end
  
  def delivered_total_quantity
    if deliveries.nil?
      return 0
    else
      quantity = 0
      for delivery in deliveries
        quantity += delivery.quantity
      end
      quantity
    end
  end

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    #u = find_by_login(login.downcase) # need to get the salt
    #u && u.authenticated?(password) ? u : nil
    require 'net/http' 
    site = "www.wintergate.se"
    url = "/index.php?controller=api&action=checkUser&userName=#{login}&userPassword=#{password}"
    connection = Net::HTTP.new(site)
    response = "" 
    connection.start do |http| 
      req = 
    Net::HTTP::Get.new(url) 
      response = http.request(req) 
    end
    
    if response.body == "privileged_user"
      u = find_by_login(login)
      if u.nil?
        u = User.create
        u.login = login
        u.save(false)
      end
      return u
    else
      return false
    end
  end

  def login=(value)
    write_attribute :login, (value ? value : nil)
    #write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

  protected
    


end
