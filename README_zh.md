# openGauss-webclient

一个基于 Go 语言编写的 Web 版 openGauss 数据库浏览器。

注意：该项目是一个对 pgweb 项目的分支和修改版本。

## 概述

openGauss-webclient 是一个基于 Go 语言的 Web 版 openGauss 数据库浏览器，可在 MacOS,Linux 和 Windows 等平台上运行。使用 Go 语言进行后端开发的主要目的是利用编译器在多平台生成零依赖二进制文件的能力。openGauss-webclient 的创建旨在构建一个非常简单和可移植的应用，用于与本地或远程 openGauss 数据库进行交互。

## 功能

+ 支持跨平台运行，支持 MacOS/Linux/Windows 32/64位系统。
+ 简单安装，(以单个二进制文件的形式分发)。
+ 零依赖项。
+ SSH 连接。
+ 多个数据库会话。
+ 简单的数据库浏览器。
+ 执行和分析自定义 SQL 查询。
+ 将表和查询数据导出为CSV/JSON/XML格式。
+ 查询历史记录。
+ 服务器书签。

## 使用方法

要开始服务器，请运行以下命令:

```
openGauss-webclient
```

您还可以提供连接标志:

```
openGauss-webclient --host localhost --user myuser --db mydb
```

支持连接 URL 方案:

```
openGauss-webclient --url opengauss://user:password@host:port/database?sslmode=[mode]
openGauss-webclient --url "opengauss:///database?host=/absolute/path/to/unix/socket/dir"
```

### 多个数据库会话

要启用 pgweb 中的多个数据库会话，请启动服务器并使用以下命令:

```
openGauss-webclient --sessions
```

或者设置环境变量:

```
SESSIONS=1 openGauss-webclient
```

## 从源代码构建

Go 1.7 是必要的。您可以使用 DNF 安装 Go:

```
dnf install -y golang
```

要编译源代码，请运行以下命令:

```
make setup
make dev
```

这将在当前目录下生成 openGauss-webclient 二进制文件。

此外，还有一项任务要编译其他操作系统的二进制文件:

```
make release
```

编译后的二进制文件将存储在 ./bin 目录中。

## 测试

在运行测试之前，请确保您在 localhost:5432 接口上运行了 openGauss 服务器。此外，您必须具有 openGauss 用户，该用户密码为 Gaussdb_123，可以在您的本地环境中创建新数据库。同时，openGauss-webclient 服务器不应该同时运行。

执行测试套件:

```
make test
```

如果您在本地使用 Docker，可以使用以下命令将所有支持的 openGauss 版本与 pgweb 测试套件一起运行:

```
make test-all
```

## 贡献

+ 克隆此仓库
+ 创建一个新的功能分支，用于添加新功能或修复错误
  提交更改
+ 执行测试套件
+ 提交代码并打开新的合并请求

## 许可证

MIT 许可证 (MIT)。请查看 LICENSE 文件以获取更多详细信息。