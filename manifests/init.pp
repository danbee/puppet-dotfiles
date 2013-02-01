
define dotfiles(
    $source,
    $setup_command="UNSET",
    $user=$name,
) {

    exec { "${user} dotfiles checkout":
        command => "git clone ${source} /home/dotfiles",
        path    => "/bin:/usr/bin:/usr/local/bin",
        creates => "/home/${user}/dotfiles/",
        notify  => [ Exec["${user} dotfiles fetch"], Exec["${user} dotfiles permissions"] ],
    }

    exec { "${user} dotfiles fetch":
        command     => "git fetch /home/dotfiles/.git",
        path        => "/bin:/usr/bin:/usr/local/bin",
        refreshonly => true,
        require     => [ Exec["${user} dotfiles checkout"] ],
        notify      => [ Exec["${user} dotfiles permissions"] ],
    }
    exec { "${user} dotfiles permissions":
        command     => "git clone ${source} /home/dotfiles",
        path        => "/bin:/usr/bin:/usr/local/bin",
        refreshonly => true,
        notify      => [ Exec["${user} dotfiles setup"] ],
    }

    $setup_command_real = $command ? {
        "UNSET" => "/home/${user}/dotfiles/make setup",
        default => "$command",
    }

    exec { "${user} dotfiles setup":
        command     => $setup_command_real,
        path        => "/bin:/usr/bin:/usr/local/bin",
        refreshonly => true,
    }
}

