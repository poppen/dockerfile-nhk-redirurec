#!/usr/bin/env ruby

require 'thor'
require 'date'

CHANNELS = {
  NHK1: "mms://a33.l12993146032.c129931.g.lm.akamaistream.net/D/33/129931/v0001/reflector:46032",
  NHK2: "mms://a57.l12993246056.c129932.g.lm.akamaistream.net/D/57/129932/v0001/reflector:46056",
  FM: "mms://a52.l12993346051.c129933.g.lm.akamaistream.net/D/52/129933/v0001/reflector:46051"
}

class RajiruRec < Thor
  option(:channel, :required => true)
  option(:prefix, :required => true)
  option(:duration, :default => 15, :type => :numeric)
  option(:directory, :default => '.')

  desc "rec", "task for recording the stream of NHK rajiru-rajiru"
  def rec
    now = DateTime.now
    file_name = "#{options[:prefix]}-#{now.strftime('%Y-%02m-%02d-%02H-%02M')}.mp3"
    dest_file = File.join(options[:directory], file_name)

    recording_time = options[:duration] * 60 + 30

    `/usr/bin/vlc -I rc #{CHANNELS[options[:channel].to_sym]} :sout='#transcode{acodec=mp3}:std{access=file,mux=raw,dst=#{dest_file}}' --run-time #{recording_time} vlc://quit`
  end
end

RajiruRec.start(ARGV)
