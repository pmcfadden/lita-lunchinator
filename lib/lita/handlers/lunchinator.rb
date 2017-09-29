module Lita
  module Handlers
    class Lunchinator < Handler
      NAMES = 'lunchinator-names'
      DIVIDER = ';'
      # insert handler code here
      #
      route(/^lunchinator add (.+)$/, :add_name, command: true)
      route(/lunchinator list/, :list_names, command: true)
      route(/lunchinator roll/, :choose_name, command: true)

      def add_name response
        name = response.matches[0][0]
        new_list = names.push(name) unless names.include?(name)
        redis.set(NAMES, new_list.join(DIVIDER))
        response.reply "Adding #{response.matches[0][0]} to the lunchinator rotation"
      end

      def list_names response
        response.reply("Current individuals added are #{names.join(', ')}.")
      end

      def choose_name response
        response.reply "#{names.sample} is the winner!"
      end

      Lita.register_handler(self)

      private

      def names
        names_list = redis.get(NAMES) || ""
        names_list.split(DIVIDER)
      end
    end
  end
end
