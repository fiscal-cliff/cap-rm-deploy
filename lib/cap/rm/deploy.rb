require "cap/rm/deploy/version"
require 'active_resource'

module Cap
  module Rm
    module Deploy
      class << self
        attr_accessor :configuration
      end
      class Configuration
        attr_accessor :site, :user, :password, :key
        attr_accessor :done_status_id, :status_id_to_update

        def initialize
          self.site = 'http://localhost:3000'
          self.user = 'user'
          self.password = 'useruser'
          self.done_status_id = 3
          self.status_id_to_update = [1]
        end
      end

      def self.configuration
        @configuration ||=  Configuration.new
      end

      def self.configure
        @configuration ||= Configuration.new
        yield(configuration) if block_given?
      end

      class Base < ActiveResource::Base
        class << self
          attr_accessor :key
        end

        self.site = Deploy.configuration.site
        self.user = Deploy.configuration.user
        self.password = Deploy.configuration.password
        self.format = ActiveResource::Formats::XmlFormat
        self.key = Deploy.configuration.key

        def save
          prefix_options[:key] = self.class.key
          super
        end
      end

      class Issue < Base
        def self.list(from)
          tasks = output.scan(/^[\t\ ]+.*((?<!D)(?<!\d)\d{4,5})/i).flatten.uniq
          puts "Found #{tasks.count} tasks, here are those ids: #{tasks.join(', ')}"
        end

        def process!
          return if Deploy.configuration.status_id_to_update.include?(self.status.id)
          reassign!
          self.done_ratio = 100
          self.status_id = Deploy.configuration.done_status_id
          puts "Updating #{self.id}..."
          save
        end

        private

        def reassign!
          self.assigned_to_id = author.id
        end
      end
    end
  end
end
