# Focus on nearest test
Leverage [dispatch][dispatch]'s `:FocusDispatch` command to focus on the test
under the cursor. It only supports minitest and RSpec. And the files must end in
`_test.rb` for minitest and `_spec.rb` for RSpec.

It works for the test-dsl `test "thing" do; end` in found in Rails aswell as the
normal `def test_thing; end`.

[dispatch]: https://github.com/tpope/vim-dispatch

## Usage
```viml
:call FocusOnNearestTest
```

Then just fire away `:Dispatch` to re-run the test.
