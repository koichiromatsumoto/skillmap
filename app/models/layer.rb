class Layer < ApplicationRecord
  include RankedModel

  ranks :row_order

  validates :category1_id, uniqueness: { scope: %i[category2_id category3_id category4_id category5_id category6_id] }

  belongs_to :category1, class_name: 'Category'
  belongs_to :category2, class_name: 'Category', optional: true
  belongs_to :category3, class_name: 'Category', optional: true
  belongs_to :category4, class_name: 'Category', optional: true
  belongs_to :category5, class_name: 'Category', optional: true
  belongs_to :category6, class_name: 'Category', optional: true
  belongs_to :user, optional: true
end
