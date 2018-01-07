# coding: utf-8

# Public Domain (-) 2018-present, The Elko Website Authors.
# See the Elko Website UNLICENSE file for details.

import release

from weblite import app, handle, read

INSTALL_SCRIPT = read('install.sh') % {
    'darwin': release.DARWIN,
    'linux': release.LINUX,
}

@handle('/')
def root(ctx):
    if ctx.host == 'install.elko.io':
        ctx.response_headers['Content-Type'] = 'text/plain; charset=utf-8'
        return INSTALL_SCRIPT
    return ctx.render_mako_template(
        'site', content=ctx.render_mako_template('home')
    )

@handle('install.sh')
def install_sh(ctx):
    ctx.response_headers['Content-Type'] = 'text/plain; charset=utf-8'
    return INSTALL_SCRIPT

_ = app
