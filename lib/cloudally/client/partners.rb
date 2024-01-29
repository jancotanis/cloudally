module CloudAlly
  class Client
    # Defines methods related to partners
    module PartnerPortal
      # Get CloudAlly Partner settings.
      #
      # @see https://api.cloudally.com/documentation#/Partner%20Portal
      def partners
        get("partners")
      end
      alias get_partner partners

      # Get Partner bills.
      #
      # @see https://api.cloudally.com/documentation#/Partner%20Portal
      def partner_bills
        get_paged("partners/bills")
      end

      # Get Partner bills.
      #
      # @see https://api.cloudally.com/documentation#/Partner%20Portal
      def partner_status
        get_paged("partners/status")
      end
      alias get_status_by_partner partner_status

      # Get Partner tasks.
      #
      # @see https://api.cloudally.com/documentation#/Partner%20Portal
      def partner_tasks
        get_paged("partners/tasks")
      end

      # Get Partner resellers.
      #
      # @see https://api.cloudally.com/documentation#/Partner%20Portal
      def partner_resellers(partner_id = nil)
        if partner_id
          get_paged("partners/resellers/#{partner_id}")
        else
          get_paged("partners/resellers")
        end
      end

      # Get Partner resellers.
      #
      # @see https://api.cloudally.com/documentation#/Partner%20Portal
      def get_resellers_list
        partner_resellers()
      end

      # Get Partner resellers.
      #
      # @see https://api.cloudally.com/documentation#/Partner%20Portal
      def get_reseller_by_partner_id partner_id
        partner_resellers(partner_id)
      end

      # Get Partner users.
      #
      # @see https://api.cloudally.com/documentation#/Partner%20Portal
      def partner_users
        get_paged("partners/users")
      end
      alias get_users_by_partner partner_users
    end
  end
end
