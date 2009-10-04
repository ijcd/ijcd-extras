module ActionViewNoisyRender
  def self.included(base)
    base.class_eval do
      alias_method :render_without_noise, :render
        
      def render(view, local_assigns={})
        filename = view.instance_variable_set(:@_first_render, self).instance_variable_get(:@filename)      
        result = render_without_noise(view, local_assigns)
        if /\.(rb|rhtml|html\.erb)$/ =~ filename
          "<!-- START #{filename} -->\n#{result}\n<!-- END #{filename} -->"
        else
          result
        end
      end
    end
  end
end

if Rails.env == "development"                               
  if /^[1yt]/i =~ ENV['NOISYRENDER']
    RAILS_DEFAULT_LOGGER.info("Using ActionViewNoisyRender")
    ActionView::Template.send(:include, ActionViewNoisyRender) 
  end
end
