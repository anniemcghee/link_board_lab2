class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :voteable
  belongs_to :post
  belongs_to :comment
end
