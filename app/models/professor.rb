class Professor < User
    # Include default devise modules. Others available are:
    # :lockable, :timeoutable, :trackable and :omniauthable
    # , :confirmable
    devise  :database_authenticatable, :registerable,
            :recoverable, :rememberable, :validatable
    
    has_many :courses
end
