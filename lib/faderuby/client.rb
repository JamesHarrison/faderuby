require 'socket'

#
# The FadeRuby::Client class handles low-level communication with the server
#
# @author James Harrison <james@talkunafraid.co.uk>
#
class FadeRuby::Client

  #
  # Get a socket to talk to the Fadecandy server with
  #
  # @return [TCPSocket] Socket configured to talk to the server with TCP_NODELAY
  # 
  def socket
    return @s if @s
    @s = TCPSocket.new(@host, @port)
    @s.setsockopt(Socket::IPPROTO_TCP, Socket::TCP_NODELAY, 1)
    return @s
  end

  # Set up a new client
  #
  # @param [String] host Fadecandy server host
  # @param [Integer] port Fadecandy server port
  # 
  def initialize(host='localhost', port=7890)
    @host = host
    @port = port
    socket
  end

  #
  # Send a new frame of video
  #
  # @param [[Integer]] colors Pixel values to set as [r,g,b,r,g,b,r,g,b...]
  #                           where r,g,b are three ints between 0 and 65535
  # @param [Integer] channel Channel to send to, default 0
  # 
  def set_pixels(colors, channel=0)
    size = (colors.length * 8)
    data = colors.pack('C*')
    header = [channel, 0, data.length].pack('CCS>')
    socket.send header+data, 0
  end

  #
  # Write a display surface to this client
  #
  # @param [<type>] disp_surf <description>
  #
  # @return [<type>] <description>
  # 
  def write(disp_surf, channel=0)
    set_pixels(disp_surf.pixels.map(&:to_a).flatten, channel)
  end

end

