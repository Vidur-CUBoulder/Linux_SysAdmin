file { '/home/manager':
	ensure => 'directory',
	group => 'manager',
	mode => 2770,
}

file { '/home/sales':
	ensure => 'directory',
	group => 'sales',
	mode => 2770,
}

file { '/home/accounting':
	ensure => 'directory',
	group => 'accounting',
	mode => 2770,
}
