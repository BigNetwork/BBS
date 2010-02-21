class Credit < ActiveRecord::Base
  belongs_to :user
  belongs_to :purchase
  belongs_to :payee, :foreign_key => 'paid_to_user_id', :class_name => 'User'
  
  def paid?
    !paid_to_user_id.nil?
  end
end
