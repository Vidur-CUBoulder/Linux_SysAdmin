file { '/home/manager':
	ensure => 'absent',
	group => 'manager',
	force => true,
	recurse => true,
}

file { '/home/sales':
	ensure => 'absent',
	group => 'sales',
	force => true,
	recurse => true,
}

file { '/home/accounting':
	ensure => 'absent',
	group => 'accounting',
	force => true,
	recurse => true,
}
