cp custom_half_life.zsh-theme /home/$USER/.oh-my-zsh/themes/custom_half_life.zsh-theme

sed -i.bak "s/half-life/custom_half_life/g" .zshrc

cp .zshrc /home/$USER/.zshrc