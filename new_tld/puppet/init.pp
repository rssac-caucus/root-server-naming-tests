class { '::knot': } ->
exec {'add ds records':
  command => '/vagrant/update_ds.sh',
  creates => '/var/lib/knot/root.zone.ds_added',
} ~> exec {'reload':
  command     => '/usr/sbin/knotc reload',
  refreshonly => true,
}
