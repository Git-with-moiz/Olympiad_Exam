select * from correct_answer;
select * from question_paper_code;
select * from student_list;
select * from student_response;


with cte1 as 
(select sl.roll_number,sl.student_name,sl.class,sl.section,sl.school_name
,sum(case when pc.subject = 'Math' and sr.option_marked=ca.correct_option and sr.option_marked <> 'e'
   then 1 else 0 end) as math_correct
,sum(case when pc.subject = 'Math' and sr.option_marked<>ca.correct_option and sr.option_marked <> 'e'
   then 1 else 0 end) as math_wrong
,sum(case when pc.subject = 'Math' and sr.option_marked = 'e'
   then 1 else 0 end) as math_yet_to_learn
,sum(case when pc.subject = 'Math'
   then 1 else 0 end) as math_total
   
,sum(case when pc.subject = 'science' and sr.option_marked=ca.correct_option and sr.option_marked <> 'e'
   then 1 else 0 end) as science_correct
,sum(case when pc.subject = 'science' and sr.option_marked<>ca.correct_option and sr.option_marked <> 'e'
   then 1 else 0 end) as science_wrong
,sum(case when pc.subject = 'science' and sr.option_marked = 'e'
   then 1 else 0 end) as science_yet_to_learn
,sum(case when pc.subject = 'science'
   then 1 else 0 end) as science_total
from student_list sl
join student_response sr on sl.roll_number=sr.roll_number
join correct_answer ca 
   on ca.question_paper_code=sr.question_paper_code and ca.question_number=sr.question_number
join question_paper_code pc on pc.paper_code=ca.question_paper_code
group by sl.roll_number,sl.student_name,sl.class,sl.section,sl.school_name)
select roll_number, student_name, class,section, school_name, math_correct, math_wrong, math_yet_to_learn, math_correct as math_score
,round((math_correct/math_total)*100,2) as math_percentage
,science_correct, science_wrong, science_yet_to_learn, science_correct as science_score
,round((science_correct/science_total)*100,2) as science_percentage
from cte1;

