## Botify Test

### Installation:

### Using Docker: 


`$ docker-compose build`

`$ docker-compose run`

`$ docker-compose run web rake db:create`

`$ docker-compose run web rake db:migrate`

Import files from the file to database(It may take sometime to save 35910 lines):

`$ docker-compose run web rake import_towns_from_file:import`

If everything is good. you can use the following URL: http://localhost:8000
### Without Docker:

After installing rails and cloning the project you can execute these commands:

`$ rails db:create`

`$ rails db:migrate`

Import files from the file to database(It may take some time to save 35910 lines):

`$ rake import_towns_from_file:import`

Launch rails server:

`$ rails s`

If everything is good. you can use the following URL: http://localhost:3000

#### 


# Step 1: /towns

List of params:

* page_size: ***integer*** : number of objects per page
* page_number: ***integer*** : page number
* filter: ***string*** : SQL filters (Without **WHERE** and without quotes or double quotes for postman)
* order_by: ***string*** : order by attribute (without quotes or double quotes for postman)
	- you can choose **asc** for ascendant order or **desc** for descendant order

**Exemple:**

![](https://scontent-cdt1-1.xx.fbcdn.net/v/t1.15752-9/70426956_1377217675774471_7345233639187152896_n.png?_nc_cat=106&_nc_oc=AQlALo_FSlJx2sGH_URsQDgHly2wcl9QKLkQkztmyAEGDo_xY3mDZOYQBNKU44HtphM&_nc_ht=scontent-cdt1-1.xx&oh=7e82e1a47b7eb82735dfd370b617be2d&oe=5E06EB67)

# Step 2: /aggs

List of params:

* region_code: ***integer*** : region code
* dept_code: ***integer*** : departement number

**Exemple:**

![](https://scontent-cdt1-1.xx.fbcdn.net/v/t1.15752-9/69996200_508844666576149_59778604661211136_n.png?_nc_cat=106&_nc_oc=AQlYl0nayTBNZbrP2uo94sGoiF-mY2ovAQNr1cV3BhjCA1VXcCjfFPvEnjvunnCi4Xk&_nc_ht=scontent-cdt1-1.xx&oh=ce6b9636cc98e4d54ed714fb71f62758&oe=5DFADEE8)


# Step 3: /query

Errors are thrown when: 

* There are no fields.
* Some attributes are unavailable.
* Types are not compatible.

**Exemple:**

```json
{
    "fields": ["name", "population"],
    "filters": {
        "field": "average_age",
        "value": 15,
        "predicate": "gt"
    }
}
```

![](https://scontent-cdt1-1.xx.fbcdn.net/v/t1.15752-9/70373790_421162215201341_3857828015694151680_n.png?_nc_cat=101&_nc_oc=AQn5Nb7PDTAoWyKGIYfRS2pdn_6xug0DC5yYS0TAZC_6K771IFkBqYkS2UGppqGCAro&_nc_ht=scontent-cdt1-1.xx&oh=83b74924fafeaad8f5babd31d58fe956&oe=5E00526E)


# Step 4: /query

Errors are thrown when: 

* There are no fields.
* Some attributes are unavailable.
* Types are not compatible.

In this section we can have multiple and recursive filters. 

**Exemple:**

```json
{
    "fields": ["name", "population"],
    "filters": {
        "and": [{
                "or": [{
                        "field": "average_age",
                        "value": 15,
                        "predicate": "gt"
                    },
                    {
                        "field": "region_name",
                        "value": "France",
                        "predicate": "contains"
                    }
                ]
            },
            {
                "or": [{
                        "or": [{
                                "field": "average_age",
                                "value": 15,
                                "predicate": "gt"
                            },
                            {
                                "field": "region_name",
                                "value": "France",
                                "predicate": "contains"
                            }
                        ]
                    },
                    {
                        "or": [{
                                "field": "population",
                                "value": 10000
                            },
                            {
                                "field": "region_name",
                                "value": "Hauts-de",
                                "predicate": "contains"
                            }
                        ]
                    }
                ]
            }
        ]
    }
}
```

![](https://scontent-cdt1-1.xx.fbcdn.net/v/t1.15752-9/71152299_641390926370009_2138826707623215104_n.png?_nc_cat=104&_nc_oc=AQkue_kJ5rwebm-0jLzzyzf8jjyqOdDr1s0DEGv_Y9JwZDtJg3RSOl04RdjVhZ8tMbA&_nc_ht=scontent-cdt1-1.xx&oh=7ee10b030345c4738e7baab3b722d6c0&oe=5E0C6A66)


# Step 5: Dockerfile

In this sections I added 3 files:

* Dockerfile 
* docker-compose.yml
* entrypoint.sh 
