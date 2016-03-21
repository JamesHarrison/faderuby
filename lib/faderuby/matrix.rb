class FadeRuby::Matrix < FadeRuby::DisplaySurface
  attr_reader :width, :height
  #
  # Set up a new matrix, giving the width and height in LEDs
  #
  # @param [Integer] width width of LED matrix
  # @param [Integer] height height of LED matrix
  #
  def initialize(width, height)
    @width = width
    @height = height
    (width * height).times do
      pixels.push(FadeRuby::Pixel.new)
    end
  end

  #
  # Get a pixel
  #
  # @param [Fixnum] x Row of the LED matrix
  # @param [Fixnum] y Column of the LED matrix
  #
  # @return [FadeRuby::Pixel] The pixel at the given positon
  #
  def [](x, y)
    pixels[postion(x, y)]
  end

  #
  # Set a pixel
  #
  # @param [Integer] x Row of the LED matrix
  # @param [Integer] y Column of the LED matrix
  # @param [FadeRuby::Pixel] pixel The new pixel for the postion
  #
  def []=(x, y, pixel)
    if pixel.is_a? FadeRuby::Pixel
      pixels[postion(x, y)] = pixel
    else
      raise TypeError, "(#{pixel}) is not a kind of #{FadeRuby::Pixel}"
    end
  end

  private
  #
  # Translate (x, y) into a one dimensional postion
  #
  # @param [Integer] x Row of the LED matrix
  # @param [Integer] y Column of the LED matrix
  #
  # @return [Integer] One dimensional postion
  #
  def postion(x, y)
    if (0...@width) === x and (0...@height) === y
      x + y * @width
    else
      raise IndexError, "(#{x}, #{y}) is out of range (0...#{@width}, 0...#{@height})"
    end
  end
end
