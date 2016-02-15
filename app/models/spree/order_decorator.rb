module Spree
  Order.class_eval do
    def self.destroy_garbage
      self.garbage.destroy_all
    end

    def self.garbage
      garbage_after = Spree::GarbageCleaner::Config.cleanup_days_interval
      self.incomplete.where("updated_at <= ?", garbage_after.days.ago)
    end

    def garbage?
      garbage_after = Spree::GarbageCleaner::Config.cleanup_days_interval
      completed_at.nil? && updated_at <= garbage_after.days.ago
    end
  end
end
