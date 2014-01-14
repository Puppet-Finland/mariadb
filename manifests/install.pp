#
# == Class: mariadb::install
#
# Install mariadb server
#
class mariadb::install {

    include mariadb::params

    package { 'mariadb-server':
        ensure => installed,
        name => "${::mariadb::params::package_name}",
        require => Class['mariadb::softwarerepo'],
    }
}
