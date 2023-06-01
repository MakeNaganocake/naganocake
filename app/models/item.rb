class Item < ApplicationRecord
    has_one_attached :image
    
    has_many :cart_items
    has_many :order_items
    def taxin_price
        price*1.1
    end
def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [100, 100]).processed
  end

end
