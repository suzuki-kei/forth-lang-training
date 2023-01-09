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

    def random_integer(min: 1, max: 8)
        (rand * (max - min + 1) + min).to_i
    end

    def random_integers(n, min: 1, max: 8)
        n.times.map do
            self.random_integer(min: min, max: max)
        end
    end

    def generators
        {
            '+' => lambda {
                x1, x2 = self.random_integers(2)
                Question.new("#{x1} #{x2}", "#{x1 + x2}", '+')
            },
            '-' => lambda {
                # 引き算の結果が負数にならないように並べ替える.
                x1, x2 = self.random_integers(2).sort.reverse
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
            'abs' => lambda {
                x1 = -self.random_integer
                Question.new("#{x1}", "#{x1.abs}", 'swap')
            },
            'drop' => lambda {
                x1, x2 = self.random_integers(2)
                Question.new("#{x1} #{x2}", "#{x1}", 'drop')
            },
            'dup' => lambda {
                x1 = self.random_integer
                Question.new("#{x1}", "#{x1} #{x1}", 'dup')
            },
            'max' => lambda {
                x1, x2 = self.random_integers(2)
                Question.new("#{x1} #{x2}", "#{[x1, x2].max}", 'max')
            },
            'min' => lambda {
                x1, x2 = self.random_integers(2)
                Question.new("#{x1} #{x2}", "#{[x1, x2].min}", 'min')
            },
            'mod' => lambda {
                x1, x2 = self.random_integers(2)
                Question.new("#{x1} #{x2}", "#{x1 % x2}", 'mod')
            },
            'negate' => lambda {
                x1 = self.random_integer
                Question.new("#{x1}", "#{-x1}", 'negate')
            },
            'nip' => lambda {
                x1, x2 = self.random_integers(2)
                Question.new("#{x1} #{x2}", "#{x2}", 'nip')
            },
            'over' => lambda {
                x1, x2 = self.random_integers(2)
                Question.new("#{x1} #{x2}", "#{x1} #{x2} #{x1}", 'over')
            },
            'rot' => lambda {
                x1, x2, x3 = self.random_integers(3)
                Question.new("#{x1} #{x2} #{x3}", "#{x2} #{x3} #{x1}", 'rot')
            },
            'swap' => lambda {
                x1, x2 = self.random_integers(2)
                Question.new("#{x1} #{x2}", "#{x2} #{x1}", 'swap')
            },
        }
    end

end

