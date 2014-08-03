# FadeRuby

Ruby interface for Fadecandy LED control servers using the Open Pixel Control protocol.

## Installation

Add this line to your application's Gemfile:

    gem 'faderuby'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install faderuby

## Usage

We use a client to talk to the device; you can specify a host and port for the fadecandy server, the defaults are localhost/7890.
```ruby
client = FadeRuby::Client.new([host], [port])
```

The client can be used to directly write pixel data:

```ruby
# Set the first connected pixel on channel 0 to blue
client.set_pixels([0,0,255], 0)
# Set the first pixel to green and the second pixel to red
client.set_pixels([0,255,0,255,0,0], 0)
```
There are also convenience classes - subclasses of DisplaySurface like Strip can be used to manage collections of Pixels.

```ruby
# 30 LED strip
strip = FadeRuby::Strip.new(30)
# Set the whole strip to green
strip.set_all(r: 0, g: 255, b: 0)
client.write(strip)
# Set the first 10 LEDs to blue
strip.pixels[0..10].each{|pix| pix.set(r: 0, g: 0, b: 255) }
client.write(strip)
```

Fadecandy will do temporal dithering (fades) for you, so you can do smooth fades by simply waiting between commands. The following example smoothly rolls a new colour onto the strip at random:

```ruby
next_color = [rand(255), rand(255), rand(255)]
while true
  strip.pixels.each do |pix|
    pix.set(r: next_color[0], g: next_color[1], b: next_color[2])
    client.write(strip)
    sleep 0.2
  end
  sleep 0.2
  next_color = [rand(255), rand(255), rand(255)]
end
```

## Contributing

1. Fork it ( https://github.com/JamesHarrison/faderuby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
