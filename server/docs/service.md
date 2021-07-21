##/service

    "state_code" = 200

    [
        {
            "id": 0,
            "user_name": "string",
            "email": "user@example.com",
            "phone_num": "string",
            "residence": "string"
        }
    ]

##/service/about/{user_name}
    state code = 200
    {
        "user_id": 0,
        "user_name": "string",
        "email": "user@example.com",
        "phone_num": "string",
        "residence": "string"
    }

##/service/contents/{user_id}/{category_id}
    state code = 200
    [
        {
            "post_id": 0,
            "category_id": 0,
            "category_name": "string",
            "category_color": "string",
            "post_title": "string"
        }
    ]

##service/getpost/{user_id}/{post_id}
    state code = 200
    {
        "post_title": "string",
        "post_body": "string"
    }
