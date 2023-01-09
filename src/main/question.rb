
class Question

    def initialize(initial_stack, expected_stack, answer)
        @initial_stack = initial_stack
        @expected_stack = expected_stack
        @answer = answer
    end

    def to_s
        "( #{@initial_stack} -- #{@expected_stack} )"
    end

    def answer(words)
        IO.popen("gforth -e '#{@initial_stack} #{words} .s bye'") do |f|
            actual_stack = f.readline.gsub(/^<\d+>/, '').strip
            if actual_stack == @expected_stack
                puts '    OK'
            else
                puts "    NG: ( #{@initial_stack} -- #{actual_stack} )"
                puts "    expected: #{@answer}"
            end
        end
    end

end

