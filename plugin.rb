# frozen_string_literal: true

# name: discourse-change-owner
# about: Allow staff to change post owner in the review queue 
# version: 0.1
# author: Faizaan Gagan
# url: https://github.com/paviliondev/discourse-change-owner

enabled_site_setting :change_owner_enabled

after_initialize do
  ReviewableQueuedPostSerializer.class_eval do
    payload_attributes(:user)
  end

  module ReviewableQueuedPostCustomPayload
    def build_editable_fields(fields, guardian, args)
      super
      return unless SiteSetting.change_owner_enabled

      fields.add('payload.user', :user)
    end

    def perform_approve_post(performed_by, args)
      self.created_by = User.find_by(username: payload['user']) if payload['user'].present?
      super
    end
  end

  reloadable_patch do
    ::ReviewableQueuedPost.prepend ReviewableQueuedPostCustomPayload
  end
end
