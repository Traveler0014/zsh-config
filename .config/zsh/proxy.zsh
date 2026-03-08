# 代理快速启停脚本（可拔插：删除或不再 source 即禁用）
# 用法：proxy_on | proxy_off | proxy_toggle | proxy_status

# 默认代理地址（可按需在 source 前覆盖）
: "${PROXY_URL:=http://127.0.0.1:7890}"
: "${PROXY_SOCKS_URL:=socks5://127.0.0.1:7890}"

proxy_on() {
  export http_proxy="$PROXY_URL"
  export https_proxy="$PROXY_URL"
  export all_proxy="$PROXY_SOCKS_URL"
  export HTTP_PROXY="$PROXY_URL"
  export HTTPS_PROXY="$PROXY_URL"
  export ALL_PROXY="$PROXY_SOCKS_URL"
  echo "proxy on: http(s)=$PROXY_URL, socks=$PROXY_SOCKS_URL"
}

proxy_off() {
  unset http_proxy https_proxy all_proxy
  unset HTTP_PROXY HTTPS_PROXY ALL_PROXY
  echo "proxy off"
}

proxy_toggle() {
  if [[ -n "${http_proxy:-}" ]]; then
    proxy_off
  else
    proxy_on
  fi
}

proxy_status() {
  if [[ -n "${http_proxy:-}" ]]; then
    echo "proxy: on"
    echo "  http_proxy=$http_proxy"
    echo "  https_proxy=$https_proxy"
    echo "  all_proxy=$all_proxy"
  else
    echo "proxy: off"
  fi
}
