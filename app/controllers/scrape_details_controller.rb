require 'nokogiri'
require 'open-uri'
class ScrapeDetailsController < ApplicationController

  def product_details
    @products = Product.all
  end
  
  def scrape
    url = params[:url]
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

    redirect_to product_details_path
  end
end