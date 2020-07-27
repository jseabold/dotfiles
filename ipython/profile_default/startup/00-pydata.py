import numpy as np
import pandas as pd
from scipy import constants, stats  # noqa

np.set_printoptions(suppress=True, precision=4)

pd.options.display.float_format = lambda x: f'{x:.4f}'
pd.options.display.precision = 4
pd.options.display.max_rows = 75
pd.options.display.show_dimensions = False
pd.options.mode.chained_assignment = None
