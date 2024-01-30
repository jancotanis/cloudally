require 'Dotenv'
require 'logger'
require "test_helper"

CLIENT_LOGGER = "client_test.log"
File.delete(CLIENT_LOGGER) if File.exist?(CLIENT_LOGGER)

def respond_to_template(template, object, class_name)
  template.keys do |k|
    assert  object.respond_to?(k.to_sym), "method #{class_name}.#{k}"
  end
end

describe 'client' do
  before do
    Dotenv.load
    CloudAlly.configure do |config|
      config.client_id = ENV["CLOUDALLY_CLIENT_ID"]
      config.client_secret = ENV["CLOUDALLY_CLIENT_SECRET"]
      config.username = ENV["CLOUDALLY_USER"]
      config.password = ENV["CLOUDALLY_PASSWORD"]
      config.logger = Logger.new(CLIENT_LOGGER)
    end
    CloudAlly.partner_login
    @client = CloudAlly.client
  end

  it "#1 GET /v1/partners getPartner" do
    partner = @client.get_partner
    refute partner.partnerId.nil?, "partner.partnerId"
    assert value(partner.email.upcase).must_equal ENV["CLOUDALLY_USER"].upcase, "partner.email"
    template = {
      "partnerId": "string",
      "email": "string",
      "contactName": "string",
      "discount": 0,
      "phone": "string",
      "currency": "USD",
      "address": "string",
      "region": "US_EST"
    }
    respond_to_template(template, partner, "partner")
  end
  it "#2 GET /v1/partners/tasks" do
    template =
      {
        "id": "string",
        "account": "string",
        "type": "BACKUP",
        "source": "GMAIL",
        "userId": "string",
        "domain": "string",
        "status": "ACTIVE",
        "region": "US_EST",
        "alias": "string",
        "backupTaskId": "string",
        "index": true,
        "snapshotDate": 0,
        "lastBackupDates": {
          "additionalProp1": 0,
          "additionalProp2": 0,
          "additionalProp3": 0
        },
        "nextBackup": "string",
        "progress": {
          "current": 0,
          "state": "PREPARE",
          "service": "string",
          "cancelled": true
        },
        "size": 0,
        "createDate": "2024-01-26T12:59:57.801Z",
        "numOfBilledEntities": 0,
        "numOfEntities": 0,
        "userEmail": "string",
        "multiEntitiesTask": true
      }
    tasks = @client.partner_tasks
    respond_to_template(template, tasks.first, "task")
  end
  it "#3 GET /v1/partners/status" do
    template =
      {
        "userId": "string",
        "taskId": "string",
        "source": "GMAIL",
        "entityName": "string",
        "lastBackupDate": "string",
        "lastBackupAttemptDate": "string",
        "backupDuration": 0,
        "size": 0,
        "backupStatus": [
          {
            "subSource": "string",
            "status": "string",
            "error": "string",
            "errFAQLink": "string"
          }
        ]
      }
    status = @client.partner_status
    respond_to_template(template, status.first, "status")
  end
  it "#4 GET /v1/partners/bills" do
    template =
      {
        "name": "string",
        "period": "string",
        "discount": "string",
        "total": "string",
        "lines": [
          {
            "serviceType": "string",
            "service": "string",
            "quantity": "string",
            "price": "string",
            "total": "string",
            "seat": "string",
            "storage": "string",
            "source": "GMAIL"
          }
        ],
        "paymentType": "string",
        "trialDaysLeft": 0,
        "subscribed": true
      }
    bills = @client.partner_bills
    respond_to_template(template, bills.first, "bills")
  end
  it "#5 GET /v1/partners/users getUsersByPartner" do
    template =
    {
      "id": "string",
      "name": "string",
      "email": "string",
      "status": "ACTIVE",
      "date": 0,
      "dailyReport": true,
      "region": "US_EST",
      "discount": 0,
      "reportEmails": [
        "string"
      ],
      "partnerID": "string",
      "currency": "USD",
      "customStorage": {
        "type": "S3"
      },
      "ms365EnterprisePlan": true,
      "gsuiteEnterprisePlan": true
    }

    users = @client.partner_users
    assert !users.first.customStorage.type, "user.customStorage.type" if users.first.customStorage
    assert !users.first.reportEmails.first, "user.reportEmails[]" if users.first.reportEmails.length > 0
    respond_to_template(template, users.first, "users")
  end
=begin not authorised to get for resellers list
  it "#6 GET /v1/partners/resellers get_resellers_list" do
    template =
      {
        "resellerName": "string",
        "contactName": "string",
        "resellerEmail": "string",
        "partnerId": "string",
        "region": "string",
        "countryCode": "string",
        "customStorage": {
          "type": "S3"
        },
        "waiveSharedMailboxes": true,
        "whiteLabel": true,
        "notificationSettings": {
          "provideType": "LINK",
          "reportFreq": "WEEKLY",
          "reportDay": "MONDAY",
          "sendSummaryReport": true,
          "failureOnlyReport": true
        }
      }

    resellers = @client.partner_resellers
    respond_to_template(template, resellers.first, "resellers")
  end
=end
end
