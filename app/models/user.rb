class User < ActiveRecord::Base

    has_secure_password

    has_many :posts
    has_many :comments
    has_many :votes, as: :voteable

    validates :email,
    presence: true,
    uniqueness: {case_sensitive: false}

end
