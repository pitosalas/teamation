class Student < User
    # Include default devise modules. Others available are:
    # :lockable, :timeoutable, :trackable and :omniauthable
    # , :confirmable
    devise  :database_authenticatable, :registerable,
            :recoverable, :rememberable, :validatable
    has_many :takings
    has_many :courses, through: :takings
    has_many :in_groups
    scope :all_except, ->(user) { where.not(id: user) }
    # has_many :groups, through: :in_groups

    def full_name
        firstname.capitalize() + " " + lastname.capitalize()
    end

    def to_s
        firstname.capitalize() + " " + lastname.capitalize()
    end
end
