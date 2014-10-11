require 'ruby-growl'
require_relative 'icon'
g = Growl.new "localhost", "Maid Notifaction", "GNTP"

Maid.rules do

  rule 'Remove duplicate files' do
    verbose_dupes_in('~/Downloads/*').each do |p|
      g.add_notification "Notifaction", nil, MAID_ICONS::DUPLICATE
      g.notify "Notifaction", "Rule: Remove duplicate files", "Remove duplicate file #{File.basename(p)}"
      trash(p)
    end
  end

  rule 'Remove incomplete download file' do
    find('~/Downloads/').grep(/\.td(|\.\w{1,3})$/).each do |p|
      if 3.days.since?(accessed_at(p))
        g.add_notification "Notifaction", nil, MAID_ICONS::DOWNLOAD
        g.notify "Notifaction", "Rule: Remove incomplete download file", "Remove incomplete download file #{File.basename(p)}"
        trash(p)
      end
    end
  end

  rule 'Remove zip file that contains Mac OS X applications after extracting' do
    dir('~/Downloads/*.zip').each do |p|
      found = zipfile_contents(p).select { |c| c.match(/^[^\/]+\.(app|dmg|pkg)\/$/) }
      if !found.empty? && (File.exist? File.expand_path "~/Downloads/#{found[0][0...-1]}")
        trash(p)
      end
    end
  end

  rule 'Remove expired torrent files' do
    find('~/Downloads/').grep(/\.torrent$/).each do |p|
      if 3.days.since?(accessed_at(p))
        trash(p)
      end
    end
  end

  rule 'Remove empty directories' do
    dir('~/Downloads/*').each do |p|
      if File.directory?(p) && dir("#{p}/*").empty?
        g.add_notification "Notifaction", nil, MAID_ICONS::DIRECTORY
        g.notify "Notifaction", "Rule: Remove empty directories", "Remove empty directory #{File.basename(p)}"
        trash(p)
      end
    end
  end

  rule 'Move downloaded books' do
    dir('~/Downloads/{[^/]*/,}*.{pdf,epub,mobi,azw3,chm}').each do |p|
      g.add_notification "Notifaction", nil, MAID_ICONS::BOOK
      g.notify "Notifaction", "Rule: Move downloaded books", "Move #{File.basename(p)} to Documents"
      move(p, '~/Documents')
    end
  end

  rule 'Move downloaded videos' do
    dir('~/Downloads/{[^/]*/,}*.{mkv,mp4,rmvb,rm,avi,wmv}').each do |p|
      g.add_notification "Notifaction", nil, MAID_ICONS::VIDEO
      g.notify "Notifaction", "Rule: Move downloaded videos", "Move #{File.basename(p)} to Movies"
      move(p, '~/Movies')
    end
  end

  rule 'Move downloaded audios' do
    dir('~/Downloads/{[^/]*/,}*.{mp3,aac,ape,flac}').each do |p|
      if duration_s(p) > 60.0
        g.add_notification "Notifaction", nil, MAID_ICONS::AUDIO
        g.notify "Notifaction", "Rule: Move downloaded audios", "Move #{File.basename(p)} to Music"
        move(p, '~/Music')
      end
    end
  end

  rule 'Move downloaded pictures' do
    dir('~/Downloads/{[^/]*/,}*.{png,gif,jpeg,jpg,bmp}').each do |p|
      g.add_notification "Notifaction", nil, MAID_ICONS::IMAGE
      g.notify "Notifaction", "Rule: Move downloaded pictures", "Move #{File.basename(p)} to Pictures"
      move(p, '~/Pictures')
    end
  end

  rule 'Remove expired video files' do
    dir('~/Movies/*').each do |p|
      if 7.days.since?(accessed_at(p))
        trash(p)
      end
    end
  end

  rule 'Clean trash directory' do
    dir('~/.Trash/*').each do |p|
      if 7.days.since?(accessed_at(p))
        g.add_notification "Notifaction", nil, MAID_ICONS::TRASH
        g.notify "Notifaction", "Rule: Clean trash directory", "Permanently delete #{File.basename(p)}"
        remove(p)
      end
    end
  end

end