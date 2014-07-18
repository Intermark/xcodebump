module Xcodebump
  # Main Colorize Functions
  def self.colorize(text, color_code)
    puts "\e[#{color_code}m#{text}\e[0m"
  end

  # Specific Colors
  def self.red(text)
    colorize(text, 31)
  end

  def self.green(text)
    colorize(text, 32)
  end

  def self.blue(text)
    colorize(text, 36)
  end

  def self.purple(text)
    colorize(text, 35)
  end
end