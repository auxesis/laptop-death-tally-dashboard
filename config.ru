#!/usr/bin/env ruby

require 'pathname'
@root = Pathname.new(File.dirname(__FILE__)).parent.parent.expand_path
$: << @root.to_s

$0 = "laptop-death-tally-dashboard"

require 'lib/laptop-death-tally-dashboard'
use ::LaptopDeathTallyDashboard
run Sinatra::Base
