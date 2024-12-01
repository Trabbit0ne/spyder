import requests
from bs4 import BeautifulSoup
import urllib.parse
import sys

def fetch_results(query, page_number=1):
    # Encode the query
    encoded_query = urllib.parse.quote_plus(query)

    # Google Search URL
    start = (page_number - 1) * 10  # Google results per page are 10
    url = f'https://www.google.com/search?q={encoded_query}&start={start}'

    # Set up headers to simulate a real browser request
    headers = {
        'User-Agent': 'Mozilla/5.0 (compatible; ScoutJet; +http://www.scoutjet.com/)'
    }

    # Send the GET request
    response = requests.get(url, headers=headers)

    # Check if the response was successful
    if response.status_code != 200:
        print("Failed to retrieve data.")
        return []

    # Parse the content with BeautifulSoup
    soup = BeautifulSoup(response.text, 'html.parser')

    # Find the relevant parts of the Google SERP (e.g., links to results)
    results = soup.find_all('a')

    # Extract and return titles and URLs
    extracted_results = []
    for result in results:
        href = result.get('href')
        if href and 'url?q=' in href:
            link = href.split('url?q=')[1].split('&sa=U')[0]
            title = result.get_text()
            extracted_results.append((title, link))

    return extracted_results

def check_twitter_profile(username):
    search_query = f"{username} site:x.com"
    print(f"Fetching results for query: {search_query} (Page 1)")
    results = fetch_results(search_query)
    for title, link in results:
        parsed_url = urllib.parse.urlparse(link)
        if parsed_url.netloc == 'x.com' and parsed_url.path and username.lower() in parsed_url.path.lower():
            print(f"Title: {title}")
            print(f"Link: {link}")
            print("True")
            return True
    print("False")
    return False

# Get the username from the command line argument
if len(sys.argv) != 2:
    print("Usage: python3 tiktokcheck.py <username>")
    sys.exit(1)

username = sys.argv[1]
check_twitter_profile(username)
