require 'question_generator'

class Application

    def main
        mode = parse_arguments
        generator = QuestionGenerator.new(mode: mode)
        question_loop(generator)
    end

    private

    def parse_arguments
        if !(ARGV.size <= 2)
            $stderr.puts "Invalid options: [#{ARGV[1..-1].join(' ')}]."
            exit 1
        end

        mode = case ARGV[1]
            when nil
                :shuffle
            when '--sample'
                :sample
            when '--shuffle'
                :shuffle
            else
                $stderr.puts "Invalid mode: [#{ARGV[1]}]."
                exit 1
        end

        mode
    end

    def question_loop(question_generator)
        question_generator.each do |question|
            question.challange
        end
    rescue EOFError => e
        # 入力が終了した場合はプログラムを終了する.
        puts
    end

end

