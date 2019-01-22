# # encoding: utf-8

# Inspec test for recipe syslog_ng_test::destination

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe service('syslog-ng') do
  it { should be_running }
end

describe file('/etc/syslog-ng/destination.d/d_test.conf') do
  it { should exist }
  its('type') { should cmp 'file' }
  it { should be_file }
  it { should_not be_directory }
end
