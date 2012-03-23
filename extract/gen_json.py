# -*- coding: utf-8 -*-

import re
import psycopg2

conn = psycopg2.connect('dbname=tcnp')
cursor = conn.cursor()

nodes = []
id_map_index = {}
last_name_dict = {}
cnt = 0

def fill_last_name_dict(lname, id):
    if lname in last_name_dict:
        last_name_dict[lname].append(id)
    else:
        last_name_dict[lname] = [id]


cursor.execute("select id, name, sur_name from person")
for row in cursor.fetchall():
    nodes.append('{"id": %d, "name": "%s", "type": "%s"}' % (row[0], row[1] + ' ' + row[2], 'person'))
    id_map_index[row[0]] = cnt
    fill_last_name_dict(row[2], row[0])
    cnt = cnt + 1

cursor.execute("select id, name from groups")
for row in cursor.fetchall():
    nodes.append('{"id": %d, "name": "%s", "type": "%s"}' % (row[0], row[1], row[1]))
    id_map_index[row[0]] = cnt
    cnt = cnt + 1

links = []
cursor.execute("select person_id, group_id from person_group")
for row in cursor.fetchall():
    links.append('{"source": %d, "target": %d, "type": "belongs"}' % (id_map_index[row[0]], id_map_index[row[1]]))

for k,v in last_name_dict.iteritems():
    cnt = len(v)
    if cnt > 1:
        for i in range(cnt):
            for j in range(1, cnt):
                links.append('{"source": %d, "target": %d, "type": "relative"}' % (id_map_index[v[i]], id_map_index[v[j]]))


print '{"nodes": ['
print ','.join(nodes)
print '], "links": ['
print ','.join(links)
print "]}"