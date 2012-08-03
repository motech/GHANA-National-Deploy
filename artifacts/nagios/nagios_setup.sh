#!/bin/sh
remote_ip="10.16.3.109"
ghana_national_web_url="/ghana-national-web/login.jsp"
ssh_port="22"

echo "Disabling SELinux.."
setenforce 0
sed -i "s/=enforcing/=permissive/g" /etc/selinux/config

# Install RPMForge
echo "Installing RPMForge repository.."
rpm -Uvh http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.2-1.el6.rf.x86_64.rpm

echo "Installing dependencies.."
yum -y install  mailx sysstat crontabs httpd php gd

echo "Installing nagios with nrpe.."
yum -y install nagios-plugins nagios-nrpe nagios nagios-plugins-nrpe xinetd sipsak nagios-plugins-perl ruby nagios-plugins-check_sip

# NRPE: enabling arguments
sed -i 's/dont_blame_nrpe=0/dont_blame_nrpe=1/g' /etc/nagios/nrpe.cfg
sed -i 's/enable_embedded_perl=1/enable_embedded_perl=0/g' /etc/nagios/nrpe.cfg
# Change xinetd config file to 'disable = no' for nrpe
line_number=`grep -n 'disable' /etc/xinetd.d/nrpe | cut -d ':' -f 1`
sed -i "$line_number s/yes/no/" /etc/xinetd.d/nrpe
# Allow remote nrpe to communicate to the locate nrpe
line_number=`grep -n 'only_from' /etc/xinetd.d/nrpe | cut -d ':' -f 1`
sed -i "$line_number s/127.0.0.1/$remote_ip/" /etc/xinetd.d/nrpe

# Add remote-host.cfg
cp ./etc/nagios/objects/remote-host.cfg /etc/nagios/objects/
sed -i "s/#REMOTE_ADDRESS#/$remote_ip/g" /etc/nagios/objects/remote-host.cfg
sed -i "s/#GHANA_NATIONAL_WEB_URL#/`echo $ghana_national_web_url | replace '/' '\/'`/g" /etc/nagios/objects/remote-host.cfg
#sed -i "s/#GHANA_NATIONAL_WEB_URL#/$ghana_national_web_url/g" /etc/nagios/objects/remote-host.cfg
sed -i "s/#SSH_PORT#/$ssh_port/g" /etc/nagios/objects/remote-host.cfg

cat ./etc/nagios/objects/commands.cfg.append >> /etc/nagios/objects/commands.cfg
cat ./etc/nagios/nrpe.cfg.append >> /etc/nagios/nrpe.cfg

sed -i '/cfg_file=\/etc\/nagios\/objects\/localhost.cfg/a #Definitions for Monitoring Remote Host\ncfg_file=\/etc\/nagios\/objects\/remote-host.cfg' /etc/nagios/nagios.cfg

# edit /etc/servies
echo "Adding NRPE service in /etc/services.."
echo "# Added by Nagios setup with NRPE" >> /etc/services
echo "nrpe            5666/tcp                        # NRPE" >> /etc/services

# /usr/lib64/nagios/plugins/check_nrpe <= nagios-plugins-nrpe
check_nrpe_loc=`locate check_nrpe`
plugins_dir=`dirname $check_nrpe_loc`

#copy plugin files to /usr/lib64/nagios/plugins
cp plugins/* $plugins_dir

# add the following line to /etc/nagios/command-plugins.cfg
# command[check_nrpe]=/usr/lib64/nagios/plugins/check_nrpe -H $HOSTADDRESS$ -C $ARG1$


# By default a user called nagiosadmin/nagiosadmin is created by the yum packages
# If more users are required, then it can be done by executing the following command
# Also changes need to be made accordingly to
#	/etc/nagios/conf.d/internet.cfg
#	/etc/nagios/cgi.cfg
#	/etc/nagios/objects/contacts.cfg
# in order to grant privileges/authorisations to the new user
#htpasswd -c /usr/local/nagios/etc/passwd nagiosadmin

service xinetd restart
service httpd restart

echo "Starting Nagios..."
chkconfig --add nagios
chkconfig nagios on
service nagios restart

echo "Nagios installation is done."
echo "Adding a firewall rule to open port 5666 to $remote_ip"

service iptables start

line_number=`iptables -L INPUT --line-numbers -n | grep "dpt:$ssh_port" | cut -d ' ' -f 1`
/sbin/iptables -I INPUT "$line_number" -p tcp -s $remote_ip --dport 5666 -j ACCEPT

/sbin/iptables-save > /etc/sysconfig/iptables
