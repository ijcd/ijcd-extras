require 'spec/runner/formatter/progress_bar_formatter'

class FailFastFormatter < Spec::Runner::Formatter::ProgressBarFormatter
  def example_failed(example, counter, failure)
    super
    @output.puts "Aborting after first failure"
    exit
  end
end
