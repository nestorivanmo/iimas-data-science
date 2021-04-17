local user_id = KEYS[1]
local url_to_add = ARGV[1]
local wishlist_key = 'wishlist:'..user_id
redis.call('rpush', wishlist_key, url_to_add)
redis.call('lrange', wishlist_key, 0, -1)