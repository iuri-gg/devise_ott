User.create(email:'test1@example.com')
User.create(email:'test2@example.com')

DeviseOtt::Tokens.instance.register('random_token', 'test1@example.com', 'requester@example.com', 1040, 100100)