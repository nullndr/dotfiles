#!/usr/bin/env ruby

require 'open3'

def build_cmd(userid, user, alert)
  cmd = [
    '/usr/bin/sudo',
    "-u \"##{userid}\"",
    "DBUS_SESSION_BUS_ADDRESS=\"unix:path=#{user}/bus\"",
    'PATH="/usr/bin"',
    '/usr/bin/notify-send',
    '-w -u critical -i dialog-warning "Virus found!"',
    "\"#{alert}\""
  ]

  cmd.join(' ')
end

def main
  alert = "Signature detected by clamav: #{ENV['CLAM_VIRUSEVENT_VIRUSNAME']} in #{ENV['CLAM_VIRUSEVENT_FILENAME']}"
  Dir.glob('/run/user/*').each do |user|
    userid = File.basename(user)
    cmd = build_cmd(userid, user, alert)
    pid = spawn(cmd)
    Process.wait(pid)
  end
end

main
