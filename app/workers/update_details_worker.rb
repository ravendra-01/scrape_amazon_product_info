require 'sidekiq-scheduler'

class UpdateDetailsWorker
  include Sidekiq::Worker

  def perform
    seven_days_ago = 7.days.ago
    @products = Product.where('updated_at < ?', seven_days_ago)

    @products.each do |product|
      url = product.url
      doc = Nokogiri::HTML(URI.open(url))

      title = doc.css('#productTitle').text.strip
      description = doc.css('#productDescription').text.strip
      # size = doc.css('div div p span').text.strip
      price = doc.at_css('.a-price-whole').text.gsub(/[^\d]/, '').strip.to_f
      category = doc.at_css('//*[@id="wayfinding-breadcrumbs_feature_div"]/ul/li[1]/span/a').text.strip
      # contact_info = doc.css('div div p span').text.strip
      
      Product.create do |p|
        p.url = url
        p.title = title
        p.description = description
        p.category = category
        p.price = price
      end
    end
  end
end