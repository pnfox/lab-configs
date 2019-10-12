import hn

SITES = ['guardian.com', 'economist.com', 'cnn.com', 'reuters.com']
TAGS = []

def printNews(post):
    print('\033[95m' + post.url.split('/')[2] + "\033[0m: " + post.title)

newsPosts = hn.get_post('new_posts', 30)
for post in newsPosts:
    alreadyPrinted = False
    for site in SITES:
        if site in post.url:
            printNews(post)
            alreadyPrinted = True
            continue

    if alreadyPrinted:
        continue

    for tag in TAGS:
        if tag in post.title:
            printNews(post)
            alreadyPrinted = True
            continue
