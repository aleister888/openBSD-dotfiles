#       _      _     _                          _       _
#  __ _| | ___(_)___| |_ ___ _ __    __ _ _   _| |_ ___| |__  _ __ _____      _____  ___ _ __
# / _` | |/ _ \ / __| __/ _ \ '__|  / _` | | | | __/ _ \ '_ \| '__/ _ \ \ /\ / / __|/ _ \ '__|
#| (_| | |  __/ \__ \ ||  __/ |    | (_| | |_| | ||  __/ |_) | | | (_) \ V  V /\__ \  __/ |
# \__,_|_|\___|_|___/\__\___|_|     \__, |\__,_|\__\___|_.__/|_|  \___/ \_/\_/ |___/\___|_|
#                                      |_|

import subprocess
import os
from qutebrowser.api import interceptor

# Youtube adblocking
def filter_yt(info: interceptor.Request):
    """Block the given request if necessary."""
    url = info.request_url
    if (
        url.host() == "www.youtube.com"
        and url.path() == "/get_video_info"
        and "&adformat=" in url.query()
    ):
        info.block()

interceptor.register(filter_yt)

# Adblocker
config.load_autoconfig(True)
c.content.blocking.adblock.lists = [
        "https://easylist.to/easylist/easylist.txt",
        "https://easylist.to/easylist/easyprivacy.txt",
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt",
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters-2020.txt",
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/legacy.txt",
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt",
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt",
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/resource-abuse.txt",
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/unbreak.txt",
        "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=1&mimetype=plaintext&_=223428",
        "https://raw.githubusercontent.com/brave/adblock-lists/master/brave-lists/brave-social.txt",
        "https://raw.githubusercontent.com/brave/adblock-lists/master/brave-unbreak.txt"]

# Activate pdf reader
c.content.pdfjs = True

# Search engines
c.url.searchengines = { 'yan':          'https://yandex.com/?q={}',
                        'aw':           'https://wiki.archlinux.org/?search={}',
                        'goog':         'https://www.google.com/search?q={}',
                        're':           'https://www.reddit.com/r/{}',
                        'ub':           'https://www.urbandictionary.com/define.php?term={}',
                        'wiki':         'https://en.wikipedia.org/wiki/{}',
                        'yt':           'https://yewtu.be/search?q={}',
                        'duck':         'https://duckduckgo.com/?q={}',
                        'tor':          'https://gw1.torlook.info/{}',
                        'nyaa':         'https://nyaa.si/?f=0&c=0_0&q={}',
                        'tseeker':      'https://torrentseeker.com/search.php?q={}',
                        'odysee':       'https://odysee.com/$/search?q={}',
                        'searx':        'https://searx.org/search?q={}',
                        'brave':        'https://search.brave.com/search?q={}',
                        'DEFAULT':      'https://searx.org/search?q={}',
}

c.url.start_pages = 'https://search.brave.com/'

# Various Settings
c.tabs.background = True
c.fonts.default_family = 'Ubuntu Mono'
c.content.javascript.can_access_clipboard = True

# Bindings
config.bind('M',  'yank;; spawn ~/.local/scripts/qutebrowser-yt-mpv.sh')
config.bind('tt', 'config-cycle statusbar.show always never;; config-cycle tabs.show always never')
