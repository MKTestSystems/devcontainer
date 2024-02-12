tags=$(git tag -l)

#. "$(git --exec-path)/git-sh-setup"

release_name=""

do_release()
{
    if [[ $(git status --porcelain) ]]; then
        echo "repository not clean, exitting"
        exit 1
    fi

    git tag $release_name
    git push 
    git push --tags
}

get_release_name()
{
    if [[ $(echo $(echo "$tags" | grep -E -c '^[0-9]{4}$')) -lt 1 ]] 
    then
        echo "No previous release found"
        rel="0100"
    else
        echo last release found: $(echo "$tags" | grep -E '^[0-9]{4}$' | tail -1)
    fi

    conf=n
    while [ $conf != y ]
    do
        until [[ $release_name =~ [0-9]{4} ]]
        do
            read -p 'Enter release number (eg 0100):' release_name
            if ! [[ $release_name =~ [0-9]{4} ]]
            then
                echo "input format incorrect"
            fi
        done    
        read -p "Confirm release $release_name (y/n)" conf
        if [ $conf != y ]
        then
            release_name=""
        fi
    done

    if [ $(git tag -l "$release_name") ]; then
        echo "Release already exists"
        exit 0
    fi
}

build()
{
    /cmake/bin/cmake --build build/Release --config Release --target clean -j 14 --
    /cmake/bin/cmake --build build/Release --config Release --target all -j 14 --
}

get_release_name

#require_clean_work_tree release "fix stuff"

do_release

build




