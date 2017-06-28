PLANTS
has_many :locations
belongs_to :locations???

LOCATIONS
has_many :plants
belongs_to :user

USER
has_secure_password
has_many :locations
has_many :plants, through: :locations
