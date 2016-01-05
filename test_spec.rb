require 'serverspec'

set :backend, :exec

describe docker_image 'quay.io/postit12/d-java8-mvn:01.00.04' do
  it { should exist }

  # STIG Viewer Link: http://www.stigviewer.com/check/V-38437
  it "V-38437 Automated file system mounting tools must not be enabled unless needed." do
      # Check: To verify the "autofs" service is disabled, run the following command:
      #       chkconfig --list autofs
      #       If properly configured, the output should be the following:
      #       autofs 0:off 1:off 2:off 3:off 4:off 5:off 6:off
      #       Verify the "autofs" service is not running:
      #       # service autofs status
      #       If the autofs service is enabled or running, this is a finding.
      expect( package('autofs')).not_to be_installed
      expect( service('autofs')).not_to be_enabled
      expect( service('autofs')).not_to be_running
      # Fix: If the "autofs" service is not needed to dynamically mount NFS filesystems or removable media,
      #      disable the service for all runlevels:
      #       # chkconfig --level 0123456 autofs off
      #       Stop the service if it is already running:
      #       # service autofs stop
  end

  # STIG Viewer Link: http://www.stigviewer.com/check/V-38443
  it "V-38443 The /etc/gshadow file must be owned by root." do
      # Check: To check the ownership of "/etc/gshadow", run the command:
      #       $ ls -l /etc/gshadow
      #       If properly configured, the output should indicate the following owner: "root"
      #       If it does not, this is a finding.
      expect( file('/etc/gshadow')).to be_owned_by 'root'
      # Fix: To properly set the owner of "/etc/gshadow", run the command:
      #       # chown root /etc/gshadow
  end

  # STIG Viewer Link: http://www.stigviewer.com/check/V-38477
  it "V-38477 Users must not be able to change passwords more than once every 24 hours." do
      # Check: To check the minimum password age, run the command:
      #       $ grep PASS_MIN_DAYS /etc/login.defs
      #       The DoD requirement is 1.
      #       If it is not set to the required value, this is a finding.
      expect( file('/etc/login.defs')).to contain /^PASS_MIN_DAYS 1/
      # Fix: To specify password minimum age for new accounts, edit the file "/etc/login.defs" and add or correct the following line, replacing [DAYS] appropriately:
      #       PASS_MIN_DAYS [DAYS]
      #       A value of 1 day is considered sufficient for many environments. The DoD requirement is 1.
  end

end
