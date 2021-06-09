import dracula.draw

# Load existing settings made via :set
config.load_autoconfig()

dracula.draw.blood(c, {
    'spacing': {
        'vertical': 0,
        'horizontal': 0
    }
})

c.auto_save.interval = 15000
c.auto_save.session = True

c.bindings.key_mappings["<Meta-N>"] = "<Ctrl-N>"

config.bind("<Ctrl-E>", "scroll down")
config.bind("<Ctrl-Y>", "scroll up")
config.bind("<Shift-Q>", "tab-close")
config.bind("<Meta-W>", "tab-close")
config.bind("<Meta-1>", "tab-focus 1")
config.bind("<Meta-2>", "tab-focus 2")
config.bind("<Meta-3>", "tab-focus 3")
config.bind("<Meta-4>", "tab-focus 4")
config.bind("<Meta-5>", "tab-focus 5")
config.bind("<Meta-6>", "tab-focus 6")
config.bind("<Meta-7>", "tab-focus 7")
config.bind("<Meta-8>", "tab-focus 8")
config.bind("<Meta-9>", "tab-focus -1")
config.bind("<Meta-p>", "print")
config.bind("<Meta-u>", "view-source")
config.bind("<Meta-Alt-i>", "inspector")
config.bind("<Shift-K>", "tab-next")
config.bind("<Shift-J>", "tab-prev")
config.bind("gb", "tab-next")
config.bind("gB", "tab-prev")
config.bind("yu", "hint links yank")
# config.bind("xs", "config-cycle statusbar.hide")
config.bind("xs", "config-cycle statusbar.show always switching")
config.bind("xt", "config-cycle tabs.show always switching")
config.bind("xx", "config-cycle statusbar.show always switching ;; config-cycle tabs.show always switching")

config.bind("ym", "yank inline '[{title}] - {url:pretty}'")

config.confirm_quit = "multiple-tabs"

c.completion.cmd_history_max_items = 1024

c.url.start_pages = ["about:blank"]
c.url.default_page = "about:blank"

c.content.autoplay = False
c.content.cookies.accept = "no-unknown-3rdparty"

c.scrolling.bar = "always" # "when-searching"

c.session.lazy_restore = True

c.tabs.background = True
c.tabs.indicator.width = 10
c.tabs.last_close = "close"
c.tabs.title.format = "{perc}{audio}{index}: {current_title}"
c.tabs.title.format_pinned = "{index}: {host}"

c.colors.tabs.selected.even.bg = "#ff5555"
c.colors.tabs.selected.odd.bg = "#ff5555"
c.colors.tabs.pinned.selected.even.bg = "#ff5555"
c.colors.tabs.pinned.selected.odd.bg = "#ff5555"

c.url.searchengines["g"] = "https://google.com/search?hl=en&q={}"
c.url.searchengines["yt"] = "https://youtube.com/results?search_query={}"
c.url.searchengines["re"] = "https://reddit.com/r/{}"
c.url.searchengines["tr"] = "https://translate.google.com/?sl=es&tl=en&text={}&op=translate"

# c.window.hide_decoration = True
