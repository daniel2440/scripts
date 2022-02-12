require 'watir'
require 'webdrivers'
require 'nokogiri'
require 'byebug'
require 'csv'

def scrap(search_phrase = nil )
  browser = Watir::Browser.new
  page_counter = 1
  CSV.open("products.csv", "w") do |csv|
    csv << ["title", "price", "link", "description"]
    while page_counter <= 1
      if search_phrase
        if page_counter > 1
          uri = 'https://allegro.pl/listing?string=' + ARGV[0] + page_counter.to_s
          # uri = 'https://allegro.pl/kategoria/klocki-lego-17865?p='+page_counter.to_s
        else
          uri = 'https://allegro.pl/listing?string=' + ARGV[0]
          # uri = 'https://allegro.pl/kategoria/klocki-lego-17865'
        end
      else
        if page_counter > 1
          uri = 'https://allegro.pl/kategoria/pocztowki-10234' + page_counter.to_s
          # uri = 'https://allegro.pl/kategoria/klocki-lego-17865?p='+page_counter.to_s
        else
          uri = 'https://allegro.pl/kategoria/pocztowki-10234'
          # uri = 'https://allegro.pl/kategoria/klocki-lego-17865'
        end
      end

      browser.goto uri
      parsed_page = Nokogiri::HTML(browser.html)
      opbox = parsed_page.css('div.opbox-listing')
      articles = opbox.css('article.mx7m_1')
      articles.each do |article|
        link = article.css('a')[0].attributes["href"].value
        browser.goto link
        nested_product = Nokogiri::HTML(browser.html)
        if link.include? "lokalnie"
          description = nested_product.css('div.offer-page__description').text
        else
          description = nested_product.css('div._1h7wt').text
        end
        title = article.css('h2.mgn2_14').text
        price = article.css('span._1svub').text
        csv << [title, price, link, description]
      end
      page_counter = page_counter + 1
    end
  end

  browser.close
end

if ARGV[0]
  print('witam i szukam ' + ARGV[0])
  scrap(ARGV[0])
else
  print('witam i szukam ustalonej kategorii')
  scrap
end
