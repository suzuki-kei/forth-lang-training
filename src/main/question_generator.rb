require 'question'

class QuestionGenerator

    def generate
        self.generators.values.shuffle.map(&:call)
    end

    private

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

