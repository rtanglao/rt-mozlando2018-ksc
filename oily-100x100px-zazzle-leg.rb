#!/usr/bin/env ruby
require 'json'
require 'rubygems'
require 'awesome_print'
require 'logger'
require 'vips'
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

originals_from_flickr = []
ARGF.each_line do |file|
  image = Vips::Image.new_from_file file.chomp
  originals_from_flickr.push(image)
end
length = originals_from_flickr.length
logger.debug "number of flickr pics:" + length.to_s
#logger.debug files[0]
#logger.debug files[-1]
# 3400 / 10 px = 34 rows one way i.e. "horizontally"
# 6358 -> 6400 / 10 px = 64 rows the other way "vertically"
# each original is 4608 x 3456 px
# round down to 4600 x 3400 px

#     which means there are 46 ten pixel columns horizontally
#     and 34 ten pixel rows vertically

i = 0
x = 0
y = 0
loop do
  logger.debug "i:" + i.to_s
  if i >= num_pixels
    break
  end
  xoffset = rand(0..45) * 100
  yoffset = rand(0..33) * 100
  flickr_pic = rand(0..length - 1)
  row_y = y
  (yoffset..yoffset + 99).each do |flickry|
    row_x = x
    (xoffset..xoffset + 99).each do |flickrx|
      #logger.debug "extract area:" + flickrx.to_s + "," + flickry.to_s
      r, g, b = originals_from_flickr[flickr_pic].getpoint flickrx, flickry
      output_png[row_x, row_y] = ChunkyPNG::Color.rgb(r.to_i, g.to_i, b.to_i)
      row_x += 1
    end
    row_y += 1
  end
  x += 100
  if x == artofwhere_width
    logger.debug "NEW ROW"
    x = 0
    y += 100
    next if y % 2 != 0
    t = Time.now
    interim_filename = sprintf(
      "%4.4d-%2.2d-%2.2d-%2.2d-%2.2d-interim-100x100-oily-out-row-%4.4d.png", \
      t.year, t.month, t.day, t.hour, t.min,
      y-100)
    output_png.save interim_filename, :interlace => true
  end
  i += 10000
end
t = Time.now
filename = sprintf("%4.4d-%2.2d-%2.2d-%2.2d-%2.2d-oily-100x100-out.png",
  t.year, t.month, t.day,  t.hour, t.min)
output_png.save filename, :interlace => true
