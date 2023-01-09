require 'forth'

class Question

    def initialize(initial_stack, expected_stack, answer)
        @initial_stack = initial_stack
        @expected_stack = expected_stack
        @answer = answer
    end

    def challange
        self.print_question
        response = self.read_response
        self.judge(response)
        puts
    end

    private

    def print_question
        comment = self.comment(@initial_stack, @expected_stack)
        print "#{comment} => "
    end

    def read_response
        $stdin.readline.chomp
    end

    def judge(response)
        actual_stack = self.execute(response)

        if actual_stack == @expected_stack
            puts '    OK'
        else
            comment = self.comment("#{@initial_stack} #{response}", actual_stack)
            puts "    NG: #{comment}"
            puts "    answer: #{@answer}"
        end
    end

    def comment(before_stack, after_stack)
        "( #{before_stack} -- #{after_stack} )"
    end

    def execute(words)
        forth = Forth.new
        forth.evaluate("#{@initial_stack} #{words}")
        forth.stack.join(' ')
    end

end

