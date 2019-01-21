#!/usr/bin/env ruby
require 'json'
require 'rubygems'
require 'awesome_print'
require 'time'
require 'date'
require 'logger'

logger = Logger.new(STDERR)
logger.level = Logger::DEBUG

files = []
ARGF.each_line do |file|
  files.push(file.chomp)
end
files.shuffle!
logger.debug files[0]
logger.debug files[-1]
# 3325 / 5 px = 665 rows one way i.e. "horizontally"
# 6358 -> 6370 / 5 px = 1274 rows the other way "vertically"
# each original is 4608 x 3456 px
# round down to 4605 x 3455 px

#     which means there are 921 five pixel columns horizontally
#     and 691 five pixel rows vertically

# which means the script needs to pick 847210 (665 * 1274) random 5px x 5x patches
i = 0
exit_program = false
loop do

	files.each do |f|
		i += 1
		if i > 847210
			exit_program = true
			break
		end
		xoffset = (rand(1..921) - 1) * 5
		yoffset = (rand(1..691) - 1) * 5
		logger.debug f
		logger.debug xoffset
		logger.debug yoffset
		cmd = sprintf("convert %s -crop 5x5+%d+%d  +repage  5x5-ksc.png", f, xoffset, yoffset)
		value = `#{cmd}`
		logger.debug value
		exit
	end
	break if exit_program
end