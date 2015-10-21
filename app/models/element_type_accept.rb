# == Schema Information
#
# Table name: element_type_accepts
#
#  id                      :integer          not null, primary key
#  element_type_id         :integer
#  accepts_element_type_id :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

class ElementTypeAccept < ActiveRecord::Base
  belongs_to :element_types
  validates :element_type_id, presence: true
  validates :accepts_element_type_id, presence: true
end
