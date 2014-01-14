#
# == Class: mariadb::params
#
# Defines some variables based on the operating system
#
class mariadb::params {

    case $::osfamily {
        'Debian': {
            $package_name = 'mariadb-server'
            $service_name = 'mysql'
            $service_start = "/usr/sbin/service $service_name start"
            $service_stop = "/usr/sbin/service $service_name stop"
            $pidfile = '/var/run/mysqld/mysqld.pid'

            if $::operatingsystem == 'Debian' {
                $mariadb_apt_repo_location = 'http://mirror.netinch.com/pub/mariadb/repo/5.5/debian'
            } elsif $::operatingsystem == 'Ubuntu' {
                $mariadb_apt_repo_location = 'http://mirror.netinch.com/pub/mariadb/repo/5.5/ubuntu'
            }
        }
        default: {
            $package_name = 'mariadb-server'
            $service_name = 'mysql'
            $service_start = "/usr/sbin/service $service_name start"
            $service_stop = "/usr/sbin/service $service_name stop"
            $pidfile = '/var/run/mysqld/mysqld.pid'

            if $::operatingsystem == 'Debian' {
                $mariadb_apt_repo_location = 'http://mirror.netinch.com/pub/mariadb/repo/5.5/debian'
            } elsif $::operatingsystem == 'Ubuntu' {
                $mariadb_apt_repo_location = 'http://mirror.netinch.com/pub/mariadb/repo/5.5/ubuntu'
            }
        }
    }
}
