#
# == Class: mariadb::service
#
# Configure mariadb to start on boot
#
class mariadb::service {

    include mariadb::params

    service { 'mariadb':
        enable => true,
        name => "${::mariadb::params::service_name}",
        require => Class['mariadb::install'],
    }
}
