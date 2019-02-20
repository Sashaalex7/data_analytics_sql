1. Вывести таблицу с названиями ресторанов, для которых пользователи поставили 2 балла за еду:

SELECT
Geoplaces.name,
food_rating
FROM Rating
JOIN Geoplaces on Geoplaces.placeID=Rating.placeID
WHERE Rating.food_rating=2
;

2. Вывести таблицу с названиями ресторанов, для которых пользователи поставили средний общий рейтинг 5 и более баллов:

WITH top_rated 
AS(
SELECT
placeID,
avg(food_rating) OVER (PARTITION BY placeID) + 
avg(rating) OVER (PARTITION BY placeID) +
avg(service_rating) OVER (PARTITION BY placeID) as avg_rating
FROM (SELECT distinct
placeID,
food_rating,
rating,
service_rating  
FROM Rating
) as sample
)
SELECT 
Geoplaces.name,
top_rated.avg_rating
FROM top_rated
JOIN Geoplaces on Geoplaces.placeID=top_rated.placeID
WHERE avg_rating>=5
GROUP BY Geoplaces.name, top_rated.avg_rating
ORDER BY avg_rating DESC
;

3. Вывести названия и тип кухни ресторанов с рейтингом за еду 2 (food_rating):

WITH top_rated 
AS(
SELECT
placeID,
avg(food_rating) OVER (PARTITION BY placeID) as avg_rating
FROM (SELECT distinct
placeID,
food_rating 
FROM Rating
) as sample
)
SELECT 
Geoplaces.name,
Сuisine.Сuisine,
top_rated.avg_rating
FROM top_rated
JOIN Geoplaces on Geoplaces.placeID=top_rated.placeID
JOIN Сuisine on Сuisine.placeID=Geoplaces.placeID
WHERE avg_rating=2
GROUP BY Geoplaces.name, Сuisine.Сuisine, top_rated.avg_rating
ORDER BY avg_rating DESC
;

4. Вывести рестораны с названиями, типом кухни, продажей алкоголя и низкой ценой:
SELECT 
Geoplaces.name,
Сuisine.Сuisine,
Geoplaces.alcohol,
Geoplaces.price
FROM Geoplaces
JOIN Сuisine on Сuisine.placeID=Geoplaces.placeID
WHERE alcohol !='No_Alcohol_Served' and price='low'
;

5. Посчитать мексиканские рестораны с безналичной оплатой:
WITH mexican_not_cash 
AS(
SELECT 
Сuisine.placeID,
Сuisine.Сuisine,
Payment.payment
FROM Payment
JOIN Сuisine on Сuisine.placeID=Payment.placeID
WHERE payment !='cash' and Сuisine ='Mexican')
SELECT
COUNT(DISTINCT mexican_not_cash.placeID)
FROM mexican_not_cash
;


6. Вывести общий рейтинг, который ставят непьющие посетители:
WITH top_urated 
AS(
SELECT
userID,
avg(food_rating) OVER (PARTITION BY userID) + 
avg(rating) OVER (PARTITION BY userID) +
avg(service_rating) OVER (PARTITION BY userID) as avg_rating
FROM (SELECT distinct
userID,
food_rating,
rating,
service_rating  
FROM Rating
) as sample
)
SELECT 
User_consumer.userID,
top_urated.avg_rating
FROM top_urated
JOIN User_consumer on User_consumer.userID=top_urated.userID
WHERE drink_level='abstemious'
GROUP BY User_consumer.userID, top_urated.avg_rating
ORDER BY avg_rating DESC
;

7. Вывести количество любителей каждого вида кухни:
WITH count_cuisine
AS(
SELECT 
cuisine,
count(userID) OVER (PARTITION BY cuisine) as count_users
FROM User_Сuisine)
SELECT 
count_cuisine.cuisine,
count_cuisine.count_users
FROM count_cuisine
GROUP BY count_cuisine.cuisine, count_cuisine.count_users
ORDER BY count_users DESC
;

8. Вывести id пользователей, интересы пользователей, которые ставят рейтинг за обслуживание выше среднего, и их оценки за обслуживание:
WITH avg_serv_r
AS(SELECT DISTINCT
userId,
service_rating
FROM Rating
WHERE
service_rating > (
SELECT AVG(service_rating)
FROM Rating)
GROUP BY userId,service_rating
)
SELECT
User_consumer.userID,
User_consumer.interest,
avg_serv_r.service_rating
FROM avg_serv_r
LEFT JOIN User_consumer on User_consumer.userID=avg_serv_r.userID
GROUP BY User_consumer.userID, User_consumer.interest, avg_serv_r.service_rating
;

9. Вывести названия ресторанов, их уровень цен, которые оценили посетители студенты с низким бюджетом:

WITH stud_low
AS(SELECT
userID,
activity,
budget
FROM User_consumer
WHERE activity='student' and budget='low')
SELECT
stud_low.userID,
stud_low.activity,
stud_low.budget,
Rating.placeID,
Geoplaces.name,
Geoplaces.price
FROM Rating
JOIN stud_low on stud_low.userID=Rating.userID
JOIN Geoplaces on Geoplaces.placeID=Rating.placeID
GROUP BY stud_low.userID,stud_low.activity,
stud_low.budget,Rating.placeID,Geoplaces.name,
Geoplaces.price
;

10. Вывести посетителей, которые предпочитают посещать мексиканскую кухню вместе с семьей:
SELECT
User_consumer.userID,
User_consumer.ambience,
cuisine
FROM User_Сuisine
JOIN User_consumer on User_consumer.userID=User_Сuisine.userID
WHERE cuisine='Mexican' and ambience='family'
GROUP BY User_consumer.userID,
User_consumer.ambience,
User_Сuisine.cuisine
;