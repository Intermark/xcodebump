require 'colors'
require 'git'
require 'fileutils'

module Xcodebump
  def self.add_new_version_to_git version
    d = Dir.exist? "#{Dir.pwd}/.git"
    commit_changes(version) if d
    add_tag(version) if d
    push_changes if d
  end

  def self.commit_changes version
    `git add .`
    `git commit -m 'Bump: #{version}'`
  end

  def self.add_tag version
    `git tag -a #{version} -m #{version}`
    `git push --tags`
  end

  def self.push_changes
    `git push`
  end
end
