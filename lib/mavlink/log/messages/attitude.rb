module MAVLink; module Log; module Messages

  class Attitude < TimedMessageMilli

    # radians (-pi..pi)
    def roll
     # @roll ||= float(0..3)
    # debugger
     @roll ||= int8_t(0..3)
    end

    # radians (-pi..pi)
    def pitch
      @pitch ||= int8_t(4..7)
    end

    # radians (-pi..pi)
    def yaw
      @yaw ||= int8_t(8..11)
    end

    # rad/s
    def rollspeed
      @rollspeed ||= float(12..15)
    end

    # rad/s
    def pitchspeed
      @pitchspeed ||= float(16..19)
    end

    # rad/s
    def yawspeed
      @yawspeed ||= float(20..23)
    end

  end

end; end; end
