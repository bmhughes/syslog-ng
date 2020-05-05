#
# Cookbook:: syslog_ng
# Spec:: rewrite_spec
#
# Copyright:: 2018, Ben Hughes <bmhughes@bmhughes.co.uk>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'spec_helper'

describe 'syslog_ng_test::rewrite' do
  platforms = {
    'CentOS' => '8',
    'Fedora' => '30',
    'Amazon' => '2',
    'Debian' => '10',
    'Ubuntu' => '18.04',
  }

  platforms.each do |platform, version|
    context "With test recipe, on #{platform} #{version}" do
      let(:chef_run) do
        runner = ChefSpec::SoloRunner.new(platform: platform.dup.downcase!, version: version)
        runner.converge(described_recipe)
      end

      it 'converges successfully' do
        expect { chef_run }.to_not raise_error
      end

      %w(
        r_test_ip
        r_test_set
        r_test_set_additional
        r_test_unset
        r_test_groupunset
        r_test_groupset_single
        r_test_groupset_array
        r_test_set_condition
        r_test_set_tag
        r_test_clear_tag
        r_test_credit_card_mask
        r_test_multiple).each do |testrewrite|
        it "creates rewrite #{testrewrite}" do
          expect(chef_run).to create_syslog_ng_rewrite(testrewrite)

          dest = chef_run.syslog_ng_rewrite(testrewrite)
          expect(dest).to notify('execute[syslog-ng-config-test]').to(:run).delayed
          expect(dest).to notify('service[syslog-ng]').to(:reload).delayed
        end
      end
    end
  end
end