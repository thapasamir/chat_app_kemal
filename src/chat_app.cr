# TODO: Write documentation for `ChatApp`
require "kemal"

# Matches GET "http://host:port/"
get "/:name" do |env|
  name = env.params.url["name"]
  render "src/views/main.ecr"
end

SOCKETS = [] of HTTP::WebSocket

ws "/chat" do |socket|

  SOCKETS << socket

  socket.on_message do |message|
    SOCKETS.each { |socket| socket.send message}
  end


  socket.on_close do
    SOCKETS.delete socket
  end
end

Kemal.run