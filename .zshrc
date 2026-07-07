
# ==================== ZSH AI 自动补全 (0.5s全自动 + Ctrl+k全额补全版) ====================

AI_ASYNC_PID=0
AI_SUGGESTION=""

# 1. 智能抓取上下5行上下文并异步调用
_ai_auto_trigger() {
    # 强制清除旧的后台进程，防止重复提交
    if [ "$AI_ASYNC_PID" -ne 0 ]; then
        kill $AI_ASYNC_PID 2>/dev/null
    fi

    # 【智能 5 行上下文算法】：
    # 正常情况下光标在最后一行，下方没有内容。
    # 我们先抓取光标所在行往上共 5 行的屏幕快照
    local screen_context=$(tmux capture-pane -p -S -5 -E 0 2>/dev/null)
    
    # 如果抓取失败（比如不在 tmux 里），保底使用最后3行
    if [ -z "$screen_context" ]; then
        screen_context=$(tmux capture-pane -p -S -3 2>/dev/null)
    fi

    # 组合多行上下文与当前正在输入的缓冲区 ($BUFFER)
    local full_payload="${screen_context}\n$BUFFER"

    # 后台静默发送给 DeepSeek 脚本
    ~/zsh_ai_suggest.sh "$full_payload" &!
    AI_ASYNC_PID=$!
}

# 2. 0.5s 打字停顿自动防抖触发器
_ai_keypress_handler() {
    zle .self-insert
    
    # 🌟 只要开始打字，立刻物理强刷第二行为三个点，绝不留残影
    tmux set -g "status-format[1]" "#[fg=magenta]AI 思考中: #[fg=brightblack]..." 2>/dev/null
    tmux set-global @ai_suggestion "" 2>/dev/null
    tmux refresh-client -S 2>/dev/null

    if [ "$AI_ASYNC_PID" -ne 0 ]; then
        kill $AI_ASYNC_PID 2>/dev/null
    fi

    (
        sleep 0.5
        _ai_auto_trigger
    ) &!
    AI_ASYNC_PID=$!
}
zle -N self-insert _ai_keypress_handler

# 🌟 3. 拦截 Ctrl + k 快捷键：按下瞬间“直接全额替换/补充完整”
_ai_accept_whole_line() {
    # 实时去 tmux 抓取最新的完整建议
    AI_SUGGESTION=$(tmux show-options -gqv @ai_suggestion 2>/dev/null)

    if [ -n "$AI_SUGGESTION" ] && [ "$AI_SUGGESTION" != "null" ]; then
        # 将建议完整拼接到当前输入框的末尾
        BUFFER="$BUFFER$AI_SUGGESTION"
        CURSOR=$#BUFFER # 光标甩到最后
        
        # 补全完成，瞬间清空状态栏归位
        tmux set-global @ai_suggestion "" 2>/dev/null
        tmux set -g status-format[1] "#[fg=magenta]AI 替换中: #[fg=brightblack]..." 2>/dev/null
        tmux refresh-client -S 2>/dev/null
        zle redisplay
    fi
}
zle -N ai_accept_whole_line _ai_accept_whole_line
# 🌟 强行锁死 Ctrl + k 物理键
bindkey '^K' ai_accept_whole_line

# 4. 释放右方向键：将其恢复为原生的纯移动光标功能（不再劫持右键，交由 Ctrl+k 全权负责）
bindkey '^[[C' forward-char
bindkey '^[OC' forward-char

# ========================================================================================

alias ssproxy='nohup ss-local -c /etc/shadowsocks.json > /tmp/ai_ss-local.log 2>&1 &'

# 1. 指定历史文件路径（确保所有会话指向同一个文件）
HISTFILE=~/.zsh_history

# 2. 设置历史记录容量
# HISTSIZE:内存中保留的历史记录条数
# SAVEHIST:保存到文件中的历史记录条数
# 建议设置大一些，例如 10000 或更多
HISTSIZE=10000
SAVEHIST=10000

# 3. 关键选项：实现多窗口/多会话历史共享与实时保存
setopt INC_APPEND_HISTORY   # 立即追加新命令到历史文件，而不是等到会话结束
setopt SHARE_HISTORY        # 在不同终端会话之间共享历史记录
setopt APPEND_HISTORY       # 以追加模式写入历史文件，防止覆盖


proxy () {
  export http_proxy="http://127.0.0.1:1080"
  export https_proxy="http://127.0.0.1:1080"
  echo "HTTP Proxy on"
}

# where noproxy
noproxy () {
  unset http_proxy
  unset https_proxy
  echo "HTTP Proxy off"
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/welkin/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/welkin/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/welkin/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/welkin/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

