class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile
  has_many :languages
  has_many :conversations, :foreign_key => :sender_id

  accepts_nested_attributes_for :profile
  accepts_nested_attributes_for :languages

  after_create :create_default_conversation

  default_scope { order(created_at: :desc) }

  scope :with_profile, -> { joins(:profile).where.not(profiles: {id: nil}) }

  private

  def create_default_conversation
    Conversation.create(sender_id: 1, recipient_id: self.id) unless self.id == 1
  end
end