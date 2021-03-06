# Creating users for everyone under manager
user { 'mscott':
	ensure => 'present',
	groups => 'manager',
	password => '$1$qRkDPKak$CrUAxzOhH3a1HTpC59VwW/',
	shell => '/bin/bash',
	uid => '556',
	managehome => true,
	home => '/home/mscott',
}

user { 'jhalpert':
	ensure => 'present',
	groups => 'manager',
	password => '$1$qRkDPKak$CrUAxzOhH3a1HTpC59VwW/',
	shell => '/bin/bash',
	uid => '557',
	managehome => true,
	home => '/home/jhalpert',
}

user { 'dschrute':
	ensure => 'present',
	groups => 'manager',
	password => '$1$qRkDPKak$CrUAxzOhH3a1HTpC59VwW/',
	shell => '/bin/bash',
	uid => '558',
	managehome => true,
	home => '/home/dschrute',
}

# creating users for everyone is accounting
user { 'kmalone':
	ensure => 'present',
	groups => 'accounting',
	password => '$1$qRkDPKak$CrUAxzOhH3a1HTpC59VwW/',
	shell => '/bin/bash',
	uid => '559',
	managehome => true,
	home => '/home/kmalone',
}

user { 'omartinez':
	ensure => 'present',
	groups => 'accounting',
	password => '$1$qRkDPKak$CrUAxzOhH3a1HTpC59VwW/',
	shell => '/bin/bash',
	uid => '560',
	managehome => true,
	home => '/home/omartinez',
}

user { 'amartin':
	ensure => 'present',
	groups => 'accounting',
	password => '$1$qRkDPKak$CrUAxzOhH3a1HTpC59VwW/',
	shell => '/bin/bash',
	uid => '561',
	managehome => true,
	home => '/home/amartin',
}

#creating users for everyone under sales
user { 'abernard':
	ensure => 'present',
	groups => 'sales',
	password => '$1$qRkDPKak$CrUAxzOhH3a1HTpC59VwW/',
	shell => '/bin/bash',
	uid => '562',
	managehome => true,
	home => '/home/abernard',
}

user { 'plapin':
	ensure => 'present',
	groups => 'sales',
	password => '$1$qRkDPKak$CrUAxzOhH3a1HTpC59VwW/',
	shell => '/bin/bash',
	uid => '563',
	managehome => true,
	home => '/home/plapin',
}

user { 'shudson':
	ensure => 'present',
	groups => 'sales',
	password => '$1$qRkDPKak$CrUAxzOhH3a1HTpC59VwW/',
	shell => '/bin/bash',
	uid => '564',
	managehome => true,
	home => '/home/shudson',
}

#Creating users for everyone else in D-M
user { 'tflenderson':
	ensure => 'present',
	password => '$1$qRkDPKak$CrUAxzOhH3a1HTpC59VwW/',
	shell => '/bin/bash',
	uid => '565',
	managehome => true,
	home => '/home/tflenderson',
}

user { 'dphilbin':
	ensure => 'present',
	password => '$1$qRkDPKak$CrUAxzOhH3a1HTpC59VwW/',
	shell => '/bin/bash',
	uid => '566',
	managehome => true,
	home => '/home/dphilbin',
}

user { 'cbratton':
	ensure => 'present',
	password => '$1$qRkDPKak$CrUAxzOhH3a1HTpC59VwW/',
	shell => '/bin/bash',
	uid => '567',
	managehome => true,
	home => '/home/cbratton',
}

user { 'kkapoor':
	ensure => 'present',
	password => '$1$qRkDPKak$CrUAxzOhH3a1HTpC59VwW/',
	shell => '/bin/bash',
	uid => '568',
	managehome => true,
	home => '/home/kkapoor',
}

user { 'mpalmer':
	ensure => 'present',
	password => '$1$qRkDPKak$CrUAxzOhH3a1HTpC59VwW/',
	shell => '/bin/bash',
	uid => '569',
	managehome => true,
	home => '/home/mpalmer',
}

user { 'pbeesly':
	ensure => 'present',
	password => '$1$qRkDPKak$CrUAxzOhH3a1HTpC59VwW/',
	shell => '/bin/bash',
	uid => '570',
	managehome => true,
	home => '/home/pbeesly',
}

# This is me!!
user { 'vsarin':
	ensure => 'present',
	password => '$1$qRkDPKak$CrUAxzOhH3a1HTpC59VwW/',
	shell => '/bin/bash',
	uid => '571',
	managehome => true,
	home => '/home/vsarin',
}
