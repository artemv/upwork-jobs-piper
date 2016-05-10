# frozen_string_literal: true
# A utility to log yielded code execution time
class Timed

  def self.run(msg, &_block)
    t0 = Time.now
    result = yield
    logger.debug msg.call(Time.now - t0, result)
    result
  end

end
