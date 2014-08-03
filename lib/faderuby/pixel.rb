class FadeRuby::Pixel
  attr_reader :r, :g, :b
  def initialize(r=0,g=0,b=0)
    @r = r
    @g = g
    @b = b
  end

  def to_a
    [r,g,b]
  end

  def set(r: nil, g: nil, b: nil)
    @r = r if r
    @g = g if g
    @b = b if b
  end

  def set_random
    @r = rand(255)
    @g = rand(255-@r)
    @b = rand(255-@r-@g)
  end
end