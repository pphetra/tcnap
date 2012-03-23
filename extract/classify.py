# -*- coding: utf-8 -*-

import re
import psycopg2

conn = psycopg2.connect('dbname=tcnp')
cursor = conn.cursor()

def create_relation(person_id, group_id):
    cursor.execute("select person_id from person_group where person_id = %d and group_id = %d" % (person_id, group_id))
    if not cursor.fetchone():
        cursor.execute("insert into person_group (person_id, group_id) values (%d, %d)" % (person_id, group_id))
        conn.commit()


matchs = []
cursor.execute("select id, pattern from \"groups\"")
for row in cursor.fetchall():
    patterns = eval(row[1])
    for p in patterns:
        matchs.append((p, row[0]))

cursor.execute("delete from person_group")
conn.commit()

cursor.execute("select id, description from person")
for row in cursor.fetchall():
    person_id = row[0]
    description = row[1]
    for m in matchs:
        if m[0] in description:
            create_relation(person_id, m[1])