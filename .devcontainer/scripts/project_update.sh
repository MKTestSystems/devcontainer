git clone git@github.com:MKTestSystems/project_template.git

if [[ `cmp --silent -- "project_template/.devcontainer/Dockerfile" "./.devcontainer/Dockerfile"` ]]; then
    echo "Dockerfile already up to date"
else
    cp -f project_template/.devcontainer/Dockerfile ./.devcontainer/Dockerfile
    echo "Dockerfile updated, rebuild container to apply changes"
fi
if [[ `cmp --silent -- "project_template/.clang-tidy" "./.clang-tidy"` ]]; then
    echo "Clang Tidy rules already up to date"
else
    cp -f project_template/.clang-tidy ./.clang-tidy
    echo "Clang Tidy rules updated"
fi

if [[ `cmp --silent -- "project_template/.clang-format" "./.clang-format"` ]]; then
    echo "Clang Format rules already up to date"
else
    cp -f project_template/.clang-format ./.clang-format
    echo "Clang Format rules updated"
fi

if [[ `cmp --silent -- "project_template/.vscode/settings.json" "./.vscode/settings.json"` ]]; then
    echo "VSCode Settings already up to date"
else
    cp -f project_template/.vscode/settings.json ./.vscode/settings.json
    echo "VSCode Settings updated"
fi

rm -r project_template
