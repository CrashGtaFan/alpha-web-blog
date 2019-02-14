class User < ActiveRecord::Base
  enum role: [:user, :moderator, :admin]
end
