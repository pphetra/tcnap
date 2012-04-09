#!/usr/bin/env python

import web
import re
import psycopg2

urls = (
  '/', 'index',
  '/demo', 'demo',
  '/data/(.*)', 'data'
)

render = web.template.render('templates/')

class index:
    def GET(self):
        conn = psycopg2.connect('dbname=tcnap port=5432 host=localhost user=tcnap password=tcnap')
        cursor = conn.cursor()

        cursor.execute("select id,tambol,amphor,province from location")
        locs = []
        for row in cursor.fetchall():
            locs.append({
                'id': row[0],
                'name': row[1]
            })
        return render.index(locs)

class demo:
    def GET(self):
        conn = psycopg2.connect('dbname=tcnap port=5432 host=localhost user=tcnap password=tcnap')
        cursor = conn.cursor()

        cursor.execute("select id,tambol,amphor,province from location")
        locs = []
        for row in cursor.fetchall():
            locs.append({
                'id': row[0],
                'tambol': row[1],
                'amphor': row[2],
                'province': row[3]
            })
        return render.demo(locs)

class data:
    def GET(self, location_id):
        conn = psycopg2.connect('dbname=tcnap port=5432 host=localhost user=tcnap password=tcnap')
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


        cursor.execute("select id, name, sur_name, description from person where location_id = %s", location_id)
        for row in cursor.fetchall():
            nodes.append('{"id": %d, "name": "%s", "type": "%s"}' % (row[0], row[1] + ' ' + row[2] + '[' + row[3] + ']', 'person'))
            id_map_index[row[0]] = cnt
            fill_last_name_dict(row[2], row[0])
            cnt = cnt + 1

        cursor.execute("select id, name from groups")
        for row in cursor.fetchall():
            nodes.append('{"id": %d, "name": "%s", "type": "%s"}' % (row[0], row[1], row[1]))
            id_map_index[row[0]] = cnt
            cnt = cnt + 1

        links = []
        cursor.execute("select person_id, group_id from person_group where person_id in (select id from person where location_id = %s)", location_id)
        for row in cursor.fetchall():
            links.append('{"source": %d, "target": %d, "type": "belongs"}' % (id_map_index[row[0]], id_map_index[row[1]]))

        for k,v in last_name_dict.iteritems():
            cnt = len(v)
            if cnt > 1:
                for i in range(cnt):
                    for j in range(1, cnt):
                        links.append('{"source": %d, "target": %d, "type": "relative"}' % (id_map_index[v[i]], id_map_index[v[j]]))

        sumPerson = 0
        cursor.execute("SELECT COUNT(id) FROM person WHERE location_id = %s", location_id)
        for row in cursor.fetchall():
            sumPerson = row[0]

        person = []
        cursor.execute("SELECT id, name, sur_name, description FROM person WHERE location_id = %s", location_id)
        for row in cursor.fetchall():
            person.append('{"id": %d, "name": "%s", "description": "%s"}' % (row[0], row[1] + ' ' + row[2], row[3]))

        cursor.close()
        conn.close()

        buff = '{"nodes": ['
        buff += ','.join(nodes)
        buff += '], "links": ['
        buff += ','.join(links)
        buff += '], "person": ['
        buff += ','.join(person)
        buff += '], "sum": ' + str(sumPerson) + "}"
        return buff



app = web.application(urls, globals())

if __name__ == "__main__": app.run()
