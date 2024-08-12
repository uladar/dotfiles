# Source .bashrc if exists
[[ -r $HOME/.bashrc ]] && . $HOME/.bashrc

# when mysql2 gem failed to install
#export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
#export LDFLAGS="-L/usr/local/opt/mysql@5.7/lib"
#export CPPFLAGS="-I/usr/local/opt/mysql@5.7/include"
#export PKG_CONFIG_PATH="/usr/local/opt/mysql@5.7/lib/pkgconfig"
#export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/opt/openssl/lib/

#  Remove it after installing qt5.5 via homebrew
#export PATH="/Users/gv1d/.bin/Qt5.5.0/5.5/clang_64/bin/:$PATH"
export PATH="/usr/local/opt/qt@5.5/bin:$PATH"
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"
