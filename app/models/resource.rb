require "rss"

class Resource < ActiveRecord::Base
  has_many :feeds

  validates :xml_url, presence: true

  def self.parse(url)
    begin
      rss = RSS::Parser.parse(url)
    rescue RSS::InvalidRSSError
      rss = RSS::Parser.parse(url, false)
    rescue
      raise "WARNING: #{$!} <#{url}>."
    end

    unless rss
      raise "ERROR: Invalid URL <#{url}>."
    end

    resource = {}
    if rss.is_a?(RSS::Atom::Feed)
      resource["xml_url"] = url
      resource["title"] = rss.title.content
      resource["html_url"] = rss.link.href
      resource["description"] = rss.dc_description
    else
      resource["xml_url"] = url
      resource["title"] = rss.channel.title
      resource["html_url"] = rss.channel.link
      resource["description"] = rss.channel.description
    end

    resource
  end
end
