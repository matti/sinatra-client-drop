$stdout.sync = true

require "thin"
require "sinatra/base"
require "sinatra/streaming"

app = Sinatra.new
app.helpers Sinatra::Streaming

app.set :bind, "0.0.0.0"
app.set :port, ENV.fetch("PORT", "8080")


app.get "/" do
  stream do |out|
    out.callback do
      puts "client closed"
    end

    until out.closed? do
      puts "x"
      out.write "x"
      sleep 0.01
    end

    puts "closed"
  end
end

app.run!
