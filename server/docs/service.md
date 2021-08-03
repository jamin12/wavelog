## get /blog/service

    "state_code" = 200
    [
        {
            "id": int,
            "user_name": "string",
            "email": "user@example.com",
            "phone_num": "string",
            "residence": "string"
        }
    ]

## get /blog/service/about/{user_name}

>   ## input
    user_name: "string"
>   ## ouput
    state code = 200
    {
        "user_id": int,
        "user_name": "string",
        "email": "user@example.com",
        "phone_num": "string",
        "residence": "string"
    }

## get /blog/service/contents/{user_id}/{category_id}

>   ## input
    user_id: int
    category_id: int
>   ## ouput
    state code = 200
    [
        {
            "post_id": int,
            "category_id": int,
            "category_name": "string",
            "category_color": "string",
            "post_title": "string"
        }
    ]

## get /blog/service/getpost/{user_id}/{post_id}

>   ## input
    user_id: int
    post_id: int
>   ## ouput
    state code = 200
    {
        "post_title": "string",
        "post_body": "string"
        "comment": [
            "string"
        ]
    }

## post /blog/service/commnet

>   ## input
    {
        "post_id": int,
        "nick_name": "string",
        "password": "string",
        "comment_body": "string"
    }

>   ## output
    state code = 201
    "string"

## patch /blog/service/comment/{comment_id}/{password}/{change_comment}

>   ## input
    comment_id: int,
    password: "string"
    change_comment: "string"
    
>   ## output
    state code 200
        "string"

## delete /blog/service/comment/{comment_id}/{password}

>   ## input
    comment_id: int,
    password: "string"

>   ## output
    state code 200
        "string"