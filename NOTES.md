PLANTS
has_and_belongs_to_many :locations
name

LOCATIONS
has_and_belongs_to_many :plants
belongs_to :user
name
user_id

PLANTS_LOCATIONS
plant_id
location_id

USER
has_secure_password
has_many :locations
has_many :plants, through: :locations
name
