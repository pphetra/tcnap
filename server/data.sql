--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: tcnap
--

CREATE OR REPLACE PROCEDURAL LANGUAGE plpgsql;


ALTER PROCEDURAL LANGUAGE plpgsql OWNER TO tcnap;

SET search_path = public, pg_catalog;

--
-- Name: ids; Type: SEQUENCE; Schema: public; Owner: tcnap
--

CREATE SEQUENCE ids
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ids OWNER TO tcnap;

--
-- Name: ids; Type: SEQUENCE SET; Schema: public; Owner: tcnap
--

SELECT pg_catalog.setval('ids', 156, true);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: groups; Type: TABLE; Schema: public; Owner: tcnap; Tablespace: 
--

CREATE TABLE groups (
    name character varying(100),
    pattern text,
    id integer DEFAULT nextval('ids'::regclass) NOT NULL
);


ALTER TABLE public.groups OWNER TO tcnap;

--
-- Name: location; Type: TABLE; Schema: public; Owner: tcnap; Tablespace: 
--

CREATE TABLE location (
    id integer NOT NULL,
    tambol character varying(50),
    amphor character varying(50),
    province character varying(50)
);


ALTER TABLE public.location OWNER TO tcnap;

--
-- Name: person; Type: TABLE; Schema: public; Owner: tcnap; Tablespace: 
--

CREATE TABLE person (
    id integer DEFAULT nextval('ids'::regclass) NOT NULL,
    name character varying(100),
    sur_name character varying(100),
    description text,
    tambol character varying(50),
    location_id integer
);


ALTER TABLE public.person OWNER TO tcnap;

--
-- Name: person_group; Type: TABLE; Schema: public; Owner: tcnap; Tablespace: 
--

CREATE TABLE person_group (
    person_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.person_group OWNER TO tcnap;

--
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: tcnap
--

INSERT INTO groups VALUES ('ผู้นำ', '[''ประธาน'', ''ผู้นำ'']', 149);
INSERT INTO groups VALUES ('ปกครอง', '[''อบต.'', ''ผู้ใหญ่บ้าน'', ''องค์การบริหาร'', ''อสม.'', ''ผู้ช่วยผู้ใหญ่'']', 153);
INSERT INTO groups VALUES ('เกษตร', '[''เกษตร'', ''นาข้าว'', ''ปุ๋ย'']', 152);
INSERT INTO groups VALUES ('สาธารณสุข', '[''หมอ'', ''แพทย์'', ''สาธารณสุข'', ''โรค'']', 151);
INSERT INTO groups VALUES ('วัฒนธรรม', '[''จักสาน'', ''บายศรี'', ''ทอผ้า'', ''ช่าง'', ''ดนตรี'', ''จักรสาน'', ''อนุรักษ์'']', 150);
INSERT INTO groups VALUES ('การศึกษา', '[''ครู'', ''โรงเรียน'', ''ศูนย์พัฒนาเด็ก'']', 155);
INSERT INTO groups VALUES ('กองทุน', '[''กองทุน'']', 156);
INSERT INTO groups VALUES ('สิ่งแวดล้อม', '[''ขยะ'', ''สิ่งแวดล้อม'', ''แกนนำดูแลคลอง'']', 154);


--
-- Data for Name: location; Type: TABLE DATA; Schema: public; Owner: tcnap
--

INSERT INTO location VALUES (1, 'x', 'y', 'z');
INSERT INTO location VALUES (2, 'บางระกำ', 'บางเลน', 'นครปฐม');
INSERT INTO location VALUES (3, 'สะอาด', 'น้ำพอง', 'ขอนแก่น');
INSERT INTO location VALUES (4, 'วังชิ้น', 'วังชิ้น', 'แพร่');


--
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: tcnap
--

INSERT INTO person VALUES (5, 'อำภา', 'ขจรบุญ', 'ประธานสถาบันการเงิน/รองนายกอบต./แกนนำกลุ่มสตรี', 'บางระกำ', 2);
INSERT INTO person VALUES (6, 'โสภณ', 'ประกอบบุญ', 'รองประธานสถาบันการเงินชุมชนตำบลบางระกำ', 'บางระกำ', 2);
INSERT INTO person VALUES (7, 'ยงยุทธ', 'นุ่มพญา', 'รองประธานสถาบันการเงินชุมชนตำบลบางระกำ', 'บางระกำ', 2);
INSERT INTO person VALUES (8, 'ริสา', 'กลิ่นรอด', 'เหรัญญิกสถาบันการเงินชุมชนตำบลบางระกำ', 'บางระกำ', 2);
INSERT INTO person VALUES (9, 'นันทวรรณ', 'พลายงาม', 'เจ้าหน้าที่การเงินและบัญชีสถาบันการเงินชุมชนตำบลบางระกำ', 'บางระกำ', 2);
INSERT INTO person VALUES (10, 'สมเกียรติ', 'สุนทรอำไพ', 'เลขานุการสถาบันการเงินชุมชนตำบลบางระกำและประธานกองทุนสวัสดิการชุมชนตำบลบางระกำ', 'บางระกำ', 2);
INSERT INTO person VALUES (11, 'สุโข', 'เพ็ชรเกษม', 'รองประธานกองทุนสวัสดิการชุมชนตำบลบางระกำ', 'บางระกำ', 2);
INSERT INTO person VALUES (12, 'สมชาย', 'สุขวิบูลย์', 'รองประธานกองทุนสวัสดิการชุมชนตำบลบางระกำ', 'บางระกำ', 2);
INSERT INTO person VALUES (13, 'มีชัย', 'อรุณภู่', 'เลขานุการกองทุนสวัสดิการชุมชนตำบลบางระกำ', 'บางระกำ', 2);
INSERT INTO person VALUES (14, 'ศศิประภา', 'ภมรสูตร', 'เจ้าหน้าทีการเงินและบัญชีกองทุนสวัสดิการชุมชนตำบลบางระกำ', 'บางระกำ', 2);
INSERT INTO person VALUES (15, 'ปัทมา', 'ศรีคัชชะ', 'ประธานชมรมผู้สูงอายุตำบลบางระกำ', 'บางระกำ', 2);
INSERT INTO person VALUES (16, 'เสน่ห์', 'ศรีอ่วมบู่', 'แกนนำวิสาหกิจกลุ่มทำนาข้าวพันธุ์ดี', 'บางระกำ', 2);
INSERT INTO person VALUES (17, 'ธัญญะ', 'สำรวญหันต์', 'แกนนำดูแลคลองควาย หมู่ 1,3,5,11,12', 'บางระกำ', 2);
INSERT INTO person VALUES (18, 'เอื้อน', 'สำรวญหันต์', 'แกนนำดูแลคลองควาย หมู่ 1,3,5,11,12', 'บางระกำ', 2);
INSERT INTO person VALUES (19, 'วันดี', 'นิลญาณ', 'แกนนำดูแลคลองบางขะโมย', 'บางระกำ', 2);
INSERT INTO person VALUES (20, 'ประยุทธ', 'นิลญาณ', 'แกนนำดูแลคลองตาหรั่ง', 'บางระกำ', 2);
INSERT INTO person VALUES (21, 'อนุวัฒน์', 'ฤทธิ์มหา', 'แกนนำดูแลคลองรางมะดัน', 'บางระกำ', 2);
INSERT INTO person VALUES (22, 'สมบัติ', 'อรุณภู่', 'แกนนำดูแลคลองบางระกำ', 'บางระกำ', 2);
INSERT INTO person VALUES (23, 'ธนวัฒน์', 'ชื่นทองคำ', 'แกนนำดูแลคลองผู้ใหญ่สมชาย', 'บางระกำ', 2);
INSERT INTO person VALUES (24, 'มานัส', 'สูยสิ้นภัย', 'แกนนำดูแลคลองนายมานะ', 'บางระกำ', 2);
INSERT INTO person VALUES (25, 'วิรัตน์', 'ขวัญเริงใจ', 'แกนนำดูแลคลองนายโปรย', 'บางระกำ', 2);
INSERT INTO person VALUES (26, 'สมอน', 'หล้าบ้านหลวง', 'แกนนำดูแลคลองนายดัดและคลองนายจำเนียร', 'บางระกำ', 2);
INSERT INTO person VALUES (27, 'อนุรักษ์', 'สุนทรอำไพ', 'แกนนำดูแลคลองนายเจียม', 'บางระกำ', 2);
INSERT INTO person VALUES (28, 'เทพพิทักษ์', 'กันเปลี่ยน', 'แกนนำ อช.', 'บางระกำ', 2);
INSERT INTO person VALUES (29, 'พรรณทิภา', 'สำราญจิตร', 'แกนนำอช. / ผู้ช่วยผู้ใหญ่', 'บางระกำ', 2);
INSERT INTO person VALUES (30, 'สวง', 'ประกอบบุญ', 'หมอทำขวัญ', 'บางระกำ', 2);
INSERT INTO person VALUES (31, 'มาลี', 'เกตุกระทึก', 'หมอสมุนไพร/นวดแผนไทย/อบสมุนไพร', 'บางระกำ', 2);
INSERT INTO person VALUES (32, 'ทรัพย์', 'หงษ์ทองมี', 'ผู้อนุรักษ์การประกอบอาชีพช่างไม้', 'บางระกำ', 2);
INSERT INTO person VALUES (33, 'วิง', 'หงษ์ทองมี', 'ผู้เชี่ยวชาญด้านงานจักสาน', 'บางระกำ', 2);
INSERT INTO person VALUES (34, 'ระเ้บียบ', 'อินทร', 'ครูสอนดนตรีไทย', 'บางระกำ', 2);
INSERT INTO person VALUES (35, 'ปัญญา', 'เห่งนาเลน', 'ประธานอสม.ระดับหมู่บ้าน หมู่ที่ 1', 'บางระกำ', 2);
INSERT INTO person VALUES (36, 'ไพรัช', 'เส็งประชา', 'ประธาน อสม. ระดับหมู่บ้าน หมู่ที่ 2', 'บางระกำ', 2);
INSERT INTO person VALUES (37, 'ลอย', 'เปาวะสันต์', 'ประธาน อสม. ระดับหมู่บ้าน หมู่ที่ 3', 'บางระกำ', 2);
INSERT INTO person VALUES (38, 'ศักดิ์ชัย', 'ศรีเพ็งแก้ว', 'ประธาน อสม. ระดับหมู่บ้าน หมู่ที่ 4', 'บางระกำ', 2);
INSERT INTO person VALUES (39, 'บุญเรือน', 'สุวรรณวงษ์', 'ประธาน อสม. ระดับหมู่บ้าน หมู่ที่ 5', 'บางระกำ', 2);
INSERT INTO person VALUES (40, 'เอนก', 'ต่วนกลิ่นคง', 'ประธาน อสม. ระดับหมู่บ้าน หมู่ที่ 8', 'บางระกำ', 2);
INSERT INTO person VALUES (41, 'นงเยาว์', 'ลภัสรดาอาภา', 'ประธาน อสม. ระดับหมู่บ้าน หมู่ที่ 10', 'บางระกำ', 2);
INSERT INTO person VALUES (42, 'ผัน', 'ปิ่นปฐม', 'ประธาน อสม. ระดับหมู่บ้าน หมู่ที่ 11', 'บางระกำ', 2);
INSERT INTO person VALUES (43, 'อำนาจ', 'ปิ่นโรจน์', 'ประธาน อสม. ระดับหมู่บ้าน หมู่ที่ 12', 'บางระกำ', 2);
INSERT INTO person VALUES (44, 'ช่วย', 'เมืองแก้วฟ้า', 'ประธาน อสม. ระดับหมู่บ้าน หมู่ที่ 15', 'บางระกำ', 2);
INSERT INTO person VALUES (45, 'สมชาย', 'เทียมเวหา', 'ผู้ช่วยผู้ใหญ่บ้าน', 'บางระกำ', 2);
INSERT INTO person VALUES (46, 'เสน่ห์', 'ชัยยะ', 'ผู้ช่วยผู้ใหญ่บ้าน', 'บางระกำ', 2);
INSERT INTO person VALUES (47, 'เตือนใจ', 'ปิ่นเวหา', 'ผู้ช่วยผู้ใหญ่บ้าน', 'บางระกำ', 2);
INSERT INTO person VALUES (48, 'สุริ', 'โสภาผิว', 'ผู้ช่วยผู้ใหญ่บ้าน', 'บางระกำ', 2);
INSERT INTO person VALUES (49, 'บุญเลิศ', 'สร้อยคำ', 'ผู้ช่วยผู้ใหญ่บ้าน', 'บางระกำ', 2);
INSERT INTO person VALUES (50, 'ศรายุทธ', 'จุ่นมีวงษ์', 'ผู้ใหญ่บ้าน', 'บางระกำ', 2);
INSERT INTO person VALUES (51, 'สมชาย', 'ศรศรี', 'ผู้ช่วยผู้ใหญ่บ้าน', 'บางระกำ', 2);
INSERT INTO person VALUES (52, 'วันเพ็ญ', 'โบวิเชียร', 'ผู้ใหญ่บ้าน/อสม./อปพร.', 'บางระกำ', 2);
INSERT INTO person VALUES (53, 'สมบูรณ์', 'พลายงาม', 'ผู้ช่วยผู้ใหญ่บ้าน', 'บางระกำ', 2);
INSERT INTO person VALUES (54, 'อนันต์', 'พริ้งพลาย', 'ผู้ช่วยผู้ใหญ่บ้าน', 'บางระกำ', 2);
INSERT INTO person VALUES (55, 'ชัยวัฒน์', 'ปั้นแจ้งอรุณ', 'ผู้ช่วยผู้ใหญ่บ้าน', 'บางระกำ', 2);
INSERT INTO person VALUES (56, 'สมใจ', 'บุมี', 'ผู้ช่วยผู้ใหญ่บ้าน', 'บางระกำ', 2);
INSERT INTO person VALUES (57, 'สมศักดิ์', 'วันบรรจบ', 'ผู้ใหญ่บ้าน/เลขานุการสภาองค์กรชุมชน/กรรมการการศึกษา', 'บางระกำ', 2);
INSERT INTO person VALUES (58, 'โสภณ', 'แก้วพารา', 'ผู้ช่วยผู้ใหญ่บ้าน', 'บางระกำ', 2);
INSERT INTO person VALUES (59, 'ศิริ', 'มงคลนัฎ', 'ผู้ใหญ่บ้าน', 'บางระกำ', 2);
INSERT INTO person VALUES (60, 'คณฑี', 'เอี่ยมสะอาด', 'ผู้ใหญ่บ้าน', 'บางระกำ', 2);
INSERT INTO person VALUES (61, 'วินัย', 'นราจุน', 'ผู้ช่วยผู้ใหย่บ้าน', 'บางระกำ', 2);
INSERT INTO person VALUES (62, 'ไพโรจน์', 'เอี่ยมอำพันธ์', 'ผู้ช่วยผู้ใหญ่บ้าน', 'บางระกำ', 2);
INSERT INTO person VALUES (63, 'อนันตชัย', 'แคล้วโรคา', 'ผู้ช่วยผู้ใหญ่บ้าน/อสม.', 'บางระกำ', 2);
INSERT INTO person VALUES (64, 'อารี', 'แสงเดชะ', 'ผู้ช่วยผู้ใหญ่บ้าน', 'บางระกำ', 2);
INSERT INTO person VALUES (65, 'ทองอยู่', 'นุชสุดสวาท', 'ผู้ช่วยผู้ใหญ่บ้าน', 'บางระกำ', 2);
INSERT INTO person VALUES (66, 'ณัฐวัฒน์', 'ชั้นอินทร์งาิม', 'นายกองค์การบริหารส่วนตำบลบางระกำ/ประธานศูนย์อปพร.', 'บางระกำ', 2);
INSERT INTO person VALUES (67, 'มนัส', 'เรียนสร้อย', 'รองนายกองค์การบริหารส่วนตำบล', 'บางระกำ', 2);
INSERT INTO person VALUES (68, 'ฉลอง', 'ปิ่นทองคำ', 'เลขานุการนายกองค์การบริหารส่วนตำบล/ประธานศาลาสร้างสุข', 'บางระกำ', 2);
INSERT INTO person VALUES (69, 'ประสิทธิ์', 'การดำริห์', 'รองประธานสภาองค์การบริหารส่วนตำบล', 'บางระกำ', 2);
INSERT INTO person VALUES (70, 'ไพฑูรย์', 'สำรวญหันต์', 'สมาชิก อบต./กรรมการหมู่บ้าน/วิทยากรชุมชน', 'บางระกำ', 2);
INSERT INTO person VALUES (71, 'ประสงค์', 'พงศ์พิริยะจิต', 'สมาชิก อบต./วิทยากรชุมชน', 'บางระกำ', 2);
INSERT INTO person VALUES (72, 'นฤมล', 'เปาวะสันต์', 'สมาชิกอบต./อสม./วิทยากรชุมชน/แกนนำดูแลคูคลอง/อผส.', 'บางระกำ', 2);
INSERT INTO person VALUES (73, 'เสรี', 'วงศ์ประชา', 'สมาชิกอบต./อปพร.', 'บางระกำ', 2);
INSERT INTO person VALUES (74, 'สุรินทร์', 'จุ่นมีวงษ์', 'สมาชิกอบต.', 'บางระกำ', 2);
INSERT INTO person VALUES (75, 'สายัน', 'จ้อยพึ่งพร', 'สมาชิกอบต.', 'บางระกำ', 2);
INSERT INTO person VALUES (76, 'สมนึก', 'จงรักษาวงศ์กุล', 'สมาชิกอบต.', 'บางระกำ', 2);
INSERT INTO person VALUES (77, 'ปรีชา', 'ปั้นแจ้งอรุณ', 'สมาชิกอบต./อปพร.', 'บางระกำ', 2);
INSERT INTO person VALUES (78, 'เสนห์', 'ปิ่นเวหา', 'สมาชิกอบต./อปพร.', 'บางระกำ', 2);
INSERT INTO person VALUES (79, 'วิสูตร', 'ดวงแสงศรี', 'สมาชิกอบต.', 'บางระกำ', 2);
INSERT INTO person VALUES (80, 'มนตรี', 'จารุพิชิตปรัชญา', 'สมาชิกอบต./อปพร.', 'บางระกำ', 2);
INSERT INTO person VALUES (81, 'เศกสรรค์', 'ศรีสุขเอม', 'สมาชิกอบต./อปพร.', 'บางระกำ', 2);
INSERT INTO person VALUES (82, 'วรนุช', 'ปิ่นทองคำ', 'อาจารย์โรงเรียนวัดสุขวัมนาราม', 'บางระกำ', 2);
INSERT INTO person VALUES (83, 'มณีวรรณ', 'แม่นยำ', 'เจ้าหน้าที่ศูนย์พัฒนาเด็กเล็กตำบลบางระกำ', 'บางระกำ', 2);
INSERT INTO person VALUES (84, 'เพ็ญศิริ', 'เข็มทอง', 'กลุ่มสตรีอาสาพัฒนาตำบลบางระกำ ส่งเสริมและสนับสนุนและพัฒนาด้านอาชีพและคุณภาพชีวิตสตรี', 'บางระกำ', 2);
INSERT INTO person VALUES (85, 'รุ่งนภา', 'ทองประเพียร', 'ชมรมผู้พิการตำบลบางระกำ ส่งเสริม สนับสนุน พัฒนาคุณภาพชีวิตและสวัสดิการแก่ผู้พิการ', 'บางระกำ', 2);
INSERT INTO person VALUES (86, 'สมเกียรติ', 'สุนทรอำไพ/นายบุณเลื่อน', 'กลุ่มส่งเสริมอาชีพบางระกำเพื่อการเกษตร ส่งเสริมและสนับสนุนด้านการเกษตร', 'บางระกำ', 2);
INSERT INTO person VALUES (119, 'สุดสวาท', 'ดีดพิณ', 'ผู้นำด้านเกษตร พลังงานทดแทน', 'วังชิ้น', 4);
INSERT INTO person VALUES (87, 'บุญส่ง', 'ศรีทิพย์', 'อาสาสมัครสาธารณสุข เก็บรวบรวมข้อมูลสุขภาพคนในชุมชน ออกตรวจสุขภาพเชิงรุก/ส่งเสริมการป้องกันโรคต่าง ๆ รวมทั้งให้ความรู้เรื่องโรคติดต่อ', 'บางระกำ', 2);
INSERT INTO person VALUES (88, 'สมเกียรติ', 'สนุทรอำไพ', 'ปุ๋ยชีวภาพบางระกำทำรวย ส่งเสริมการทำเกาตรปลอดภัยในชุมชน/พัฒนาวิทยากรท้องถิ่น/จัดกิจกรรมส่งเสริมการปลูกพืชสมนุไพร', 'บางระกำ', 2);
INSERT INTO person VALUES (89, 'บุณเลื่อน', 'ปิ่นสมนาม', 'พอเพียงแบบบางระกำ ส่งเสริมการทำเกษตรปลอดภัยในชุมชน/พัฒนาวิทยากรท้องถิ่น/จัดกิจกรรมส่งเสริมการปลูกพืชสมนุไพร', 'บางระกำ', 2);
INSERT INTO person VALUES (90, 'สมศักดิ์', 'วันบรรจบ/เจ้าของบ้านโฮมสเตย์', 'ตู้เย็นข้างครัว ตู้ยาข้างบ้าน ส่งเสริมการทำเกษตรปลอดภัยในชุมชน/พัฒนาวิทยากรท้องถิ่น/จัดกิจกรรมส่งเสริมการปลูกพืชสมนุไพร', 'บางระกำ', 2);
INSERT INTO person VALUES (91, 'เฉลียว', 'สำราญใจ', 'การจัดการขยะในครัวเรือน เตรียมหมู่บ้านต้นแบบ/ส้รางแกนนำในการแยกขยะให้เป็นรูปธรรม', 'บางระกำ', 2);
INSERT INTO person VALUES (92, 'ประสงค์', 'พงศ์พิิริยะจิต', 'หมู่บ้านสะอาดบางขะโมย พัฒนาหมู่ที่ 1 เป็นหมู่บ้านต้นแบบการจัดการสิ่งแวดล้อม', 'บางระกำ', 2);
INSERT INTO person VALUES (93, 'สุขนิษฐา', 'แจ่มจันทร์งาม', 'ศูนย์พัฒนาเด็กเล็กตำบลบางระกำ จัดกิจกรรมธนาคารของเล่นเพื่อรับบริจาคของเล่น', 'บางระกำ', 2);
INSERT INTO person VALUES (94, 'ปัณณธร', 'ปิ่นทองคำ', 'เยาวชนรักถิ่น พัฒนาวิทยากรชุมชนรุ่นเยาว์เพื่อทำหน้าที่เผยแพร่ภูมิปัญญาท้องถิ่น', 'บางระกำ', 2);
INSERT INTO person VALUES (95, 'อุไร', 'วันบรรจบ', 'ศูนย์การเรียนรู้แพทย์แผนไทย เปิดอบรมเยาวชน เพื่อดูแลคนในครอบครัว/พัฒนาศุนย์เรียนรู้และวิทยากร', 'บางระกำ', 2);
INSERT INTO person VALUES (96, 'สุมาลา', 'เปาวะสันต์', 'ภูมิปัญญาป้องกันโรค ศึกษาและเผยแพร่ภูมิปัญญา/พัฒนาศูนย์เรียนรู้และวิทยากร', 'บางระกำ', 2);
INSERT INTO person VALUES (97, 'ณัฐวัฒน์', 'ชั้นอินทร์งาม', 'อบต.กับการบริหารแบบหลักธรรมภิบาล พัฒนาศักยภาพ 7 ระบบสร้างสุข/สร้างการมีส่วนร่วมในชุมชน', 'บางระกำ', 2);
INSERT INTO person VALUES (98, 'ประครอง', 'ศรีชาทุม', 'ผู้ใหญ่บ้าน,ประธานกองทุน,ผู้บริหารชุมชน', 'สะอาด', 3);
INSERT INTO person VALUES (99, 'หนูพิน', 'นาวงนอก', 'ประธานกลุ่ม อผสก.', 'สะอาด', 3);
INSERT INTO person VALUES (100, 'วรรเพ็ญ', 'ขันอาษา', 'ประธาน อสม.', 'สะอาด', 3);
INSERT INTO person VALUES (101, 'คำมุน', 'ทองลี', 'จ้ำ ประจำหมู่บ้าน', 'สะอาด', 3);
INSERT INTO person VALUES (102, 'คำซะ', 'ทวีสิน', 'กลุ่มจักรสาน', 'สะอาด', 3);
INSERT INTO person VALUES (103, 'ทองจันทร์', 'อินคมล', 'ผู้นำศาสนาด้านสตรี,ทำบายศรีสู่ขวัญ', 'สะอาด', 3);
INSERT INTO person VALUES (104, 'อาภรณ์', 'วังทองบง', 'กลุ่มทอผ้า,กรรมการกองบุญสัจจะ,กรรมการหมู่บ้าน', 'สะอาด', 3);
INSERT INTO person VALUES (105, 'คำมี', 'ทุมพิลา', 'ผู้ช่วยผู้ใหญ่บ้าน/รักษาความปลอดภัยหมู่บ้าน', 'สะอาด', 3);
INSERT INTO person VALUES (106, 'คำเมฆ', 'หงษ์สุด', 'ผู้ช่วยผู้ใหญ่บ้าน/รักษาความปลอดภัยหมู่บ้าน', 'สะอาด', 3);
INSERT INTO person VALUES (107, 'สี', 'วาดไธสง', 'อปพร.รักษาความปลอดภัยหมู่บ้าน', 'สะอาด', 3);
INSERT INTO person VALUES (108, 'ประเวศ', 'หงษ์วรรณา', 'อปพร.รักษาความปลอดภัยหมู่บ้าน', 'สะอาด', 3);
INSERT INTO person VALUES (109, 'ทองดี', 'ทุมพิลา', 'สมาชิก อบต.', 'สะอาด', 3);
INSERT INTO person VALUES (110, 'ทองสุข', 'อินทร์ประเสริฐ', 'สมาชิก อบต.', 'สะอาด', 3);
INSERT INTO person VALUES (111, 'คำซะ', 'ทวีิสิน', 'กลุ่มจักรสาน จักรสานไม่ไผ่เพื่อนำขายในตำบล', 'สะอาด', 3);
INSERT INTO person VALUES (112, 'ชุม', 'จีทา', 'ปราชญ์ชาวบ้าน', 'วังชิ้น', 4);
INSERT INTO person VALUES (113, 'เฉลียว', 'เป็งดิบ', 'เกษตรกรด้านการเกษตรผสมผสาน', 'วังชิ้น', 4);
INSERT INTO person VALUES (114, 'มนู', 'กาญจะนะ', 'เกษตรกรด้านการเกษตรผสมผสาน', 'วังชิ้น', 4);
INSERT INTO person VALUES (115, 'ถวิล', 'สุดสาย', 'เกษตรกรด้านการเพาะพันธุ์สุกร', 'วังชิ้น', 4);
INSERT INTO person VALUES (116, 'สะดวก', 'ผ่ิองพั้น', 'เกษตรกรด้านเศรษฐกิจพอเพียง', 'วังชิ้น', 4);
INSERT INTO person VALUES (117, 'กาบ', 'อินทรีย์', 'แกนนำผู้สูงอายุ', 'วังชิ้น', 4);
INSERT INTO person VALUES (118, 'จเร', 'คำหุ่น', 'แกนนำอนุรักษ์ป่าชุมชน', 'วังชิ้น', 4);
INSERT INTO person VALUES (120, 'สวัสดิ์', 'บุดดาจี', 'ผู้นำด้านการป้องกันและบรรเทาสาธารณภัย', 'วังชิ้น', 4);
INSERT INTO person VALUES (121, 'บุญเชียน', 'บุญเรือง', 'ผู้นำกลุ่มสตรีแม่บ้านตำบล', 'วังชิ้น', 4);
INSERT INTO person VALUES (122, 'ประเสริฐ', 'พริบไหว', 'นักวิชาการสาธารณสุข', 'วังชิ้น', 4);
INSERT INTO person VALUES (123, 'ปั่น', 'คำสี', 'ปราชญ์ชาวบ้าน', 'วังชิ้น', 4);
INSERT INTO person VALUES (124, 'ประดิษฐ์', 'สายวงค์', 'ผู้นำด้านการพัฒนาชุมชน', 'วังชิ้น', 4);
INSERT INTO person VALUES (125, 'ราน', 'ใยไม้', 'ผู้นำด้านการพัฒนา', 'วังชิ้น', 4);
INSERT INTO person VALUES (126, 'สุวรรณ์', 'ทาคำ', 'คณะทำงานตำบลนาพูน', 'วังชิ้น', 4);
INSERT INTO person VALUES (127, 'ขจร', 'ใจมา', 'คณะทำงานตำบลนาพูน', 'วังชิ้น', 4);
INSERT INTO person VALUES (128, 'เสนอ', 'ตู่ผัด', 'ผู้นำหมู่บ้านหมู่3', 'วังชิ้น', 4);
INSERT INTO person VALUES (129, 'วิโรจน์', 'จันน้ำท้วม', 'เป็นผู้นำด้านการพัฒนา', 'วังชิ้น', 4);
INSERT INTO person VALUES (130, 'สมเดช', 'หล่อหลอม', 'เป็นผู้นำด้านการพัฒนา', 'วังชิ้น', 4);
INSERT INTO person VALUES (131, 'เสน่ห์', 'เงินมูล', 'ผู้นำหมู่บ้านหมู่ 2', 'วังชิ้น', 4);
INSERT INTO person VALUES (132, 'เวช', 'สมรส', 'ผู้นำทางด้านการพัฒนา', 'วังชิ้น', 4);
INSERT INTO person VALUES (133, 'คนึง', 'ตาปิก', 'เป็นผู้นำด้านการพัฒนา', 'วังชิ้น', 4);
INSERT INTO person VALUES (134, 'จำนงค์', 'บุญญฤทธิ์', 'ผู้นำทางด้านการพัฒนา', 'วังชิ้น', 4);
INSERT INTO person VALUES (135, 'ทอง', 'กาวิโล', 'ผุู้นำด้านการพัฒนา', 'วังชิ้น', 4);
INSERT INTO person VALUES (136, 'สีเทา', 'ปาแก้ว', 'ผู้นำด้านการพัฒนา', 'วังชิ้น', 4);
INSERT INTO person VALUES (137, 'สุวรรณ์', 'เขียวสี', 'ผู้นำทางด้านการพัฒนา', 'วังชิ้น', 4);
INSERT INTO person VALUES (138, 'แสวง', 'สีแก้ว', 'ผู้นำด้านการพัฒนา', 'วังชิ้น', 4);
INSERT INTO person VALUES (139, 'สมพจน์', 'ทาคำ', 'ผุู้นำด้านการพัฒนา', 'วังชิ้น', 4);
INSERT INTO person VALUES (140, 'ชุม', 'ต่วนโต', 'ผู้มีส่วนช่วยการพัฒนาตำบล', 'วังชิ้น', 4);
INSERT INTO person VALUES (141, 'สมศรี', 'กาศวิเศษ', 'ผู้มีส่วนช่วยการพัฒนาตำบล', 'วังชิ้น', 4);
INSERT INTO person VALUES (142, 'ยุตร', 'เงินมูล', 'ผู้มีส่วนช่วยการพัฒนาตำบล', 'วังชิ้น', 4);
INSERT INTO person VALUES (143, 'พนม', 'ดงดอน', 'ผู้มีส่วนช่วยการพัฒนาตำบล', 'วังชิ้น', 4);
INSERT INTO person VALUES (144, 'ประภัย', 'แก้ววัน', 'ผู้มีส่วนช่วยการพัฒนาตำบล', 'วังชิ้น', 4);
INSERT INTO person VALUES (145, 'ธนกฤต', 'มาบาง', 'ผู้มีส่วนช่วยการพัฒนาตำบล', 'วังชิ้น', 4);
INSERT INTO person VALUES (146, 'มัลลิกา', 'มาจนทร์', 'บุคลากรทางการศึกษา', 'วังชิ้น', 4);
INSERT INTO person VALUES (147, 'เกศนารี', 'แปงนา', 'ครู กศน.ประจำตำบลนาพูน', 'วังชิ้น', 4);
INSERT INTO person VALUES (148, 'กฤษดา', 'ปันจิน๊ะ', 'เจ้าหน้าที่สาธารณสุข', 'วังชิ้น', 4);


--
-- Data for Name: person_group; Type: TABLE DATA; Schema: public; Owner: tcnap
--

INSERT INTO person_group VALUES (5, 149);
INSERT INTO person_group VALUES (5, 153);
INSERT INTO person_group VALUES (6, 149);
INSERT INTO person_group VALUES (7, 149);
INSERT INTO person_group VALUES (10, 149);
INSERT INTO person_group VALUES (10, 156);
INSERT INTO person_group VALUES (11, 149);
INSERT INTO person_group VALUES (11, 156);
INSERT INTO person_group VALUES (12, 149);
INSERT INTO person_group VALUES (12, 156);
INSERT INTO person_group VALUES (13, 156);
INSERT INTO person_group VALUES (14, 156);
INSERT INTO person_group VALUES (15, 149);
INSERT INTO person_group VALUES (16, 152);
INSERT INTO person_group VALUES (17, 154);
INSERT INTO person_group VALUES (18, 154);
INSERT INTO person_group VALUES (19, 154);
INSERT INTO person_group VALUES (20, 154);
INSERT INTO person_group VALUES (21, 154);
INSERT INTO person_group VALUES (22, 154);
INSERT INTO person_group VALUES (23, 154);
INSERT INTO person_group VALUES (24, 154);
INSERT INTO person_group VALUES (25, 154);
INSERT INTO person_group VALUES (26, 154);
INSERT INTO person_group VALUES (27, 154);
INSERT INTO person_group VALUES (29, 153);
INSERT INTO person_group VALUES (30, 151);
INSERT INTO person_group VALUES (31, 151);
INSERT INTO person_group VALUES (32, 150);
INSERT INTO person_group VALUES (33, 150);
INSERT INTO person_group VALUES (34, 150);
INSERT INTO person_group VALUES (34, 155);
INSERT INTO person_group VALUES (35, 149);
INSERT INTO person_group VALUES (35, 153);
INSERT INTO person_group VALUES (36, 149);
INSERT INTO person_group VALUES (36, 153);
INSERT INTO person_group VALUES (37, 149);
INSERT INTO person_group VALUES (37, 153);
INSERT INTO person_group VALUES (38, 149);
INSERT INTO person_group VALUES (38, 153);
INSERT INTO person_group VALUES (39, 149);
INSERT INTO person_group VALUES (39, 153);
INSERT INTO person_group VALUES (40, 149);
INSERT INTO person_group VALUES (40, 153);
INSERT INTO person_group VALUES (41, 149);
INSERT INTO person_group VALUES (41, 153);
INSERT INTO person_group VALUES (42, 149);
INSERT INTO person_group VALUES (42, 153);
INSERT INTO person_group VALUES (43, 149);
INSERT INTO person_group VALUES (43, 153);
INSERT INTO person_group VALUES (44, 149);
INSERT INTO person_group VALUES (44, 153);
INSERT INTO person_group VALUES (45, 153);
INSERT INTO person_group VALUES (46, 153);
INSERT INTO person_group VALUES (47, 153);
INSERT INTO person_group VALUES (48, 153);
INSERT INTO person_group VALUES (49, 153);
INSERT INTO person_group VALUES (50, 153);
INSERT INTO person_group VALUES (51, 153);
INSERT INTO person_group VALUES (52, 153);
INSERT INTO person_group VALUES (53, 153);
INSERT INTO person_group VALUES (54, 153);
INSERT INTO person_group VALUES (55, 153);
INSERT INTO person_group VALUES (56, 153);
INSERT INTO person_group VALUES (57, 153);
INSERT INTO person_group VALUES (58, 153);
INSERT INTO person_group VALUES (59, 153);
INSERT INTO person_group VALUES (60, 153);
INSERT INTO person_group VALUES (62, 153);
INSERT INTO person_group VALUES (63, 153);
INSERT INTO person_group VALUES (64, 153);
INSERT INTO person_group VALUES (65, 153);
INSERT INTO person_group VALUES (66, 149);
INSERT INTO person_group VALUES (66, 153);
INSERT INTO person_group VALUES (67, 153);
INSERT INTO person_group VALUES (68, 149);
INSERT INTO person_group VALUES (68, 153);
INSERT INTO person_group VALUES (69, 149);
INSERT INTO person_group VALUES (69, 153);
INSERT INTO person_group VALUES (70, 153);
INSERT INTO person_group VALUES (71, 153);
INSERT INTO person_group VALUES (72, 153);
INSERT INTO person_group VALUES (73, 153);
INSERT INTO person_group VALUES (74, 153);
INSERT INTO person_group VALUES (75, 153);
INSERT INTO person_group VALUES (76, 153);
INSERT INTO person_group VALUES (77, 153);
INSERT INTO person_group VALUES (78, 153);
INSERT INTO person_group VALUES (79, 153);
INSERT INTO person_group VALUES (80, 153);
INSERT INTO person_group VALUES (81, 153);
INSERT INTO person_group VALUES (82, 155);
INSERT INTO person_group VALUES (83, 155);
INSERT INTO person_group VALUES (86, 152);
INSERT INTO person_group VALUES (119, 149);
INSERT INTO person_group VALUES (119, 152);
INSERT INTO person_group VALUES (87, 151);
INSERT INTO person_group VALUES (88, 152);
INSERT INTO person_group VALUES (89, 152);
INSERT INTO person_group VALUES (90, 152);
INSERT INTO person_group VALUES (91, 154);
INSERT INTO person_group VALUES (92, 154);
INSERT INTO person_group VALUES (93, 155);
INSERT INTO person_group VALUES (95, 151);
INSERT INTO person_group VALUES (96, 151);
INSERT INTO person_group VALUES (97, 153);
INSERT INTO person_group VALUES (98, 149);
INSERT INTO person_group VALUES (98, 153);
INSERT INTO person_group VALUES (98, 156);
INSERT INTO person_group VALUES (99, 149);
INSERT INTO person_group VALUES (100, 149);
INSERT INTO person_group VALUES (100, 153);
INSERT INTO person_group VALUES (102, 150);
INSERT INTO person_group VALUES (103, 149);
INSERT INTO person_group VALUES (103, 150);
INSERT INTO person_group VALUES (104, 150);
INSERT INTO person_group VALUES (105, 153);
INSERT INTO person_group VALUES (106, 153);
INSERT INTO person_group VALUES (109, 153);
INSERT INTO person_group VALUES (110, 153);
INSERT INTO person_group VALUES (111, 150);
INSERT INTO person_group VALUES (113, 152);
INSERT INTO person_group VALUES (114, 152);
INSERT INTO person_group VALUES (115, 152);
INSERT INTO person_group VALUES (116, 152);
INSERT INTO person_group VALUES (118, 150);
INSERT INTO person_group VALUES (120, 149);
INSERT INTO person_group VALUES (121, 149);
INSERT INTO person_group VALUES (122, 151);
INSERT INTO person_group VALUES (124, 149);
INSERT INTO person_group VALUES (125, 149);
INSERT INTO person_group VALUES (128, 149);
INSERT INTO person_group VALUES (129, 149);
INSERT INTO person_group VALUES (130, 149);
INSERT INTO person_group VALUES (131, 149);
INSERT INTO person_group VALUES (132, 149);
INSERT INTO person_group VALUES (133, 149);
INSERT INTO person_group VALUES (134, 149);
INSERT INTO person_group VALUES (136, 149);
INSERT INTO person_group VALUES (137, 149);
INSERT INTO person_group VALUES (138, 149);
INSERT INTO person_group VALUES (147, 155);
INSERT INTO person_group VALUES (148, 151);


--
-- Name: group_pkey; Type: CONSTRAINT; Schema: public; Owner: tcnap; Tablespace: 
--

ALTER TABLE ONLY groups
    ADD CONSTRAINT group_pkey PRIMARY KEY (id);


--
-- Name: person_group_pkey; Type: CONSTRAINT; Schema: public; Owner: tcnap; Tablespace: 
--

ALTER TABLE ONLY person_group
    ADD CONSTRAINT person_group_pkey PRIMARY KEY (person_id, group_id);


--
-- Name: person_pkey; Type: CONSTRAINT; Schema: public; Owner: tcnap; Tablespace: 
--

ALTER TABLE ONLY person
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);


--
-- Name: pk; Type: CONSTRAINT; Schema: public; Owner: tcnap; Tablespace: 
--

ALTER TABLE ONLY location
    ADD CONSTRAINT pk PRIMARY KEY (id);


--
-- Name: person_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tcnap
--

ALTER TABLE ONLY person
    ADD CONSTRAINT person_location_id_fkey FOREIGN KEY (location_id) REFERENCES location(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: tcnap
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM tcnap;
GRANT ALL ON SCHEMA public TO tcnap;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

