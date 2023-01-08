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
    puts
end

main

