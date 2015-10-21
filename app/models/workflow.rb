# == Schema Information
#
# Table name: workflows
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Workflow < ActiveRecord::Base
  has_many :elements, -> { order(position: :asc) }, dependent: :destroy
  validates :name, presence: true
end
