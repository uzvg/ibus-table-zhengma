project('ibus-table-zhengma',
  version: '1.1.0.20261020',
  license: 'GPL-3.0-or-later',
  meson_version: '>=0.60.0')

datadir = get_option('datadir')
tablesdir = datadir / 'ibus-table' / 'tables'
iconsdir = datadir / 'ibus-table' / 'icons'
docdir = datadir / 'doc' / meson.project_name()

createdb = find_program('ibus-table-createdb', required: true)
dependency('ibus-table', version: '>=1.1.0')

createdb_args = [createdb, '-n', '@OUTPUT@', '-s', '@INPUT@']

if get_option('extra_phrases')
  extra = dependency('ibus-table-extraphrase', version: '>=1.1.0')
  extra_path = extra.get_variable(pkgconfig: 'extraphrasepath')
  createdb_args += ['-e', extra_path]
endif

custom_target('zhengma.db',
  input: 'tables/zhengma.txt',
  output: 'zhengma.db',
  command: createdb_args,
  install: true,
  install_dir: tablesdir,
  build_by_default: true)

install_data('icons/zhengma.svg', install_dir: iconsdir)
install_data('COPYING', 'README.md', 'NOTICE', install_dir: docdir)
install_data('docs/ZiGenBiao.pdf', install_dir: docdir)
