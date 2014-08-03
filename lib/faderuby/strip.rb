class FadeRuby::Strip < FadeRuby::DisplaySurface
  
  #
  # Set up a new strip, giving the length in LEDs
  #
  # @param [Fixnum] length number of LEDs
  # 
  def initialize(length)
    length.times do
      pixels.push(FadeRuby::Pixel.new)
    end
  end


end
