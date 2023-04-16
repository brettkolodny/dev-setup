# Copy fleek config
cp ~/.fleek.yml ./fleek.yml
# Copy helix config
cp -R ~/.config/helix ./helix
# Copy all npm modules
ls ~/.npm-packages/bin > npm-global.txt

git config --global user.name "brettkolodny"
git add .
git commit -m "Update configs"
git push