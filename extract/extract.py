# -*- coding: utf-8 -*-

from xlrd import open_workbook,empty_cell
import re
import psycopg2
import sys

if (len(sys.argv) > 1):
    file_name = sys.argv[1]
else:
    print "กรุณาระบุ file ที่ต้องการ extract ข้อมูล"
    exit()

conn = psycopg2.connect('dbname=tcnp')
cursor = conn.cursor()

name_match = re.compile(u'ชื่อ')
prefix_match = re.compile(u'(นาย|นางสาว|นาง)(.+)')
location_match = re.compile(u'ตำบล\s(\W+)\sอำเภอ\s(\W+)\sจังหวัด(\W+)')

def extract_location(s):
    m = location_match.match(s)
    return (m.group(1).strip(), m.group(2).strip(), m.group(3).strip())

def extract_name(s):
        m = prefix_match.match(s)
        if m:
            return m.group(2)
        return s

def create_location(info):
    cursor.execute("select id from location where tambol = '%s' and amphor = '%s' and province = '%s'" % info)
    row = cursor.fetchone()
    if row:
        return row[0]
    else:
        cursor.execute("insert into location (id, tambol, amphor, province) values (nextval('ids'), '%s', '%s', '%s')" % info)
        conn.commit()
        cursor.execute("select id from location where tambol = '%s' and amphor = '%s' and province = '%s'" % info)
        row = cursor.fetchone()
        return row[0]

def create_person(name, sur_name, description, tambol, location_id):
    cursor.execute("select id from person where name = '%s' and sur_name = '%s' and tambol = '%s'" % (name, sur_name, tambol))
    row = cursor.fetchone()
    if row:
        return row[0]    
    else:
        cursor.execute("insert into person (name, sur_name, description, tambol, location_id) values ('%s', '%s', '%s', '%s', %s)" % (name, sur_name, description, tambol, location_id))
        conn.commit()
        cursor.execute("select id from person where name = '%s' and sur_name = '%s' and tambol = '%s'" % (name, sur_name, tambol))
        row = cursor.fetchone()
        return row[0]


book = open_workbook(file_name, encoding_override="tis-620")
for s in book.sheets():
    num_rows = s.nrows
    num_cols = s.ncols
    if num_rows > 1:
        info = extract_location(s.cell(1, 1).value)
        info_id = create_location(info)
        for row in range(1, s.nrows):
            if s.cell(row, 3).value != '' and not name_match.search(s.cell(row, 1).value):
                if s.cell(row, 2).value == '':
                    name = s.cell(row, 4).value
                    if not re.search(u'อาจารย์/นักเรียนในโรงเรียน', name):
                        nms = extract_name(name).split(' ')
                        description = s.cell(row, 1).value + ' ' + s.cell(row, 7).value
                        person_id = create_person(nms[0], nms[1], description, info[0], info_id)
                else:
                    person_id = create_person(s.cell(row, 1).value,
                        s.cell(row, 2).value,
                        s.cell(row, 6).value,
                        info[0],
                        info_id)

    
      