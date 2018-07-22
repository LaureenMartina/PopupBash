import random
import requests

if __name__ == '__main__':

    key = "8df18dcd35f649e3843d25920cdab720"
    sources = ["le-monde", "google-news-fr", "hacker-news", "liberation", "metro", "lequipe", "les-echos"]
    mode = ["top-headlines", "everything"]
    choice_scr = 0
    choice_mode = 0
    articles = []

    choice_scr = random.randint(0, 6)
    choice_mode = random.randint(0, 1)

    url = ('https://newsapi.org/v2/{}?'
           'sources={}&'
           'apiKey={}').format(mode[choice_mode], sources[choice_scr], key)

    response = requests.get(url)
    data = response.json()

    print(data)

    fileNews = open("article.txt", "w")
    fileNews.write(data)
    fileNews.close()
