class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :users, through: :comments

  # accepts_nested_attributes_for :categories, reject_if: :all_blank

  def categories_attributes=(categories_attributes)
  	if !trash_hash?(categories_attributes)
  		categories_attributes.values.each do |category_attribute|
  			category = Category.find_or_create_by(category_attribute)
  			self.post_categories.build(category: category)
  		end
  	end
  end

  def unique_users
    self.users.uniq
  end

  private

  def trash_hash?(hsh)
  	hsh.values.first.has_value?("")
  end

end
