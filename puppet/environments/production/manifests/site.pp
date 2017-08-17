$update_ds = lookup('update_ds')
node default {
  class { '::knot': }
}
node /^l5[245]/ {
  class { '::knot': } ->
  exec {'add ds records':
    command => $update_ds,
    creates => '/var/lib/knot/root.zone.ds_added',
  } ~> exec {'reload':
    command     => '/usr/sbin/knotc reload',
    refreshonly => true,
  }
}
