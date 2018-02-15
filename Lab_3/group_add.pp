group { 'manager':
	ensure => 'absent',
	gid => '510',
}
group { 'sales':
	ensure => 'absent',
	gid => '511',
}
group { 'accounting':
	ensure => 'absent',
	gid => '512',
}
