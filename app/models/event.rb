class Event < ApplicationRecord

  validates_presence_of :name

  belongs_to :category, :optional => true

  before_validation :generate_friendly_id, :on => :create

  STATUS =["draft", "public", "private"]
  validates_inclusion_of :status, :in => STATUS

  has_many :tickets, :dependent => :destroy
  accepts_nested_attributes_for :tickets, :allow_destroy => true, :reject_if => :all_blank

  def to_param
    self.friendly_id
  end

  protected

  def generate_friendly_id
    self.friendly_id ||= SecureRandom.uuid
  end

end
