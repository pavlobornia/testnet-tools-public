# Auto Buy Rolls Script

1. Install tmux
`sudo apt install tmux`

2. Run command
`curl -s https://raw.githubusercontent.com/pavlobornia/testnet-tools-public/master/massa/rolls.sh > rolls.sh && chmod  +x rolls.sh && tmux new-session -d -s rolls './rolls.sh'`

3. Check tmux session
`tmux attach-session`

4. Quit
press `Ctrl + B and D`
