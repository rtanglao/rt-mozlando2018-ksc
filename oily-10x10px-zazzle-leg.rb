#!/usr/bin/env ruby
require 'json'
require 'rubygems'
require 'awesome_print'
require 'logger'
require 'vips'
require 'oily_png'

logger = Logger.new(STDERR)
logger.level = Logger::DEBUG

artofwhere_width = 3330
artofwhere_length = 6360
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
# 3330 / 10 px = 333 rows one way i.e. "horizontally"
# 6358 -> 6360 / 10 px = 636 rows the other way "vertically"
# each original is 4608 x 3456 px
# round down to 4600 x 3450 px

#     which means there are 460 ten pixel columns horizontally
#     and 345 ten pixel rows vertically

# which means the script needs to pick 847210 (665 * 1274) random 5px x 5x patches
i = 0
x = 0
y = 0
loop do
  i += 100
  logger.debug "i:" + i.to_s
  if i > num_pixels
    break
  end
  xoffset = rand(0..460) * 5
  yoffset = rand(0..345) * 5
  flickr_pic = rand(0..length - 1)
  row_y = y
  (yoffset..yoffset + 9).each do |flickry|
    row_x = x
    (xoffset..xoffset + 9).each do |flickrx|
      r, g, b = originals_from_flickr[flickr_pic].getpoint flickrx, flickry
      output_png[row_x, row_y] = ChunkyPNG::Color.rgb(r.to_i, g.to_i, b.to_i)
      row_x += 1
    end
    row_y += 1
  end
  x += 10
  if x == artofwhere_width
    logger.debug "NEW ROW"
    x = 0
    y += 10
    next if y % 10 != 0
    interim_filename = sprintf("interim-10x10-oily-out-row-%4.4d.png", y-10)
    output_png.save interim_filename, :interlace => true
  end
end
output_png.save "oily-10x10-out.png", :interlace => true
