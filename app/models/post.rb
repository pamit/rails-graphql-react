# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  view_count :integer
#
class Post < ApplicationRecord
  # validates :title, presence: true
  # validates :content, presence: true
end
