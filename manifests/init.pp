#
# == Class: mariadb
#
# Class for installing and configuring a mariadb server.
#
# Packet filtering parts make use of mysql::packetfilter, so make sure that that 
# module is available. Also note that currently this module does not support 
# mariadb server configuration.
#
# == Parameters
#
# [*use_mariadb_repo*]
#   Use MariaDB's official software repositories. Valid values 'yes', 'stable', 
#   'testing', and 'no'. The default value, 'yes', and 'stable' install stable 
#   releases from MariaDB repos. Value 'testing' uses testing releases and 'no' 
#   uses whatever is available in the operating system's own repositories.
# [*proxy_url*]
#   The proxy URL used for fetching the MariaDB software repository public keys. 
#   For example "http://proxy.domain.com:8888". Not needed if the node has 
#   direct Internet connectivity, or if you're installing MariaDB from your 
#   operating system repositories. Defaults to 'none' (do not use a proxy).
# [*allow_addresses_ipv4*]
#   A list of IPv4 address/network from which to allow connections. Use special
#   value ['any'] to allow access from any IPv4 address. Defaults to
#   ['127.0.0.1'].
# [*allow_addresses_ipv6*]
#   IPv6 address/network from which to allow connections. Use special value
#   ['any'] to allow access from any IPv4 address. Defaults to ['::1'].
# [*email*]
#   Email address for notifications from monit. Defaults to top-scope variable 
#   $::servermonitor.
#
# == Examples
#
# include mariadb
#
# == Authors
#
# Samuli Seppänen <samuli.seppanen@gmail.com>
# Samuli Seppänen <samuli@openvpn.net>
# Mikko Vilpponen <vilpponen@protecomp.fi>
#
# == License
#
# BSD-lisence
# See file LICENSE for details
#
class mariadb
(
    $use_mariadb_repo = 'yes',
    $proxy_url = 'none',
    $allow_addresses_ipv4 = ['127.0.0.1'],
    $allow_addresses_ipv6 = ['::1'],
    $email = $::servermonitor
)
{

# Rationale for this is explained in init.pp of the sshd module
if hiera('manage_mariadb', 'true') != 'false' {

    class { 'mariadb::softwarerepo':
        use_mariadb_repo => $use_mariadb_repo,
        proxy_url => $proxy_url,
    }

    include mariadb::install
    include mariadb::service

    if tagged('packetfilter') {
        class { 'mysql::packetfilter':
            allow_addresses_ipv4 => $allow_addresses_ipv4,
            allow_addresses_ipv6 => $allow_addresses_ipv6,
        }
    }

    if tagged('monit') {
        class { 'mariadb::monit':
            monitor_email => $email,
        }
    }

}
}
