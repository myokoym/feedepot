class Feed < ActiveRecord::Base
  belongs_to :resource

  validates :link, presence: true

  def self.parse(resource)
    resource_url = resource.xml_url
    begin
      rss = RSS::Parser.parse(resource_url)
    rescue RSS::InvalidRSSError
      begin
        rss = RSS::Parser.parse(resource_url, false)
      rescue
        raise "WARNING: #{$!} (#{resource_url})"
      end
    rescue
      raise "WARNING: #{$!} (#{resource_url})"
    end
    return nil unless rss

    feeds = []
    rss.items.each do |item|
      if rss.is_a?(RSS::Atom::Feed)
        title = item.title.content
        link = item.link.href if item.link
        description = item.summary.content if item.summary
        date = item.updated.content if item.updated
      else
        title = item.title
        link = item.link
        description = item.description
        date = item.date
      end

      next unless link

      feeds << Feed.create({
                             title: title,
                             link: link,
                             description: description,
                             date: date,
                             resource: resource,
                           })
    end

    feeds
  end
end
