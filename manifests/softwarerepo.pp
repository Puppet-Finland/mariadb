#
# == Class: mariadb::softwarerepo
#
# Setup MariaDB apt repository. This class depends on the "puppetlabs/apt" 
# puppet module:
#
# <https://forge.puppetlabs.com/puppetlabs/apt>
#
# Proxy support requires a fairly recent version of apt module - 1.4.0 is known 
# to work.
#
class mariadb::softwarerepo
(
    $use_mariadb_repo,
    $proxy_url
)
{

    include mariadb::params

    if ($::osfamily == 'Debian') and ($use_mariadb_repo == 'yes') {

        apt::key { 'mariadb-aptrepo':
            key               => '1BB943DB',
            key_server        => 'hkp://keyserver.ubuntu.com',
            key_options       => $proxy_url ? {
                'none'        => undef,
                default       => "http-proxy=\"$proxy_url\"",
            },
        }
 
        apt::source { 'mariadb-aptrepo':
            location          => "${::mariadb::params::mariadb_apt_repo_location}",
            release           => "${::lsbdistcodename}",
            repos             => 'main',
            required_packages => undef,
            pin               => '502',
            include_src       => true,
            require => Apt::Key['mariadb-aptrepo'],
        }
    }
}
