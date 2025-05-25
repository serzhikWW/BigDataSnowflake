import pandas as pd
from sqlalchemy import create_engine

all_data = pd.concat([pd.read_csv(f'MOCK_DATA ({i}).csv') for i in range(1, 11)])

engine = create_engine('postgresql://postgres:postgres@localhost:5432/postgres')

all_data.to_sql('mock_data', engine, if_exists='replace', index=False)