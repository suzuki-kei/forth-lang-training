require 'test/unit'
require 'forth'

class ForthTestCase < Test::Unit::TestCase

    def setup
        @forth = Forth.new
    end

    def test_value
        @forth.evaluate('1')
        assert_equal([1], @forth.stack)

        @forth.evaluate('2')
        assert_equal([1, 2], @forth.stack)

        @forth.evaluate('3')
        assert_equal([1, 2, 3], @forth.stack)
    end

    def test_add
        @forth.evaluate('1 2 +')
        assert_equal([3], @forth.stack)
    end

    def test_subtract
        @forth.evaluate('3 1 -')
        assert_equal([2], @forth.stack)
    end

    def test_multiply
        @forth.evaluate('2 3 *')
        assert_equal([6], @forth.stack)
    end

    def test_divide
        @forth.evaluate('8 2 /')
        assert_equal([4], @forth.stack)
    end

    def test_abs
        @forth.evaluate('123 abs -123 abs')
        assert_equal([123, 123], @forth.stack)
    end

    def test_drop
        @forth.evaluate('1 2 3')

        @forth.evaluate('drop')
        assert_equal([1, 2], @forth.stack)

        @forth.evaluate('drop')
        assert_equal([1], @forth.stack)

        @forth.evaluate('drop')
        assert_equal([], @forth.stack)
    end

    def test_dup
        @forth.evaluate('1 dup')
        assert_equal([1, 1], @forth.stack)
    end

    def test_max
        @forth.evaluate('1 1 max 1 2 max 2 1 max')
        assert_equal([1, 2, 2], @forth.stack)
    end

    def test_min
        @forth.evaluate('1 1 min 1 2 min 2 1 min')
        assert_equal([1, 1, 1], @forth.stack)
    end

    def test_mod
        @forth.evaluate('0 3 mod 1 3 mod 2 3 mod 3 3 mod 4 3 mod 5 3 mod')
        assert_equal([0, 1, 2, 0, 1, 2], @forth.stack)
    end

    def test_negate
        @forth.evaluate('123 negate -123 negate')
        assert_equal([-123, 123], @forth.stack)
    end

    def test_nip
        @forth.evaluate('1 2 nip')
        assert_equal([2], @forth.stack)
    end

    def test_over
        @forth.evaluate('1 2 over')
        assert_equal([1, 2, 1], @forth.stack)
    end

    def test_pick
        expected = []

        @forth.evaluate('1 2 3 0 pick')
        expected.append(1, 2, 3, 3)

        @forth.evaluate('1 2 3 1 pick')
        expected.append(1, 2, 3, 2)

        @forth.evaluate('1 2 3 2 pick')
        expected.append(1, 2, 3, 1)

        assert_equal(expected, @forth.stack)
    end

    def test_roll
        expected = []

        @forth.evaluate('1 2 3 0 roll')
        expected.append(1, 2, 3)

        @forth.evaluate('1 2 3 1 roll')
        expected.append(1, 3, 2)

        @forth.evaluate('1 2 3 2 roll')
        expected.append(2, 3, 1)

        assert_equal(expected, @forth.stack)
    end

    def test_rot
        @forth.evaluate('1 2 3 rot')
        assert_equal([2, 3, 1], @forth.stack)
    end

    def test_swap
        @forth.evaluate('1 2 swap')
        assert_equal([2, 1], @forth.stack)
    end

end

