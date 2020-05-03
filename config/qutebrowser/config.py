c.auto_save.interval = 15000
c.auto_save.session = True

c.bindings.key_mappings['<Meta-N>'] = '<Ctrl-N>'

config.bind('<Shift-Q>', ':tab-close')
config.bind('<Meta-W>', ':tab-close')
config.bind('<Meta-1>', ':tab-focus 1')
config.bind('<Meta-2>', ':tab-focus 2')
config.bind('<Meta-3>', ':tab-focus 3')
config.bind('<Meta-4>', ':tab-focus 4')
config.bind('<Meta-5>', ':tab-focus 5')
config.bind('<Meta-6>', ':tab-focus 6')
config.bind('<Meta-7>', ':tab-focus 7')
config.bind('<Meta-8>', ':tab-focus 8')
config.bind('<Meta-9>', ':tab-focus -1')
config.bind('<Meta-p>', ':print')
config.bind('<Meta-u>', ':view-source')
config.bind('<Meta-Alt-i>', ':inspector')
config.bind('gb', ':tab-next')
config.bind('gB', ':tab-prev')

config.confirm_quit = 'multiple-tabs'

c.completion.cmd_history_max_items = 1024

c.content.autoplay = False
c.content.cookies.accept = 'no-unknown-3rdparty'

c.hints.find_implementation = 'javascript'

c.scrolling.bar = 'when-searching' # always

c.session.lazy_restore = True

# c.spellcheck.languages = ['ca-ES', 'es-ES', 'en-US']

c.tabs.background = True
c.tabs.indicator.width = 10
c.tabs.last_close = 'close'
c.tabs.title.format = '{perc}{audio}{index}: [{protocol}] {current_title}'
c.tabs.title.format_pinned = '{index}: {host}'
