# Dotfile CLI 使用文档

## 简介

Dotfile CLI 是一个用于收集和管理配置文件（dotfiles）的命令行工具。它可以帮助您轻松地收集系统中的各种配置文件，并将它们集中存储在一个位置。

## 安装

1. 确保您的系统已安装 Python 3。
2. 克隆或下载此项目到本地。
3. 安装所需的依赖：
   ```
   pip install pyyaml
   ```

## 配置

在使用之前，您需要编辑 `targets.yaml` 文件来定义要收集的配置文件。文件格式如下：

```yaml
targets:
  "target/filepath": "src/file/path"
```

## 使用方法

Dotfile CLI 提供了以下命令：

1. 收集所有配置文件：
   ```
   python dotfile_cli.py collect
   ```

2. 收集特定配置文件：
   ```
   python dotfile_cli.py collect <target>
   ```
   其中 `<target>` 是在 `targets.yaml` 中定义的目标名称。

## 注意事项

- 确保在运行命令之前已正确配置 `targets.yaml` 文件。
- 收集的配置文件将被复制到当前工作目录下。
- 如果目标是一个目录，整个目录及其内容将被复制。

## 贡献

欢迎提交问题报告和改进建议。如果您想贡献代码，请先开一个 issue 讨论您的想法。

## 许可证

本项目采用 MIT 许可证。详情请参阅 [LICENSE](LICENSE) 文件。
