class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true

  # validate :ensure_good_email

  has_many(
    :submitted_urls,
    Proc.new { distinct },
    class_name: "ShortenedUrl",
    foreign_key: :submitter_id,
    primary_key: :id
  )

  has_many(
    :visits,
    class_name: "Visit",
    foreign_key: :visitor_id,
    primary_key: :id
  )

  has_many :visited_urls, through: :visits, source: :shortened_url

  def self.find_or_create!(input_email)
    if exists?(email: input_email)
      find_by(email: input_email)
    else
      create!(email: input_email)
    end
  end

  private

  def ensure_good_email

  end
end
