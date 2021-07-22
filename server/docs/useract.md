## post /blog/useract/category

>   ## input
    {
        "category_name": "string",
        "category_color": "string"
    }

>   ## ouput
    state code 201
        "string"

## put /blog/useract/category/{categoty_id}/{category_rename}

>   ## input
    category_id : int
    category_rename : str

>   ## output 
    state code 200
        "string"

## delete /blog/useract/category/{category_id}

>   ## input
    category_id : int

>   ## output
    state code 200
        "string"

## post /blog/useract/post

>   ## input
    {
        "post_title": "string",
        "post_body": "string",
        "category_id": 0
    }

>   ## output
    state code 200
        "string"

## patch /blog/useract/post

>   ## input
    {
        "post_id": 0,
        "post_title": "string",
        "post_body": "string",
        "category_id": 0
    }

>   ## output
    state code 200
        "string"

## delete /blog/useract/post/post_id

>   ## input
    post_id : int

>   ## output
    state code 200
        "string"