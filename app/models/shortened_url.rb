class ShortenedUrl < ActiveRecord::Base
  def self.random_code
    code = SecureRandom.urlsafe_base64
    if exists?(short_url: code)
      random_code
    else
      code
    end
  end

  def self.create_for_user_and_long_url!(user, long_url)
    create!(submitter_id: user.id, long_url: long_url, short_url: random_code)
  end

  belongs_to(
    :submitter,
    class_name: "User",
    foreign_key: :submitter_id,
    primary_key: :id
  )

  has_many(
    :click_throughs,
    class_name: "Visit",
    foreign_key: :shortened_url_id,
    primary_key: :id
  )

  has_many(
    :visitors,
    Proc.new { distinct },
    through: :click_throughs,
    source: :visitor
  )

  has_many(
    :taggings,
    class_name: "Tagging",
    foreign_key: :shortened_url_id,
    primary_key: :id
  )

  has_many(
    :tag_topics,
    -> { distinct },
    through: :taggings,
    source: :tag_topic
  )

  def num_clicks
    # previous implementation: visitors.length
    click_throughs.count
  end

  def num_uniques
    # previous implementation: Visit.where(shortened_url_id: id).count(:visitor_id)
    visitors.count
  end

  def num_recent_uniques
    click_throughs.where("created_at >= ?", 10.minutes.ago).select(:visitor_id).distinct.count
  end


end
