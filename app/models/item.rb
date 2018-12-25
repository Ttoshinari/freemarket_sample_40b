class Item < ApplicationRecord
  has_many_attached :images
  belongs_to :seller, class_name: "User"
  belongs_to :category
  belongs_to :size, optional: true
  belongs_to :item_condition
  belongs_to :shipping
  belongs_to :postage_select
  belongs_to :leadtime
  belongs_to :prefecture
  validates :name, :description, :category_id, :item_condition_id, :postage_select_id, :shipping_id, :prefecture_id, :leadtime_id, :price, :seller_id, presence: true
  validates :price, numericality: { only_integer: true }
  validates :name, presence: true, length: { maximum: 40 }
  validates :description, presence: true, length: { maximum: 1000 }
  validate :images_attached
  validate :images_validate


  private

  #カスタムバリデーション
  def images_attached
    errors.add(:images, :presence) unless images.attached?
  end

  def images_validate
    images.each do |image|
      if not is_image
        errors.add(:images).add(I18n.t('errors.messages.file_type_not_image'))
        break
      elsif image.blob.byte_size > 10.megabytes
        errors.add(:images, I18n.t('errors.messages.file_too_large'))
        break
      end
    end
  end

  def is_image
    %w[image/jpg image/jpeg image/png].include?(image.blob.content_type)
  end
end
