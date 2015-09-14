require 'terminal-notifier'

Maid.rules do
  repeat '1h' do
    rule 'Remove duplicate files' do
      verbose_dupes_in(dir_not_downloading('~/Downloads/*')).each do |p|
        notify("#{File.basename(p)}", 'Rule: Remove duplicate files', 'duplicate')
        trash(p)
      end
    end

    rule 'Remove incomplete download file' do
      find('~/Downloads/').select { |s| is_downloading?(s) }.each do |p|
        if 3.days.since?(modified_at(p))
          notify("#{File.basename(p)}", 'Rule: Remove incomplete download file', 'download')
          FileUtils.touch(p)
          trash(p)
        end
      end
    end

    rule 'Remove zip file that contains Mac OS X applications after extracting' do
      dir_not_downloading('~/Downloads/*.zip').each do |p|
        if valid_zip?(p)
          found = zipfile_contents(p).select { |c| c.match(/^[^\/]+\.(app|dmg|pkg)\/$/) }
          if !found.empty? && (File.exist? File.expand_path "~/Downloads/#{found[0][0...-1]}")
            FileUtils.touch(p)
            trash(p)
          end
        else
          trash(p)
        end
      end
    end

    rule 'Remove empty directories' do
      dir('~/Downloads/*').each do |p|
        if File.directory?(p) && dir("#{p}/*").empty?
          notify("#{File.basename(p)}", 'Rule: Remove empty directories', 'directory')
          trash(p)
        end
      end
    end
  end

  repeat '15m' do
    rule 'Move downloaded books' do
      dir_not_downloading('~/Downloads/{[^/]*/,}*.{pdf,epub,mobi,azw3,chm}').each do |p|
        notify("#{File.basename(p)}", 'Rule: Move downloaded books to Documents', 'book')
        move(p, '~/Documents')
      end
    end

    rule 'Move downloaded audios' do
      dir_not_downloading('~/Downloads/{[^/]*/,}*.{mp3,aac,ape,flac}').each do |p|
        if duration_s(p) > 60.0
          notify("#{File.basename(p)}", 'Rule: Move downloaded audios to Music', 'audio')
          move(p, '~/Music')
        end
      end
    end

    rule 'Move downloaded pictures' do
      dir_not_downloading('~/Downloads/{[^/]*/,}*.{png,gif,jpeg,jpg,bmp}').each do |p|
        notify("#{File.basename(p)}", 'Rule: Move downloaded pictures to Pictures', 'image')
        move(p, '~/Pictures')
      end
    end

    rule 'Move downloaded videos' do
      dir_not_downloading('~/Downloads/{[^/]*/,}*.{mkv,mp4,rmvb,rm,avi,wmv}').each do |p|
        notify("#{File.basename(p)}", 'Rule: Move downloaded videos to Movies', 'video')
        FileUtils.touch(p)
        move(p, '~/Movies')
      end
    end
  end

  repeat '3h' do
    rule 'Remove expired video files' do
      dir('~/Movies/*').each do |p|
        if 7.days.since?(modified_at(p))
          FileUtils.touch(p)
          trash(p)
        end
      end
    end

    rule 'Clean trash directory' do
      dir('~/.Trash/*').each do |p|
        if 7.days.since?(modified_at(p))
          notify("#{File.basename(p)}", 'Rule: Clean trash directory', 'trash')
          remove(p)
        end
      end
    end
  end
end

def notify(message,title,name,sender='org.beyondim.MaidNotifier')
  sleep 1
  TerminalNotifier.notify("#{message}", title: "#{title}", contentImage: "/Users/beyondim/.maid/images/#{name}.png", group: "#{name}", sender: "#{sender}")
end

def valid_zip?(file)
  zip = Zip::File.open(file)
  true
rescue StandardError
  false
ensure
  zip.close if zip
end

def is_downloading?(path)
  !!(downloading_file_regexps.any? { |re| path.match(re) } || firefox_extra?(path) || aria2_extra?(path))
end

def downloading_file_regexps
  [/\.crdownload$/, /\.download$/, /\.aria2$/, /\.td$/, /\.td.cfg$/, /\.part$/]
end

def firefox_extra?(path)
  File.exist?("#{path}.part")
end

def aria2_extra?(path)
  File.exist?("#{path}.aria2")
end

def dir_not_downloading(path)
  dir_safe(path).reject { |p| is_downloading?(p) }
end
