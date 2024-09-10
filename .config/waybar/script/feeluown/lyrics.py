
import socket
import json

def simulate_echo_status():
    # 创建一个TCP socket
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    output = ""
    try:
        # 连接到本地23333端口
        sock.connect(('localhost', 23333))
        
        # 发送"status"命令
        sock.sendall(b'status\n')
        
        # 接收响应
        response = b''
        recved = 0
        while recved < 3:
            chunk = sock.recv(1024)
            if not chunk:
                break
            # print(chunk)
            response += chunk
            recved += 1
        
        # 处理响应
        decoded_response = response.decode('utf-8')
        lines = decoded_response.split('\n')
        
        # 打印格式化的响应
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
out = {}
out["text"] = simulate_echo_status()
if out['text'] == "":
    out['text'] = "background ~"

# 将输出打印为JSON字符串
print(json.dumps(out, ensure_ascii=False))
