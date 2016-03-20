define assimp::wget_file($url=undef, $path=undef, $mode='0644'){
    exec{"get_${title}":
       command => "/usr/bin/wget -q ${url} -O ${path}",
       creates => $path,
    }

    file{
        "$path":
             mode    => $mode,
             require => Exec["get_${title}"];
        "$title":
             ensure  => link,
             target  => $path,
             require => File["$path"]
    }
}
