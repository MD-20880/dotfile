const net = require('net');
const html = require('html-escaper');

async function simulateEchoStatus() {
    return new Promise((resolve, reject) => {
        const client = new net.Socket();
        let output = "";

        client.connect(23333, 'localhost', () => {
            client.write('status\n');
        });

        client.on('data', (data) => {
            const lines = data.toString().split('\n');
            for (let line of lines.slice(2)) {
                if (line.trim()) {
                    const [key, value] = line.split(':', 2);
                    if (key.trim() === "lyric-s") {
                        output = value.trim();
                        break;
                    }
                }
            }
            client.destroy();
        });

        client.on('close', () => {
            resolve(output);
        });

        client.on('error', (err) => {
            if (err.code === 'ECONNREFUSED') {
                console.error("无法连接到localhost:23333。请确保服务器正在运行。");
            } else {
                console.error(`发生错误: ${err.message}`);
            }
            resolve("");
        });
    });
}

async function main() {
    let out = {};
    out.text = await simulateEchoStatus();
    if (out.text === "") {
        out.text = "background ~";
    }

    out.text = html.escape(out.text);
    console.log(JSON.stringify(out));
}

main().catch(console.error);
