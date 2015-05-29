XPTemplate priority=personal

XPT dbg
require 'ruby-debug'; Debugger.start; debugger

XPT dbgr
require 'ruby-debug'; Debugger.wait_connection = true; Debugger.start_remote

XPT d
debugger; 0;

XPT bp
require 'pry'; binding.pry

XPT brp
require 'pry-remote'; binding.remote_pry

XPT ts
# vim: ft=ruby ts=2 sts=2 sw=2 expandtab

XPT b
byebug

XPT bb
require 'byebug'; byebug

XPT bbr
require 'byebug'; Byebug.wait_connection = true; Byebug.start_server('localhost', 8989)

