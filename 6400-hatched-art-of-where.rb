#!/usr/bin/env ruby
require 'json'
require 'rubygems'
require 'awesome_print'
require 'logger'
require 'oily_png'

logger = Logger.new(STDERR)
logger.level = Logger::DEBUG

artofwhere_width =  3400
artofwhere_length = 6400
output_png =
  ChunkyPNG::Image.new(
    artofwhere_width, artofwhere_length,
    ChunkyPNG::Color::TRANSPARENT)
num_pixels = artofwhere_width * artofwhere_length

original = ChunkyPNG::Image.from_file('../6400px-wide-hatched-2019-01-31-05-36-oily-200x200-out.png')
logger.debug "original read"

# 3400 / 200 px = 17 rows one way i.e. "horizontally"
# 6358 -> 6400 / 200 px = 32 rows the other way "vertically"
# each original is 4608 x 3456 px
# round down to 6400 x 6039  px round 6039 to 6000

#     which means there are 32 two hundred pixel columns horizontally
#     and 30 two hundred pixel rows vertically

i = 0
x = 0
y = 0
num_rows = 0
loop do
  logger.debug "i:" + i.to_s
  if i >= num_pixels || y >= artofwhere_length
    break
  end
  xoffset = rand(0..31) * 200
  yoffset = rand(0..29) * 200
  row_y = y
  (yoffset..yoffset + 199).each do |flickry|
    row_x = x
    (xoffset..xoffset + 199).each do |flickrx|
      #logger.debug "extract area:" + flickrx.to_s + "," + flickry.to_s
      r = ChunkyPNG::Color.r(original[flickrx, flickry])
      g = ChunkyPNG::Color.g(original[flickrx, flickry])
      b = ChunkyPNG::Color.b(original[flickrx, flickry])
      output_png[row_x, row_y] = ChunkyPNG::Color.rgb(r, g, b)
      row_x += 1
      i += 1
    end
    row_y += 1
  end
  x += 200
  if x == artofwhere_width
    logger.debug "NEW ROW"
    x = 0
    y += 200
    num_rows += 1
    next if num_rows % 2 == 0
    t = Time.now
    interim_filename = sprintf(
      "hatched-%4.4d-%2.2d-%2.2d-%2.2d-%2.2d-interim-200x200-oily-out-row-%4.4d.png", \
      t.year, t.month, t.day, t.hour, t.min,
      y-200)
    output_png.save interim_filename, :interlace => true
  end
end
t = Time.now
filename = sprintf("hatched-%4.4d-%2.2d-%2.2d-%2.2d-%2.2d-oily-200x200-out.png",
  t.year, t.month, t.day,  t.hour, t.min)
output_png.save filename, :interlace => true
