#
# DisplaySurface represents a display and is subclassed by geometry specific
# classes
#
# @author James Harrison <james@talkunafraid.co.uk>
#
class FadeRuby::DisplaySurface
  def pixels
    @pixels ||= []
  end

  def set_all(r: nil, g: nil, b: nil)
    pixels.each do |pix|
      pix.set(r: r, g: g, b: b)
    end
  end
end
