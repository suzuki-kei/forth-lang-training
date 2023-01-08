require 'question'

class QuestionGenerator

    def generate
        [
            generate_question_addition,
            generate_question_subtract,
            generate_question_multiple,
            generate_question_division,
            generate_question_swap,
        ].shuffle
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

    def generate_question_addition
        x1, x2 = self.random_integers(2)
        Question.new("#{x1} #{x2}", "#{x1 + x2}", '+')
    end

    def generate_question_subtract
        x1, x2 = self.random_integers(2)
        Question.new("#{x1} #{x2}", "#{x1 - x2}", '-')
    end

    def generate_question_multiple
        x1, x2 = self.random_integers(2)
        Question.new("#{x1} #{x2}", "#{x1 * x2}", '*')
    end

    def generate_question_division
        x1, x2 = self.random_integers(2)
        Question.new("#{x1 * x2} #{x1}", "#{x2}", '/')
    end

    def generate_question_swap
        x1, x2 = self.random_integers(2)
        Question.new("#{x1} #{x2}", "#{x2} #{x1}", 'swap')
    end

end

