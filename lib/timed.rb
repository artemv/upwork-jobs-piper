class Timed

  def self.run(msg, &block)
    t0 = Time.now
    result = yield
    log msg.call(Time.now - t0, result)
    result
  end

end
