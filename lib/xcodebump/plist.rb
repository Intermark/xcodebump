require 'highline/import'
require 'colors'

module Xcodebump
  def self.update_version_number release, minor, patch
    # Find Plist Paths
    plist_paths = []
    Dir.glob(Dir.pwd + '/**/*.plist').each do |d|
      plist_paths << d if d.include? '-Info.plist'
    end
    Xcodebump::red "\n  No Plist files found.\n\n  Please run this from a directory where an Xcode Project/Workspace lives.\n" unless plist_paths.size > 0
    return unless plist_paths.size > 0

    # Ask User which one to Bump
    Xcodebump::blue "\n  Please choose one of the follwing to bump the version number:"
    plist_paths.each_with_index do |p, i|
      components = p.split('/')
      puts "  [#{i.to_s}] #{components[components.size - 1]}"
    end
    puts

    index = ask("  Plist to Modify?  ")
    path = nil
    if plist_paths.size > index.to_i
      path = plist_paths[index.to_i]
    end
    return unless path

    # Edit Version Number
    plist_text = File.read path
    # Find Keys, bump them
    keys = ['CFBundleVersion','CFBundleShortVersionString']
    new_version = ''
    keys.each do |k|
      matches = plist_text.match /<key>#{k}<\/key>\s*<(.*?)>.*<\/(.*?)>/
      if matches
        key_start = "<string>"
        key_end = "</string>"
        v = matches[0][/#{key_start}(.*?)#{key_end}/m, 1]
        v_new = new_version_string v, release, minor, patch
        new_version = v_new
        replace_string = matches[0].sub(/<string>.*<\/string>/, "<string>#{v_new}</string>")
        plist_text = plist_text.gsub(matches[0], replace_string)
      else
        v = '0.0.0'
        v = new_version_string v, release, minor, patch
        plist_text = plist_text.sub(/<\/dict>\s*<\/plist>/, "<key>#{k}</key>\n<string>#{v}</string>\n</dict></plist>")
      end

      # Save File
      File.open(path, 'w') do |f|
        f.write plist_text
      end
    end

    # Write to Console
    components = path.split('/')
    plist = components[components.size - 1]
    Xcodebump::green "\n  #{plist} updated to #{new_version}\n"
  end


  def self.new_version_string v, release, minor, patch
    v_components = v.split('.')
    v_components << '0' if v_components.size < 3
    v_components[0] = (v_components[0].to_i + 1).to_s if release
    v_components[1] = (v_components[1].to_i + 1).to_s if minor
    v_components[2] = (v_components[2].to_i + 1).to_s if patch
    return v_components.join('.')
  end
end
