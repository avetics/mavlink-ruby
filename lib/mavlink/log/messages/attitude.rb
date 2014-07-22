module MAVLink; module Log; module Messages

  class Attitude < TimedMessageMilli

    # radians (-pi..pi)
    def roll
     # @roll ||= float(0..3)
    # debugger
     #@roll ||= int8_t(0..3)
     @roll ||= payload.unpack('e7')[1]
    end

    # radians (-pi..pi)
    def pitch
      @pitch ||=  payload.unpack('e7')[2]
    end

    # radians (-pi..pi)
    def yaw
      @yaw ||=  payload.unpack('e7')[3]
    end

    # rad/s
    def rollspeed
      @rollspeed ||= payload.unpack('e7')[4]
    end

    # rad/s
    def pitchspeed
      @pitchspeed ||= payload.unpack('e7')[5]
    end

    # rad/s
    def yawspeed
      @yawspeed ||= payload.unpack('e7')[6]
    end

  end

end; end; end
