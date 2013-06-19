# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Rick
rick = Staff.new(email: "rick@gtccf.org")
rick.name = "Rick Harper"
rick.email = "rick@gtccf.org"
rick.about = "Rick and Beth Harper started GTCCF in May 1987. Rick received a degree in Business from the University of Georgia in 1983 and was also involved at the Christian Campus Fellowship at UGA. After graduating, Rick spent a year as an intern at CCF at Florida State. There he met Beth, who holds a degree in Nursing from FSU. Rick completed his Master’s degree at Emmanuel School of Religion in 1987 and they moved to Atlanta to begin CCF as well as their family.
             Beth works at home as a full-time mother to their three boys, Garrett, Donovan, and Grayson. They are all active members of Southwest Christian Church in East Point, GA, where Rick and Beth teach a Sunday School class for young married couples.
             Rick’s job as Campus Minister includes teaching at Bible Study on Thursday nights, leading the Big Sap Leadership group, and meeting with and counseling students. As Campus Minister, he reports to the GTCCF Board of Directors."
rick.save

# Neal
neal = Staff.new(email: "neal@gtccf.org")
neal.name = "Neal Baker"
neal.title = "Senior Associate Minister"
neal.about = "Neal Baker graduated from Georgia Tech with a Materials Engineering degree in 1996. He was an intern at GTCCF from 1996-97, after which he took the position of Senior Associate Minister.
Simply put, Neal does all the stuff nobody else wants to do. He keeps CCF’s finances in order, manages the house, works with the sophomore leadership group, and occasionally fills in for Rick at Bible Study."
neal.save

# Heather
heather = Staff.new(email: "heather@gtccf.org")
heather.name = "Heather Quiggle"
heather.title = "Associate Minister"
heather.about = "Heather Quiggle graduated from Georgia Tech in 2001 with a degree in Mechanical Engineering. The following year, she interned at GTCCF. She then spent 5 years working in Chile for a Globalscope ministry.
Heather is working with the freshmen interns and women’s ministry at GTCCF."
heather.save
