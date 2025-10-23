--
-- PostgreSQL database dump
--

\restrict mYTiABwkTKx5tL0ipNNFHVGZccYTO0gIZWTdgHc4T7CTaECMkLLUPUIXIBYfR70

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

-- Started on 2025-10-23 14:34:29

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4970 (class 0 OID 41830)
-- Dependencies: 220
-- Data for Name: materialtype; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.materialtype VALUES (1, 'Пластичные материалы', 0.12);
INSERT INTO public.materialtype VALUES (2, 'Добавка', 0.20);
INSERT INTO public.materialtype VALUES (3, 'Электролит', 0.15);
INSERT INTO public.materialtype VALUES (4, 'Глазурь', 0.30);
INSERT INTO public.materialtype VALUES (5, 'Пигмент', 0.25);


--
-- TOC entry 4968 (class 0 OID 41821)
-- Dependencies: 218
-- Data for Name: unit; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.unit VALUES (1, 'кг');
INSERT INTO public.unit VALUES (2, 'л');
INSERT INTO public.unit VALUES (3, 'шт');


--
-- TOC entry 4976 (class 0 OID 41857)
-- Dependencies: 226
-- Data for Name: material; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.material VALUES (1, 'Глина', 1, 1, 1570, 5500, 30, 15.29);
INSERT INTO public.material VALUES (2, 'Каолин', 1, 1, 1030, 3500, 25, 18.20);
INSERT INTO public.material VALUES (3, 'Гидрослюда', 1, 1, 2147, 3500, 25, 17.20);
INSERT INTO public.material VALUES (4, 'Монтмориллонит', 1, 1, 3000, 3000, 30, 17.67);
INSERT INTO public.material VALUES (5, 'Перлит', 2, 2, 150, 1000, 50, 13.99);
INSERT INTO public.material VALUES (6, 'Стекло', 2, 1, 3000, 1500, 500, 2.40);
INSERT INTO public.material VALUES (7, 'Дегидратированная глина', 2, 1, 3000, 2500, 20, 21.95);
INSERT INTO public.material VALUES (8, 'Шамот', 2, 1, 2300, 1960, 20, 27.50);
INSERT INTO public.material VALUES (9, 'Техническая сода', 3, 1, 1200, 1500, 25, 54.55);
INSERT INTO public.material VALUES (10, 'Жидкое стекло', 3, 1, 500, 1500, 15, 76.59);
INSERT INTO public.material VALUES (11, 'Кварц', 4, 1, 1500, 2500, 10, 375.96);
INSERT INTO public.material VALUES (12, 'Полевой шпат', 4, 1, 750, 1500, 100, 15.99);
INSERT INTO public.material VALUES (13, 'Краска-раствор', 5, 2, 1496, 2500, 5, 200.90);
INSERT INTO public.material VALUES (14, 'Порошок цветной', 5, 1, 511, 1750, 25, 84.39);
INSERT INTO public.material VALUES (15, 'Кварцевый песок', 2, 1, 3000, 1600, 50, 4.29);
INSERT INTO public.material VALUES (16, 'Жильный кварц', 2, 1, 2556, 1600, 25, 18.60);
INSERT INTO public.material VALUES (17, 'Барий углекислый', 4, 1, 340, 1500, 25, 303.64);
INSERT INTO public.material VALUES (18, 'Бура техническая', 4, 1, 165, 1300, 25, 125.99);
INSERT INTO public.material VALUES (19, 'Углещелочной реагент', 3, 1, 450, 1100, 25, 3.45);
INSERT INTO public.material VALUES (20, 'Пирофосфат натрия', 3, 1, 356, 1200, 25, 700.99);


--
-- TOC entry 4972 (class 0 OID 41839)
-- Dependencies: 222
-- Data for Name: suppliertype; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.suppliertype VALUES (1, 'ЗАО');
INSERT INTO public.suppliertype VALUES (2, 'ООО');
INSERT INTO public.suppliertype VALUES (3, 'ПАО');
INSERT INTO public.suppliertype VALUES (4, 'ОАО');


--
-- TOC entry 4978 (class 0 OID 41876)
-- Dependencies: 228
-- Data for Name: supplier; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.supplier VALUES (1, 'БрянскСтройРесурс', 1, '9432455179', 8, '2015-12-20');
INSERT INTO public.supplier VALUES (2, 'Стройкомплект', 1, '7803888520', 7, '2017-09-13');
INSERT INTO public.supplier VALUES (3, 'Железногорская руда', 2, '8430391035', 7, '2016-12-23');
INSERT INTO public.supplier VALUES (4, 'Белая гора', 2, '4318170454', 8, '2019-05-27');
INSERT INTO public.supplier VALUES (5, 'Тульский обрабатывающий завод', 2, '7687851800', 7, '2015-06-16');
INSERT INTO public.supplier VALUES (6, 'ГорТехРазработка', 3, '6119144874', 9, '2021-12-27');
INSERT INTO public.supplier VALUES (7, 'Сапфир', 4, '1122170258', 3, '2022-04-10');
INSERT INTO public.supplier VALUES (8, 'ХимБытСервис', 3, '8355114917', 5, '2022-03-13');
INSERT INTO public.supplier VALUES (9, 'ВоронежРудоКомбинат', 4, '3532367439', 8, '2023-11-11');
INSERT INTO public.supplier VALUES (10, 'Смоленский добывающий комбинат', 4, '2362431140', 3, '2018-11-23');
INSERT INTO public.supplier VALUES (11, 'МосКарьер', 3, '4159215346', 2, '2012-07-07');
INSERT INTO public.supplier VALUES (12, 'КурскРесурс', 1, '9032455179', 4, '2021-07-23');
INSERT INTO public.supplier VALUES (13, 'Нижегородская разработка', 4, '3776671267', 9, '2016-05-23');
INSERT INTO public.supplier VALUES (14, 'Речная долина', 4, '7447864518', 8, '2015-06-25');
INSERT INTO public.supplier VALUES (15, 'Карелия добыча', 3, '9037040523', 6, '2017-03-09');
INSERT INTO public.supplier VALUES (16, 'Московский ХимЗавод', 3, '6221520857', 4, '2015-05-07');
INSERT INTO public.supplier VALUES (17, 'Горная компания', 1, '2262431140', 3, '2020-12-22');
INSERT INTO public.supplier VALUES (18, 'Минерал Ресурс', 2, '4155215346', 7, '2015-05-22');
INSERT INTO public.supplier VALUES (19, 'Арсенал', 1, '3961234561', 5, '2010-11-25');
INSERT INTO public.supplier VALUES (20, 'КамчаткаСтройМинералы', 1, '9600275878', 7, '2016-12-20');


--
-- TOC entry 4981 (class 0 OID 41907)
-- Dependencies: 231
-- Data for Name: materialsupplier; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.materialsupplier VALUES (2, 3);
INSERT INTO public.materialsupplier VALUES (6, 9);
INSERT INTO public.materialsupplier VALUES (15, 1);
INSERT INTO public.materialsupplier VALUES (5, 6);
INSERT INTO public.materialsupplier VALUES (1, 4);
INSERT INTO public.materialsupplier VALUES (15, 20);
INSERT INTO public.materialsupplier VALUES (7, 9);
INSERT INTO public.materialsupplier VALUES (12, 4);
INSERT INTO public.materialsupplier VALUES (1, 19);
INSERT INTO public.materialsupplier VALUES (14, 19);
INSERT INTO public.materialsupplier VALUES (10, 17);
INSERT INTO public.materialsupplier VALUES (12, 9);
INSERT INTO public.materialsupplier VALUES (3, 9);
INSERT INTO public.materialsupplier VALUES (12, 12);
INSERT INTO public.materialsupplier VALUES (4, 9);
INSERT INTO public.materialsupplier VALUES (4, 11);
INSERT INTO public.materialsupplier VALUES (17, 17);
INSERT INTO public.materialsupplier VALUES (10, 12);
INSERT INTO public.materialsupplier VALUES (8, 17);
INSERT INTO public.materialsupplier VALUES (5, 3);
INSERT INTO public.materialsupplier VALUES (8, 9);
INSERT INTO public.materialsupplier VALUES (17, 19);
INSERT INTO public.materialsupplier VALUES (9, 20);
INSERT INTO public.materialsupplier VALUES (18, 20);
INSERT INTO public.materialsupplier VALUES (20, 18);
INSERT INTO public.materialsupplier VALUES (3, 20);
INSERT INTO public.materialsupplier VALUES (16, 4);
INSERT INTO public.materialsupplier VALUES (5, 10);
INSERT INTO public.materialsupplier VALUES (4, 4);
INSERT INTO public.materialsupplier VALUES (13, 12);
INSERT INTO public.materialsupplier VALUES (6, 7);
INSERT INTO public.materialsupplier VALUES (14, 12);
INSERT INTO public.materialsupplier VALUES (2, 1);
INSERT INTO public.materialsupplier VALUES (10, 18);
INSERT INTO public.materialsupplier VALUES (18, 7);
INSERT INTO public.materialsupplier VALUES (7, 11);
INSERT INTO public.materialsupplier VALUES (18, 13);
INSERT INTO public.materialsupplier VALUES (4, 3);
INSERT INTO public.materialsupplier VALUES (10, 16);
INSERT INTO public.materialsupplier VALUES (14, 16);
INSERT INTO public.materialsupplier VALUES (19, 8);
INSERT INTO public.materialsupplier VALUES (16, 16);
INSERT INTO public.materialsupplier VALUES (11, 14);
INSERT INTO public.materialsupplier VALUES (13, 13);
INSERT INTO public.materialsupplier VALUES (11, 16);
INSERT INTO public.materialsupplier VALUES (7, 13);
INSERT INTO public.materialsupplier VALUES (15, 14);
INSERT INTO public.materialsupplier VALUES (17, 7);
INSERT INTO public.materialsupplier VALUES (8, 2);
INSERT INTO public.materialsupplier VALUES (7, 7);
INSERT INTO public.materialsupplier VALUES (3, 5);
INSERT INTO public.materialsupplier VALUES (20, 7);
INSERT INTO public.materialsupplier VALUES (5, 5);
INSERT INTO public.materialsupplier VALUES (9, 7);
INSERT INTO public.materialsupplier VALUES (1, 10);
INSERT INTO public.materialsupplier VALUES (9, 16);
INSERT INTO public.materialsupplier VALUES (4, 10);
INSERT INTO public.materialsupplier VALUES (19, 12);
INSERT INTO public.materialsupplier VALUES (9, 8);
INSERT INTO public.materialsupplier VALUES (18, 2);
INSERT INTO public.materialsupplier VALUES (20, 5);
INSERT INTO public.materialsupplier VALUES (16, 10);
INSERT INTO public.materialsupplier VALUES (6, 2);
INSERT INTO public.materialsupplier VALUES (17, 5);
INSERT INTO public.materialsupplier VALUES (20, 8);
INSERT INTO public.materialsupplier VALUES (2, 5);
INSERT INTO public.materialsupplier VALUES (8, 11);
INSERT INTO public.materialsupplier VALUES (19, 5);
INSERT INTO public.materialsupplier VALUES (12, 8);
INSERT INTO public.materialsupplier VALUES (13, 10);


--
-- TOC entry 4974 (class 0 OID 41848)
-- Dependencies: 224
-- Data for Name: producttype; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.producttype VALUES (1, 'Тип продукции 1', 1.20);
INSERT INTO public.producttype VALUES (2, 'Тип продукции 2', 8.59);
INSERT INTO public.producttype VALUES (3, 'Тип продукции 3', 3.45);
INSERT INTO public.producttype VALUES (4, 'Тип продукции 4', 5.60);


--
-- TOC entry 4980 (class 0 OID 41892)
-- Dependencies: 230
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.product VALUES (1, 'P001', 'Обои "Летний сад"', 1, 150.00, 10.00);
INSERT INTO public.product VALUES (2, 'P002', 'Обои "Лофт"', 2, 250.50, 15.00);
INSERT INTO public.product VALUES (3, 'P003', 'Обои "Прованс"', 3, 180.75, 5.00);


--
-- TOC entry 4982 (class 0 OID 41922)
-- Dependencies: 232
-- Data for Name: productmaterial; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.productmaterial VALUES (1, 1, 10);
INSERT INTO public.productmaterial VALUES (1, 13, 2);
INSERT INTO public.productmaterial VALUES (2, 7, 15);
INSERT INTO public.productmaterial VALUES (2, 15, 5);


--
-- TOC entry 4988 (class 0 OID 0)
-- Dependencies: 225
-- Name: material_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.material_id_seq', 20, true);


--
-- TOC entry 4989 (class 0 OID 0)
-- Dependencies: 219
-- Name: materialtype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.materialtype_id_seq', 5, true);


--
-- TOC entry 4990 (class 0 OID 0)
-- Dependencies: 229
-- Name: product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_id_seq', 3, true);


--
-- TOC entry 4991 (class 0 OID 0)
-- Dependencies: 223
-- Name: producttype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.producttype_id_seq', 4, true);


--
-- TOC entry 4992 (class 0 OID 0)
-- Dependencies: 227
-- Name: supplier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.supplier_id_seq', 20, true);


--
-- TOC entry 4993 (class 0 OID 0)
-- Dependencies: 221
-- Name: suppliertype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.suppliertype_id_seq', 4, true);


--
-- TOC entry 4994 (class 0 OID 0)
-- Dependencies: 217
-- Name: unit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.unit_id_seq', 3, true);


-- Completed on 2025-10-23 14:34:29

--
-- PostgreSQL database dump complete
--

\unrestrict mYTiABwkTKx5tL0ipNNFHVGZccYTO0gIZWTdgHc4T7CTaECMkLLUPUIXIBYfR70

