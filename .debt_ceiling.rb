DebtCeiling.configure do |c|
  c.whitelist = %w(bin lib bench example)
  c.max_debt_per_module = 30
  c.debt_ceiling = 75
end
