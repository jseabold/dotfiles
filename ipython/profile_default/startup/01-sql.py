# NOTE: if you're using teradatasql, this needs to be loaded before
# any threads are spawned (which happens when you import matplotlib.pyplot)
import os

from IPython.core.magic import register_line_magic, register_line_cell_magic

try:
    import pandas as pd
    import sql  # requires ipython-sql
    import sqlalchemy as sa

    DATABASE_URL = os.environ.get('DATABASE_URL', None)

    if DATABASE_URL:
        # sets up the %sql and %%sql magic with the default connection
        # provided by DATABASE_URL
        c = get_ipython()  # noqa
        c.run_line_magic('load_ext', 'sql')
        c.run_line_magic('config', 'SqlMagic.autopandas = True')
        c.run_line_magic('sql', '')
        engine = sa.create_engine(DATABASE_URL)

    @register_line_magic
    def preview(line):
        c = get_ipython()  # noqa
        statement = (sa
                     .select('*')
                     .select_from(sa.text(line))
                     .limit(5)
                     .compile(bind=engine))
        return c.run_line_magic('sql', statement)

    @register_line_cell_magic
    def SELECT(line, cell=None):
        c = get_ipython()  # noqa
        if cell is None:
            return c.run_line_magic('sql', f'SELECT {line}')
        else:
            return c.run_cell_magic('sql', '', f'SELECT {line}\n{cell}')

    @register_line_magic
    def columns(line):
        try:
            schema, table = line.split('.')
        except ValueError:
            table = line
            schema = None
        columns = pd.DataFrame(
            engine.dialect.get_columns(engine.connect(), table, schema))
        return (columns
                .assign(**(columns
                           .select_dtypes('object')
                           .apply(lambda col: col.str.strip()))))

    @register_line_magic
    def tables(line):
        if line:
            schema = line.strip()
        else:
            schema = None

        tables = pd.DataFrame(engine.dialect.get_table_names(engine.connect(),
                                                             schema=schema),
                              columns=['tables'])
        return tables

    @register_line_magic
    def views(line):
        if line:
            schema = line.strip()
        else:
            schema = None

        views = pd.DataFrame(engine.dialect.get_view_names(engine.connect(),
                                                           schema=schema),
                             columns=['views'])
        return views.sort_values('views')

    @register_line_magic
    def explain(line):
        with open(line.strip()) as sql_file:
            sql_in = sql_file.read().strip()
            # this may not work outside of teradata, depends on returned
            # format
            explained = c.run_cell_magic('sql', '', f'EXPLAIN {sql_in}')
            print('\n'.join(explained['Explanation']))

    del sql, SELECT, preview, columns, tables, views, explain

except ImportError:
    pass
