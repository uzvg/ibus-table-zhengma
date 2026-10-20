# ibus-table-zhengma

> 郑码（ZhengMa）的 IBus 表数据包，使用 Meson + Ninja 构建。

## 项目说明

这是一个**纯数据**的 IBus 输入法表项目。仓库的核心是
`tables/zhengma.txt`，构建时由 `ibus-table-createdb` 生成
`zhengma.db`，再安装到 IBus 的表目录中。

原项目使用 GNU Autotools，构建前需要 `./autogen.sh`、`./configure`、
`make` 等多步操作，维护和打包都比较麻烦。本仓库由 **uzvg** 在 LLM
协助下迁移到 **Meson + Ninja**：保留原有表数据、安装布局和可选特性，
同时简化了构建、安装和发行包生成流程。

第三方数据来源和版权信息见 [NOTICE](NOTICE)。

## 依赖

以下命令适用于现代 Linux（IBus 1.5+）：

- `meson >= 0.60`
- `ninja`
- `pkg-config`
- `ibus-table`，并提供 `ibus-table-createdb`
- 可选：`ibus-table-extraphrase >= 1.1.0`，用于额外词库
- 可选：`jq`，仅卸载时用于读取安装清单

> 本项目没有编译型语言代码，因此不需要 C/C++ 编译器。

## 构建与安装

```bash
# 创建构建目录；默认安装前缀为 /usr/local
meson setup build

# 生成 build/zhengma.db
meson compile -C build

# 安装到系统
sudo meson install -C build

# 重启 IBus，然后在输入法列表中添加“郑码”
ibus restart
```

默认安装内容：

| 内容 | 安装路径（相对 `$prefix`） |
| --- | --- |
| `zhengma.db` | `share/ibus-table/tables/` |
| `zhengma.svg` | `share/ibus-table/icons/` |
| `README.md`、`NOTICE`、`COPYING`、`ZiGenBiao.pdf` | `share/doc/ibus-table-zhengma/` |

## 打包安装

```bash
# 使用发行版前缀 /usr 配置构建目录
meson setup build-pkg --prefix=/usr

# 生成 zhengma.db
meson compile -C build-pkg

# 安装到临时目录，不需要 sudo
meson install -C build-pkg --destdir "$PWD/pkg"
```

## 可选：额外词库

```bash
# 新建启用额外词库的构建目录
meson setup build-extra -Dextra_phrases=true

# 编译并安装
meson compile -C build-extra
sudo meson install -C build-extra
```

已有构建目录可以直接切换选项：

```bash
# 启用额外词库并重新编译
meson configure build -Dextra_phrases=true
meson compile -C build
```

## 卸载

Meson 没有内置 `uninstall`，使用安装清单删除。下面的 `build` 要替换成实际使用的构建目录，例如 `build-extra`：

```bash
# 查看安装清单
meson introspect build --installed | jq -r 'to_entries[].value'

# 删除安装清单中的文件
meson introspect build --installed \
  | jq -r 'to_entries[].value' \
  | xargs -r sudo rm -f --

# 删除空目录；使用自定义 prefix 时请相应调整
sudo rmdir --ignore-fail-on-non-empty \
  /usr/local/share/ibus-table/tables \
  /usr/local/share/ibus-table/icons \
  /usr/local/share/doc/ibus-table-zhengma
```

> 用 `--destdir` 打包安装的文件不会进入系统，直接删除 staging 目录即可。

可选：删除用户词库和缓存：

```bash
rm -f ~/.local/share/ibus-table/tables/zhengma-user.db*
rm -f ~/.cache/ibus-table/zhengma.db
ibus restart
```

## 发行包

```bash
# 需要 git 仓库；产物位于 build/meson-dist/
meson dist -C build
```

## 目录结构

```text
tables/             # 郑码表源文件（zhengma.txt）
icons/              # 输入法图标
docs/               # 字根表 PDF
meson.build         # Meson 构建定义
meson_options.txt   # 可选构建选项
COPYING             # GPL 许可证正文
NOTICE              # 第三方数据来源说明
```

## Notes

`ibus-table-zhengma` 使用了 5 码郑码的词组编码方案：

- 2 字词的编码与以前相同；
- 3 字和 4 字的词追加最后一个字的次码；
- 5 字以上的词追加第 5 个字的首码。

这样多字词的编码进一步离散，有利于词组的高速盲打。

5 码郑码的编码方式和原先的 4 码兼容，只是添加了一个新的编码，因此使用原先的编码输入仍然可以得到一样的结果。

五码郑码的编码方案由 www.zmfans.cn/bbs 上的坛友“郑码大师”提出，在此鸣谢！

## License

The build scripts and the original table contributions are licensed under
the GNU General Public License, version 3 or (at your option) any later
version (GPL-3.0-or-later). See [COPYING](COPYING) for the license text.

Third-party data provenance is documented in [NOTICE](NOTICE). Copyright
in those portions remains with their respective holders.
