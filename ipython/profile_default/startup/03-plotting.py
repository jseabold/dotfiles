import matplotlib.pyplot as plt
import seaborn as sns  # noqa

# the below could be configured in your matplotlibrc

plt.ion()

# alternatively, have a work-specific or presentation stylesheet loaded
# later with plt.style.use('style_name')
# e.g., https://github.com/civisanalytics/civis-mpl-style
# this is for quick and easy defaults

plt.style.use('seaborn-talk')
for key, value in {
        'xtick.bottom': False,
        'xtick.top': False,
        'ytick.left': False,
        'ytick.right': False,
}.items():
    plt.rcParams[key] = value
