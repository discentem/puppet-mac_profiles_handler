# manage mac profiles
define mac_profiles_handler::manage(
  $identifier = undef,
  $file_source = '',
  $ensure = 'present',
  $type = 'mobileconfig',
  $method = ''
) {

  if $facts['os']['name'] != 'Darwin' {
    fail('The mobileconfig::manage resource type is only supported on macOS')
  }

  if $method == '' {
    $processed_method = lookup('mac_profiles_handler::method', String, 'first', 'local')
  } else {
    $processed_method = $method
  }

  case $processed_method {
    'mdm': {
      mac_profiles_handler::mdm {$name:
        ensure      => $ensure,
        file_source => $file_source,
        type        => $type,
        identifier  => $identifier,
      }
    }
    default: {
      mac_profiles_handler::local{$name:
        ensure      => $ensure,
        file_source => $file_source,
        type        => $type,
      }
    }
  }



}

