
import socket
import json
import html
import asyncio

async def simulate_echo_status():
    # 创建一个TCP socket
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.setblocking(False)
    output = ""
    try:
        # 异步连接到本地23333端口
        await asyncio.get_event_loop().sock_connect(sock, ('localhost', 23333))
        
        # 异步发送"status"命令
        await asyncio.get_event_loop().sock_sendall(sock, b'status\n')
        
        # 异步接收响应
        response = b''
        recved = 0
        while recved < 3:
            try:
                chunk = await asyncio.wait_for(asyncio.get_event_loop().sock_recv(sock, 1024), timeout=1.0)
                if not chunk:
                    break
                response += chunk
                recved += 1
            except asyncio.TimeoutError:
                break
        
        # 处理响应
        decoded_response = response.decode('utf-8')
        lines = decoded_response.split('\n')
        
        # 处理格式化的响应
        for line in lines[2:]:
            if line.strip():
                key, value = line.split(':', 1)
                if key.strip() == "lyric-s":
                    output = value.strip()
                    
    except ConnectionRefusedError:
        print("无法连接到localhost:23333。请确保服务器正在运行。")
    except Exception as e:
        print(f"发生错误: {e}")
    finally:
        sock.close()
        # 关闭socket连接
    return output

# 运行模拟
async def main():
    out = {}
    out["text"] = await simulate_echo_status()
    if out['text'] == "":
        out['text'] = "background ~"

    # 转义特殊字符并将输出打印为JSON字符串
    out["text"] = html.escape(out["text"])
    print(json.dumps(out, ensure_ascii=False))

# 运行异步主函数
asyncio.run(main())
