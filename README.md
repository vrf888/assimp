# Assimp libraryb installation module
1. Create VM using provided Vagrant file
2. Set desired Assipm library version in params.pp
3. Put module directory to /vagrant shared directory
3. Install module using:
puppet apply --modulepath=/vagrant -e "include assimp"
