#!/usr/bin/env ruby

require 'sinatra'
require 'haml'
require 'dm-core'
require 'dm-migrations'

class Counter
  include DataMapper::Resource

  property :id,    Serial
  property :count, Integer, :default => 0
end

class LaptopDeathTallyDashboard < Sinatra::Base

  enable :inline_templates

  configure do
    DataMapper.setup(:default, ENV['DATABASE_URL'])
    DataMapper.auto_upgrade!
  end

  get '/' do
    @counter = ::Counter.get(1)
    if not @counter
      @counter = ::Counter.new
      @counter.save
      p @counter
    end
    haml :index
  end

  post '/death' do
    @counter = ::Counter.get(1)
    @counter.count += 1
    @counter.save
    redirect '/'
  end

end

__END__
@@ index
!!! Strict
%html
  %head
    %title linux.conf.au 2011 Laptop Death Tally Dashboard
    %style{:type => "text/css"}
      :plain
        *    { margin: 0; padding: 0; }
        body { font-size: 62.5%; }
        body { font-size: 18px;
               padding:   16px; }
        div#container { margin: auto;
                        padding: 32px;
                        width: 800px; }
        h1, h2, h3    { font-family: Helvetica, sans-serif;
                        background-color: black;
                        color: #ffeb3d;
                        text-align: center;
                        padding: 4px; }
        form          { padding: 16px 0;
                        margin: auto;
                        width: 200px; }
        form input    { margin: auto;
                        width: 200px; }
        input.submit  { margin: auto;
                        border: 1px solid #ffeb3d;
                        font-family: serif;
                        font-size:   30px;
                        background-color: black;
                        color: #ffeb3d;
                        padding: 8px; }
        div.count     { text-align: center;
                        font-size: 24px;
                        margin: 20px 0 8px; }
        img#logo      { display: block;
                        margin: 0 auto 36px; }

  %body
    %div#container
      %img{:src => "http://linux.org.au/files/lca2011.png", :id => "logo"}
      %h1 Laptop Death Tally Dashboard
      %div.count
        Death toll: #{@counter.count}
      %form{:action => "/death", :method => "post"}
        %input{:type => "submit", :value => "I got bit!", :class => "submit"}
