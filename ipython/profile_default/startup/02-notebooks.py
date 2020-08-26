import pandas as pd

c = get_ipython()  # noqa

# this is probably fragile but currently indicates in most cases
# that you're in jupyterlab or a notebook
if 'IPKernelApp' in c.config:  # noqa
    try:
        import qgrid
        qgrid.enable()
        qgrid.set_grid_option('forceFitColumns', False)
        qgrid.grid.defaults._precision = 4
    except ImportError:
        pass

    # make notebooks take up most of the screen width
    c.run_cell(
        "from IPython.core.display import display, HTML\n"
        "display(HTML('<style>.container { width: 98% !important; }</style>'))"
    )

    # this startup file needs to run before any other plotting configuration
    # or it can overwrite those settings
    c.run_line_magic('matplotlib', 'inline')

    pd.options.display.float_format = lambda x: f"{x:.1f}"
    pd.options.display.max_rows = 100
    del c
