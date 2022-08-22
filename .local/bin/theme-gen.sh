#/bin/sh
# Generates theme in '~/.theme-dist' from template
src="$HOME/.config/theme-template"
dst="$HOME/.local/share/theme"
rm -rf $dst
cp -r $src/static $dst
teraformer -i $src/themes/current -o $dst yaml "$src/templates/**"
