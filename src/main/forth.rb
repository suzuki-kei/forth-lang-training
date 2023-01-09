
class Forth

    attr_reader :stack

    def initialize
        @stack = []
    end

    def evaluate(source)
        source.split.each do |value|
            self.evaluate_one(value)
        end
    end

    private

    def evaluate_one(value)
        case value
            when /^[-+]?\d+$/
                @stack.push(value.to_i)
            when '+'
                x1, x2 = @stack.pop(2)
                @stack.push(x1 + x2)
            when '-'
                x1, x2 = @stack.pop(2)
                @stack.push(x1 - x2)
            when '*'
                x1, x2 = @stack.pop(2)
                @stack.push(x1 * x2)
            when '/'
                x1, x2 = @stack.pop(2)
                @stack.push(x1 / x2)
            when 'abs'
                x1 = @stack.pop
                @stack.push(x1.abs)
            when 'drop'
                @stack.pop
            when 'dup'
                x1 = @stack.pop
                @stack.push(x1, x1)
            when 'max'
                x1, x2 = @stack.pop(2)
                @stack.push([x1, x2].max)
            when 'min'
                x1, x2 = @stack.pop(2)
                @stack.push([x1, x2].min)
            when 'mod'
                x1, x2 = @stack.pop(2)
                @stack.push(x1 % x2)
            when 'negate'
                x1 = @stack.pop
                @stack.push(-x1)
            when 'nip'
                x1, x2 = @stack.pop(2)
                @stack.push(x2)
            when 'over'
                x1, x2 = @stack.pop(2)
                @stack.push(x1, x2, x1)
            when 'pick'
                n = @stack.pop
                x = @stack[-n-1]
                @stack.push(x)
            when 'roll'
                n = @stack.pop
                xs = @stack.pop(n + 1)
                @stack.push(*xs[1..-1], xs[0])
            when 'rot'
                x1, x2, x3 = @stack.pop(3)
                @stack.push(x2, x3, x1)
            when 'swap'
                x1, x2 = @stack.pop(2)
                @stack.push(x2, x1)
            else
                raise ArgumentError, "invalid value: [#{value}]."
        end
    end

end

