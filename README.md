# Module8 ETL Crowdfunding

## Purpose
Independent Funding has received a new dataset that contains information on the backers who have pledged money to the live projects. Utilizing Python, Pandas, and Jupyter notebooks we need to extract and transform the new data into a CSV file to be uploaded into a new table in our crowdfunding database in SQL. 

## Deliverable 1: Extract Data

<img width="599" alt="Screenshot 2023-05-22 at 8 43 51 PM" src="https://github.com/Jall3n/Module8_ETL-Crowdfunding/assets/119149740/953704ff-fdc4-439c-8ea7-1934baa04e35">

<img width="404" alt="Screenshot 2023-05-22 at 8 44 01 PM" src="https://github.com/Jall3n/Module8_ETL-Crowdfunding/assets/119149740/0e9afa76-75aa-457a-a51a-b7f09e17f38c">


## Deliverable 2: Transform and Clean Data

<img width="457" alt="Screenshot 2023-05-22 at 8 44 11 PM" src="https://github.com/Jall3n/Module8_ETL-Crowdfunding/assets/119149740/2929c642-8e16-4a68-93f5-fa3ff4bdcfba">

    # Split the "name" column into "first_name" and "last_name" columns.
    backers_df[['first_name', 'last_name']] = backers_df['name'].str.split(' ', n=1, expand=True)
    #  Drop the name column
    backers_clean_df = backers_df.drop(['name'], axis = 1)
    # Reorder the columns
    backers_clean_df = backers_clean_df[['backer_id','cf_id', 'first_name', 'last_name', 'email']]
    backers_clean_df.head(10)
    
## Deliverable 3: Create an ERD and Table Schema
### ERD
Added in the backers info onto our original crowdfunding ERD
![crowdfunding_db_relationships](https://github.com/Jall3n/Module8_ETL-Crowdfunding/assets/119149740/d9ffff34-848c-4826-ab66-0d32cd3f23d8)

    CREATE TABLE "backers" (
        "backer_id" varchar(10)   NOT NULL,
        "cf_id" int   NOT NULL,
        "first_name" varchar(50)   NOT NULL,
        "last_name" varchar(50)   NOT NULL,
        "email" varchar(100)   NOT NULL,
        CONSTRAINT "pk_backers" PRIMARY KEY (
            "backer_id"
         )
    );
    ALTER TABLE "backers" ADD CONSTRAINT "fk_backers_cf_id" FOREIGN KEY("cf_id")
    REFERENCES "campaign" ("cf_id");

## Deliverable 4: SQL Analysis

Create a table that has the first and last name, and email address of each contact and the amount left to reach the goal for all "live" projects in descending order. 
    
    SELECT co.first_name,
        co.last_name,
        co.email,
        (ca.goal - ca.pledged) as "Goal Amount Remaining"
    INTO email_goal_amount
    FROM campaign as cam
    LEFT JOIN contacts as co
        ON (co.contact_id = ca.contact_id)
        WHERE (ca.outcome = 'live')
    ORDER BY "Goal Amount Remaining" DESC;
    
    
Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, and has the first and last name of each backer, the cf_id, company name, description, end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal".

    SELECT b.email, b.first_name, b.last_name,
        ca.cf_id, ca.company_name, ca.description, ca.end_date,
        (ca.goal - ca.pledged) as "Left of Goal"
    INTO email_backers_remaining_goal_amount
    FROM backers as b
    LEFT JOIN campaign as ca
        ON (ca.cf_id = b.cf_id)
        WHERE (ca.outcome = 'live')
    ORDER BY b.last_name, b.email ASC;
    

## Resources
https://www.geeksforgeeks.org/split-a-text-column-into-two-columns-in-pandas-dataframe/
https://courses.bootcampspot.com/courses/2957/pages/8-dot-4-1-introduction-to-regular-expressions?module_item_id=870124
https://courses.bootcampspot.com/courses/2957/pages/8-dot-5-2-create-an-entity-relationship-diagram?module_item_id=870132
https://learnsql.com/blog/difference-between-two-rows-in-sql/


