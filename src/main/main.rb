require 'question_generator'

def main
    loop do
        QuestionGenerator.new.generate.tap do |questions|
            questions.each do |question|
                print "#{question} => "
                line = $stdin.readline
                question.answer(line)
            end
        end
    end
rescue EOFError => e
    # 入力が終了した場合はプログラムを終了する.
    puts
end

main

