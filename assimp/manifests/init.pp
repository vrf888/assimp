class assimp(
    $version    =   $assimp::params::version,
    $builddir   =   $assimp::params::builddir
) inherits assimp::params {
    require assimp::install

    file{"builddir":
        path   => $builddir,
        ensure => directory
    } ->
    
    wget_file { "$builddir/assimp.tgz":
        path => "$builddir/assimp${version}.tgz",
        url  => "https://github.com/assimp/assimp/archive/v${version}.tar.gz"
    } ~>

    exec{"unpack_assimp":
        command     => "/bin/tar xzf $builddir/assimp.tgz -C $builddir",
    } ~>

    file{"$builddir/assimp":
        ensure      =>  link,
        target      =>  "$builddir/assimp-${version}",
    } ~>

    exec{"cmake_assimp":
        cwd       => "$builddir/assimp",
        command   => "/usr/bin/cmake -DASSIMP_ENABLE_BOOST_WORKAROUND=OFF -G 'Unix Makefiles'",
    } ~>
    
    exec{"make_assimp":
        cwd     =>    "$builddir/assimp",
        command =>    "/usr/bin/make",
        timeout =>      900
    } ~>

    exec{"make_install_assimp":
        cwd       =>    "$builddir/assimp",
        command   =>    "/usr/bin/make install",
    } ~>

    exec{"install_pyhon_bindings_assimp":
        cwd       =>    "$builddir/assimp/port/PyAssimp",
        command   =>    "/usr/bin/python setup.py install", 
    } ~>

    exec{"ldconfig":
        command   =>    "/sbin/ldconfig",
    }

}

