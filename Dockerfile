FROM archlinux

WORKDIR /

RUN pacman -Syu --noconfirm
RUN pacman -S sudo --noconfirm
RUN pacman -S neovim --noconfirm
RUN pacman -S git --noconfirm
RUN pacman -S curl --noconfirm
RUN pacman -S coreutils --noconfirm
RUN pacman -S openssh --noconfirm


# Elixir Stuff 
RUN pacman -S jdk25-openjdk --noconfirm
RUN pacman -S gnu-free-fonts --noconfirm
RUN pacman -S elixir --noconfirm
RUN pacman -S erlang --noconfirm

RUN groupadd -g 960 billydocker
RUN useradd -m -u 1000 -g 960 billydocker -s /bin/bash

RUN echo "billydocker ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN chown -R billydocker:billydocker /home/billydocker

COPY  "/.config/nvim" "home/billydocker/.config/nvim"
COPY  ".local/share/nvim/" "home/billydocker/.local/share/nvim"
RUN chown -R billydocker:billydocker /home/billydocker/.local

WORKDIR /home/billydocker/workspace

USER billydocker

CMD ["tail", "-f", "/dev/null"]
# CMD ["sudo systemctl start sshd.service"]

EXPOSE 4000

