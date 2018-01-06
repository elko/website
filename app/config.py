# Public Domain (-) 2018-present, The Elko Website Authors.
# See the Elko Website UNLICENSE file for details.

ALTERNATIVE_HOSTS = frozenset(['www.elko.io'])
CANONICAL_HOST = 'elko.io'

DEBUG = False

SECURE_COOKIE_DURATION = 30 * 86400
SECURE_COOKIE_KEY = 'secret key for authenticating cookies'

STATIC_HANDLER = 'static'

TASK_AUTH = 'secret auth token'
