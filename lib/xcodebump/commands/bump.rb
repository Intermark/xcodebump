$:.push File.expand_path('../../', __FILE__)
require 'fileutils'
require 'xcodebump'

command :bump do |c|
  c.syntax = 'xcodebump bump [options]'
  c.summary = 'Creates the required files in your directory.'
  c.description = ''
  c.option '-r', '--release', 'Bumps the release version number, or 1 in 1.2.3'
  c.option '-m', '--minor', 'Bumps the minor version number, or 2 in 1.2.3'
  c.option '-p', '--patch', 'Bumps the patch version number, or 3 in 1.2.3'

  c.action do |args, options|
    r = options.release
    m = options.minor
    p = options.patch

    if r
      m = nil
      p = nil
    elsif m
      r = nil
      p = nil
    elsif p
      r = nil
      m = nil
    else
      return
    end
    Xcodebump::update_version_number r, m, p
  end
end