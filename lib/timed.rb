class Timed

  def self.run(msg, &_block)
    t0 = Time.now
    result = yield
    log msg.call(Time.now - t0, result)
    result
  end

end
