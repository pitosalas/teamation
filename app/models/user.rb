class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :courses
  validates :firstname,  presence: true, length: { maximum: 50 }
  validates :lastname,  presence: true, length: { maximum: 50 }
  validates_format_of :email, with: Devise::email_regexp, on: :create
  validates_format_of :email, with: /\@brandeis\.edu/, message: 'You should register with Brandeis email', on: :create
  TIME_ZONE = ['UTC+12', 'UTC+11', 'UTC+10', 'UTC+9', 'UTC+8', 'UTC+7', 'UTC+6', 'UTC+5', 'UTC+4', 'UTC+3', 'UTC+2', 'UTC+1', 'UTC+0',
               'UTC-12', 'UTC-11', 'UTC-10', 'UTC-9', 'UTC-8', 'UTC-7', 'UTC-6', 'UTC-5', 'UTC-4', 'UTC-3', 'UTC-2', 'UTC-1']
end
