import pandas as pd
from maximin import Maximin

class Main:
    def __init__(self, original_data=None, algorithm_data=None):
        self.od = original_data
        self.ad = algorithm_data

    def encode_species(self, df):
        class_ = []
        for idx, row in df.iterrows():
            species = row['species']
            if species == 'Iris-setosa':
                class_.append(1)
            elif species == 'Iris-versicolor':
                class_.append(2)
            else:
                class_.append(3)
        df['class'] = class_
        return df.iloc[:, [0,1,3]]

    def build_df_from_maximin(self, data):
        df = pd.DataFrame()
        a = []
        b = []
        c = []
        for p in data:
            a.append(p.x)
            b.append(p.y)
            c.append(p.class_idx)
        df['x_name'] = a
        df['y_name'] = b
        df['class'] = c
        return df
    

if __name__ == '__main__':
    path = 'iris.csv'
    x_name = 'sepal_length'
    y_name = 'petal_width'

    original_df = pd.read_csv(path)[[x_name, y_name, 'species']]
    original_df = Main().encode_species(original_df)
    maximin_data = Maximin('iris.csv', x_name, y_name).run_(verbose=False)
    maximin_df = Main().build_df_from_maximin(maximin_data)

    print(original_df)
    print(maximin_df)