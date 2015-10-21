# == Schema Information
#
# Table name: element_types
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ElementType < ActiveRecord::Base
  has_many :elements
  has_many :element_type_accepts
  validates :name, presence: true
end
