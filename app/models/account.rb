class Account < ActiveRecord::Base
  attribute :admin_level, :integer, :limit => 1

  def self.register(user)
    account = Account.create!(
      username: user[:name],
      password: user[:pass_hash],
      salt: user[:salt],
      station_id: Random.new.rand(4294967295))
    return account.account_id
  end

  def self.update_sync(id, params)
    account = Account.find(id)
    account.update(AccountFormService.filter(params))
  end
end
