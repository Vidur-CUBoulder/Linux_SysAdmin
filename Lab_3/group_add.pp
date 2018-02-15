group { 'manager':
	ensure => 'present',
	gid => '510',
}
group { 'sales':
	ensure => 'present',
	gid => '511',
}
group { 'accounting':
	ensure => 'present',
	gid => '512',
}
