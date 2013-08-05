#!/usr/bin/env /usr/local/rvm/bin/ruby-1.9.3-p392@vimeo-importer

require 'rubygems' 
require 'tempfile'
require 'vimeo'
require 'logger'
require 'net/smtp'

$consumer_key = ''
$consumer_secret = ''
$access_token = ''
$access_secret = ''

logger = Logger.new("log/vimeo-importer.log")
# Insert here the path where your video files are.
$dir = "/path/for/video/files"


def vimeo_start
  $upload = Vimeo::Advanced::Upload.new($consumer_key, $consumer_secret, :token => $access_token, :secret => $access_secret)
  $video = Vimeo::Advanced::Video.new($consumer_key, $consumer_secret, :token => $access_token, :secret => $access_secret)
end

def vimeo_upload(file)
  out = $upload.upload(file)
  video_id = out['ticket']['video_id']
  filename = file.gsub($dir, '')
  vimeo_msg('email@domain.com', "file: #{filename.gsub('/', '')} - video_id: #{video_id}")
  vimeo_settitle(video_id, filename.gsub('/', '').gsub('.mp4', ''))
end

def vimeo_settitle(video_id, title)
  $video.set_title(video_id, title)
end

def vimeo_msg(to, message)
  msg = "
      From: Vimeo Uploader <email@domain.com>
      To: #{to} <#{to}>
      Subject: Uploaded video

      #{message}.
  "
  smtp = Net::SMTP.new 'smtp.gmail.com', 587
  smtp.enable_starttls
  smtp.start('gmail.com', 'login@domain.com', 'MYSECUREPASS', :login)
  smtp.send_message msg, 'sender@domain.com', to
  smtp.finish
end

paths = Dir["#{ $dir }/**/*.mp4"].map

vimeo_start

paths.each do |path|
  vimeo_upload(path)
end
