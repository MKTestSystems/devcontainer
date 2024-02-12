git submodule add https://@bitbucket.org/mkfw/$1.git
cd $1
git submodule update --init --recursive
cd ..
echo "add_subdirectory($1)" >> CMakeLists.txt
