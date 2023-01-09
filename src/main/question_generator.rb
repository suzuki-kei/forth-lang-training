require 'question'

class QuestionGenerator

    VALID_MODES = %i(sample shuffle)

    def initialize(mode:)
        if !VALID_MODES.include?(mode)
            raise ArgumentError, "mode must be in [#{valid_modes}]."
        end

        @mode = mode
    end

    def each(&block)
        case @mode
            when :sample
                self.each_by_sample(&block)
            when :shuffle
                self.each_by_shuffle(&block)
            else
                raise ArgumentError, 'mode must be in [:sample, :shuffle].'
        end
    end

    private

    def each_by_sample(&block)
        loop do
            self.generators.values.sample.call.tap do |question|
                block.call(question)
            end
        end
    end

    def each_by_shuffle(&block)
        loop do
            self.generators.values.shuffle.map(&:call).each do |question|
                block.call(question)
            end
        end
    end

    def random_integer
        (rand * 8).to_i + 1
    end

    def random_integers(n)
        n.times.map do
            self.random_integer
        end
    end

    def generators
        {
            '+' => lambda {
                x1, x2 = self.random_integers(2)
                Question.new("#{x1} #{x2}", "#{x1 + x2}", '+')
            },
            '-' => lambda {
                x1, x2 = self.random_integers(2)
                Question.new("#{x1} #{x2}", "#{x1 - x2}", '-')
            },
            '*' => lambda {
                x1, x2 = self.random_integers(2)
                Question.new("#{x1} #{x2}", "#{x1 * x2}", '*')
            },
            '/' => lambda {
                x1, x2 = self.random_integers(2)
                Question.new("#{x1 * x2} #{x1}", "#{x2}", '/')
            },
            'swap' => lambda {
                x1, x2 = self.random_integers(2)
                Question.new("#{x1} #{x2}", "#{x2} #{x1}", 'swap')
            },
        }
    end

end

