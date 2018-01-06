# coding: utf-8

# Public Domain (-) 2018-present, The Elko Website Authors.
# See the Elko Website UNLICENSE file for details.

from release import DATE as RELEASE_DATE, HASH as RELEASE_HASH
from weblite import Redirect, app, handle, read

INSTALL_SCRIPT = read('install.sh') % {
    'date': RELEASE_DATE, 'hash': RELEASE_HASH
}

@handle('/')
def root(ctx):
    if ctx.host == 'install.elko.io':
        ctx.response_headers['Content-Type'] = 'text/plain'
        return INSTALL_SCRIPT
    return ctx.render_mako_template(
        'site', content=ctx.render_mako_template('home')
    )

@handle('install.sh')
def install_sh(ctx):
    ctx.response_headers['Content-Type'] = 'text/plain'
    return INSTALL_SCRIPT

_ = app
