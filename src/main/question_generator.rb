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
                each_by_sample(&block)
            when :shuffle
                each_by_shuffle(&block)
            else
                raise ArgumentError, 'mode must be in [:sample, :shuffle].'
        end
    end

    private

    def each_by_sample(&block)
        loop do
            generators.values.sample.call.tap do |question|
                block.call(question)
            end
        end
    end

    def each_by_shuffle(&block)
        loop do
            generators.values.shuffle.map(&:call).each do |question|
                block.call(question)
            end
        end
    end

    def random_integer(min: 1, max: 8)
        (rand * (max - min + 1) + min).to_i
    end

    def random_integers(n, min: 1, max: 8)
        n.times.map do
            random_integer(min: min, max: max)
        end
    end

    def generators
        {
            '+' => lambda {
                x1, x2 = random_integers(2)
                Question.new("#{x1} #{x2}", "#{x1 + x2}", '+')
            },
            '-' => lambda {
                # 引き算の結果が負数にならないように並べ替える.
                x1, x2 = random_integers(2).sort.reverse
                Question.new("#{x1} #{x2}", "#{x1 - x2}", '-')
            },
            '*' => lambda {
                x1, x2 = random_integers(2)
                Question.new("#{x1} #{x2}", "#{x1 * x2}", '*')
            },
            '/' => lambda {
                x1, x2 = random_integers(2)
                Question.new("#{x1 * x2} #{x1}", "#{x2}", '/')
            },
            'abs' => lambda {
                # 絶対値を取っていることを分かりやすくするために負数にする.
                x1 = -random_integer(min: 100, max: 999)
                Question.new("#{x1}", "#{x1.abs}", 'abs')
            },
            'drop' => lambda {
                x1, x2 = random_integers(2)
                Question.new("#{x1} #{x2}", "#{x1}", 'drop')
            },
            'dup' => lambda {
                x1 = random_integer
                Question.new("#{x1}", "#{x1} #{x1}", 'dup')
            },
            'max' => lambda {
                x1 = random_integer(min: 0, max: 9)
                x2 = random_integer(min: 100, max: 999)
                Question.new("#{x1} #{x2}", "#{[x1, x2].max}", 'max')
            },
            'min' => lambda {
                x1 = random_integer(min: 0, max: 9)
                x2 = random_integer(min: 100, max: 999)
                Question.new("#{x1} #{x2}", "#{[x1, x2].min}", 'min')
            },
            'mod' => lambda {
                x1 = random_integer(min: 10, max: 99)
                x2 = random_integer(min: 2, max: 5)
                Question.new("#{x1} #{x2}", "#{x1 % x2}", 'mod')
            },
            'negate' => lambda {
                x1 = random_integer(min: 100, max: 999)
                Question.new("#{x1}", "#{-x1}", 'negate')
            },
            'nip' => lambda {
                x1, x2 = random_integers(2)
                Question.new("#{x1} #{x2}", "#{x2}", 'nip')
            },
            'over' => lambda {
                x1, x2 = random_integers(2)
                Question.new("#{x1} #{x2}", "#{x1} #{x2} #{x1}", 'over')
            },
            'pick' => lambda {
                n = 5
                xs = (1..n).to_a
                nth = random_integer(min: 2, max: n-1)
                Question.new("#{xs.join(' ')}", "#{xs.join(' ')} #{xs[-nth-1]}", "#{nth} pick")
            },
            'roll' => lambda {
                n = 7
                xs = (1..n).to_a
                nth = random_integer(min: 3, max: n-1)
                expected_stack = xs[0..-nth-2] + xs[-nth..-1] + [xs[-nth-1]]
                Question.new("#{xs.join(' ')}", "#{expected_stack.join(' ')}", "#{nth} roll")
            },
            'rot' => lambda {
                x1, x2, x3 = random_integers(3)
                Question.new("#{x1} #{x2} #{x3}", "#{x2} #{x3} #{x1}", 'rot')
            },
            'swap' => lambda {
                x1, x2 = random_integers(2)
                Question.new("#{x1} #{x2}", "#{x2} #{x1}", 'swap')
            },
        }
    end

end

