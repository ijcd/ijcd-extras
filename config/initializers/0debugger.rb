
# load ruby-debug on demand
def debugger
  if ["development", "test"].include? Rails.env
    require 'ruby-debug'
    super
  end
end

