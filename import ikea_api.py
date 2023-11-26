import ikea_api
import asyncio

# Constants like country, language, base url
constants = ikea_api.Constants(country="us", language="en")
# Search API
search = ikea_api.Search(constants)
# Search endpoint with prepared data
endpoint = search.search("Billy")

ikea_api.run(endpoint)


# ikea_api.run_async()
# asyncio.run(ikea_api.run_async(endpoint))

ikea_api.Auth(constants).get_guest_token()

cart = ikea_api.Cart(constants, token=...)

cart.show()