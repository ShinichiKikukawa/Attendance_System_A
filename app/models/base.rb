class Base < ApplicationRecord
 validates :base_number, presence: true, uniqueness: true, length: { maximum: 10000 }
 validates :base_name, presence: true, uniqueness: true, length: { maximum: 50 }
 validates :work_type, presence: true, length: { maximum: 50 }
end
