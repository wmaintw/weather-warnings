require 'nokogiri'
require 'open-uri'
require 'json'

helpers do
  def parse_latest_warning()
    warning = {}
    doc = get_warning_web_page()
    
    warning["title"] = get_warning_title(doc)
    warning["attributes"] = get_warning_attributes(warning["title"])
    warning["link"] = get_warning_link(doc)
    
    doc_detail = get_warning_detail_web_page(warning["link"])
    warning["detail"] = get_warning_detail_content(doc_detail)
    warning["img"] = get_warning_detail_img(doc_detail)
    
    warning
  end
  
  def parse_warning_history()
    doc = get_warning_web_page()
    
    warning_history = get_list_of_warnings(doc)
    
    warning_history
  end
  
  def get_warning_web_page
    uri = "http://www.cdmb.gov.cn/alarm/alarmlist/"
    Nokogiri::HTML(open(uri))
  end

  def get_warning_title(doc)
    doc.search('/html/body/div[2]/div[1]/div/div/div[2]/ul/li[1]/a')[0].content
  end

  def get_warning_attributes(title)
    attributes = {}
    attributes["action"] = title.scan(/市.*第/)[0][1..-2]
    attributes["index"] = title.scan(/\d+/)[0]
    attributes["kind"] = title.scan(/号.*色/)[0][1..-3]
    attributes["level"] = title.scan(/.色/)[0]
  
    attributes
  end

  def get_warning_link(doc)
    doc.search('/html/body/div[2]/div[1]/div/div/div[2]/ul/li[1]/a')[0]['href']
  end


  def get_warning_detail_web_page(url)
    Nokogiri::HTML(open(url))
  end

  def get_warning_detail_content(doc_detail)
    doc_detail.search('/html/body/div[2]/div[1]/div/div/div[2]/div/div[2]/p[2]')[0].content.strip
  end

  def get_warning_detail_img(doc_detail)
    doc_detail.search('/html/body/div[2]/div[1]/div/div/div[2]/div/div[2]/p[3]/img')[0]['src']
  end

  def get_list_of_warnings(doc)
    warning_titles = doc.search('/html/body/div[2]/div[1]/div/div/div[2]/ul/li/a')
    warning_dates = doc.search('/html/body/div[2]/div[1]/div/div/div[2]/ul/li/span')

    history_list = []
    warning_titles.each_with_index { |item, index|
      history_item = {}
      history_item["index"] = index + 1
      history_item["title"] = item.content
      history_item["date"] = warning_dates[index].content
      history_item["link"] = item['href']
      history_list << history_item
    }

    history_list
  end
end




