#
# == Class: mariadb::monit
#
# Setups monit rules for mariadb
#
class mariadb::monit
(
    $monitor_email
)
{
    monit::fragment { 'mariadb-mariadb.monit':
        modulename => 'mariadb',
    }
}
