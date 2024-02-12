
#get script source directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
#get template project directory
TEMPLATE_DIR=$(dirname "$SCRIPT_DIR")/project_template

#set project name as current directory name
PROJECT_NAME=${PWD##*/} 
DEVICE=""

#replace project name placeholders 
sed -i -e 's|<NAME>|'"$PROJECT_NAME"'|g' ./.vscode/launch.json
sed -i -e 's|<NAME>|'"$PROJECT_NAME"'|g' CMakeLists.txt

if [[ "$1" == "6904" ]]; then
    add_submodule.sh leo-6904
    sed -i -e 's|<SVD>|\${workspaceRoot}/leo-6904/STM32L4R9.svd|g' ./.vscode/launch.json    
    sed -i -e 's|<TOOLCHAIN>|leo-6904/toolchain.cmake|g' CMakeLists.txt    
    DEVICE=STM32L4R9ZI
else
cp 
    read -p "Enter the device ID for JLink (eg STM32L4R9ZI):" DEVICE
fi

sed -i -e 's|<DEVICE>|'"$DEVICE"'|g' ./.vscode/launch.json


