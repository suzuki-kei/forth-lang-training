
class Forth

    attr_reader :stack

    def initialize
        @stack = []
    end

    def evaluate(source)
        source.split.each(&method(:evaluate_one))
    end

    private

    def evaluate_one(value)
        case value
            when /^[-+]?\d+$/
                @stack.push(value.to_i)
            when '+'
                x1, x2 = safe_pop(2)
                @stack.push(x1 + x2)
            when '-'
                x1, x2 = safe_pop(2)
                @stack.push(x1 - x2)
            when '*'
                x1, x2 = safe_pop(2)
                @stack.push(x1 * x2)
            when '/'
                x1, x2 = safe_pop(2)
                @stack.push(x1 / x2)
            when 'abs'
                x1 = safe_pop
                @stack.push(x1.abs)
            when 'drop'
                safe_pop
            when 'dup'
                x1 = safe_pop
                @stack.push(x1, x1)
            when 'max'
                x1, x2 = safe_pop(2)
                @stack.push([x1, x2].max)
            when 'min'
                x1, x2 = safe_pop(2)
                @stack.push([x1, x2].min)
            when 'mod'
                x1, x2 = safe_pop(2)
                @stack.push(x1 % x2)
            when 'negate'
                x1 = safe_pop
                @stack.push(-x1)
            when 'nip'
                x1, x2 = safe_pop(2)
                @stack.push(x2)
            when 'over'
                x1, x2 = safe_pop(2)
                @stack.push(x1, x2, x1)
            when 'pick'
                n = safe_pop
                require_stack_size(n + 1)
                x = @stack[-n-1]
                @stack.push(x)
            when 'roll'
                n = safe_pop
                xs = safe_pop(n + 1)
                @stack.push(*xs[1..-1], xs[0])
            when 'rot'
                x1, x2, x3 = safe_pop(3)
                @stack.push(x2, x3, x1)
            when 'swap'
                x1, x2 = safe_pop(2)
                @stack.push(x2, x1)
            else
                raise ArgumentError, "invalid value: [#{value}]."
        end
    end

    def safe_pop(n=nil)
        require_stack_size(n || 1)

        if n.nil?
            @stack.pop
        else
            @stack.pop(n)
        end
    end

    def require_stack_size(n)
        if @stack.size < n
            raise ArgumentError, "Don't exists a required number of values on stack."
        end
    end

end

