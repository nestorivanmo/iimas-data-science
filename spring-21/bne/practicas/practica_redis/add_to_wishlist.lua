local user_id = KEYS[1]
local url_seq_key = KEYS[2]
local rurl_seq_key = KEYS[3]
local base_client_key = KEYS[4]
local base_client = redis.call('get', base_client_key)

local url_to_add = ARGV[1]
local category = ARGV[2]
local public = ARGV[3]
local private = ARGV[4]

local wishlist_key = 'wishlist:'..user_id
local new_url_key = redis.call('incr', url_seq_key)
local rurl_new_key = redis.call('incrby', rurl_seq_key, 25)
local rurl = base_client..rurl_new_key
local key = 'url:'..new_url_key..':'..user_id

redis.call('hset', key, 'url', url_to_add, 'rurl', rurl, 'public', public, 'private', private, 'category', category, 'wishlist', '1')
redis.call('rpush', wishlist_key, new_url_key)

local categories_key = 'categories:'..user_id
redis.call('sadd', categories_key, category)

return redis.call('lrange', wishlist_key, 0, -1)
