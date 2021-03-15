name              'syslog_ng'
maintainer        'Sous Chefs'
maintainer_email  'help@sous-chefs.org'
license           'Apache-2.0'
description       'Installs and Configures syslog_ng'
source_url        'https://github.com/sous-chefs/syslog_ng'
issues_url        'https://github.com/sous-chefs/syslog_ng/issues'
chef_version      '>= 15.3'
version           '2.0.0'

supports 'debian'
supports 'ubuntu'
supports 'redhat'
supports 'centos'
supports 'fedora'
supports 'amazon'
supports 'scientific'
supports 'oracle'

depends 'yum-epel', '>= 3.3.0'
