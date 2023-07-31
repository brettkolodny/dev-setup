# Copy fleek config
cp ~/.fleek.yml ./fleek.yml
# Copy helix config
cp -R ~/.config/helix/config.toml ./helix/config.toml
cp -R ~/.config/helix/languages.toml ./helix/languages.toml
# Copy all npm modules
ls ~/.npm-packages/bin > npm-global.txt

git add .
git commit -m "Update configs"
git push