module Voting
  module Helpers
    module Urls
      def path_to(*args)
        url = ''
        args.each do |arg|
          klass = arg.class.to_s.split('::').last
          path_part = Extlib::Inflection.underscore(klass).pluralize
          url += "/#{path_part}/#{arg.id}"
        end
        url
      end
    end
  end
end
