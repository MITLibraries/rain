# == Schema Information
#
# Table name: elements
#
#  id              :integer          not null, primary key
#  workflow_id     :integer
#  element_type_id :integer
#  label           :string
#  help            :string
#  error           :string
#  parent_id       :integer
#  required        :boolean          default(FALSE)
#  position        :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Element < ActiveRecord::Base
  belongs_to :workflow
  belongs_to :element_type
  validates :workflow_id, presence: true
  validates :element_type_id, presence: true
  validates_associated :element_type
  validate :legal_parent
  belongs_to :parent, class_name: 'Element'
  has_many :children, -> { order(:position) },
           class_name: 'Element',
           foreign_key: 'parent_id'
  acts_as_list scope: :parent

  def accepts_type?(element_type)
    accepted_element_types.include?(element_type)
  end

  def accepted_element_type_ids
    element_type.element_type_accepts.map(&:accepts_element_type_id)
  end

  def accepted_element_types
    ElementType.where(id: accepted_element_type_ids).order(:name)
  end

  def legal_parent
    return unless parent.present?
    return if parent.accepts_type?(element_type)
    errors.add(:element_type_id, "You can't add this Element here")
  end

  def traverse(&block)
    yield self
    children.map { |child| child.traverse(&block) }
  end
end
