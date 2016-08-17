require 'thread'
require "rubygems"
require "thread_pool"
# pool = ThreadPool.new(threads = 10)
# pool.execute { puts "I'm writing from a thread" }
# pool.join
class Spanner
  attr_accessor :workers

  def initialize(workers_size)
    initialize_workers(workers_size)
    @work_queue = Queue.new
  end

  def push_to_queue(object)
    @work_queue.push object
  end


  private

  def initialize_workers(workers_size)
    @workers = (0...workers_size).map do
      Thread.new do
        begin
          until @work_queue.empty?
            work_unit = @work_queue.pop(true)
            if work_unit
              binding.pry
            end
          end
        rescue ThreadError
        end
      end
    end
  end
end

