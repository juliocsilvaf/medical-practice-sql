# 🏥 Medical Practice Database – SQL Project

Academic project developed as part of the **Certificate IV in Information Technology (Programming)** at **TAFE NSW** (Sydney, Australia).

A complete SQL project covering database querying, views, stored procedures, triggers and data encryption applied to a Medical Practice Management System.

---

## 📋 Project Overview

Design and implementation of a relational database for a Medical Practice Management System, including data modelling, SQL querying, views, stored procedures, triggers and encryption.

**Units assessed:**
- ICTDBS416 – Create Basic Relational Databases
- ICTPRG431 – Apply Query Language in Relational Databases

---

## 🗄️ Database Structure

The database (`MedicalPractice`) contains the following entities:

- **Patient** – personal details, Medicare number, date of birth, address
- **Practitioner** – GPs, nurses, physiotherapists, etc. — AHPRA registration and availability
- **Appointment** – bookings between patients and practitioners (date, time, 15-min increments)
- **Availability** – days of the week each practitioner is scheduled to work

---

## 📁 Files

| File | Assessment | Description |
|------|------------|-------------|
| `Medicare.sql` | Assessment 2 of 3 | SQL queries (Q1–Q12) — SELECT, JOINs, aggregations, subqueries |
| `Medical_practice_database_.sql` | Assessment 3 of 3 | Views, stored procedures, triggers, encryption |

---

## 🔍 Assessment 2 – Queries (Medicare.sql)

| # | Description | Concepts |
|---|-------------|----------|
| Q1 | Female patients in St Kilda or Lidcombe | WHERE, AND, OR |
| Q2 | Patients outside NSW with Medicare number | WHERE NOT |
| Q3 | Patients sorted by date of birth (youngest first) | ORDER BY DESC |
| Q4 | Working days and hours per practitioner per week | INNER JOIN, COUNT, GROUP BY |
| Q5 | Appointments by Dr Anne Funsworth on a specific date | INNER JOIN, Subquery |
| Q6 | Patients with no appointments born before 1950 | LEFT OUTER JOIN, IS NULL, YEAR() |
| Q7 | Patients with 3+ appointments ordered by count | GROUP BY, HAVING, ORDER BY |
| Q8 | Days since last appointment per patient | DATEDIFF, MAX, GROUP BY |
| Q9 | Formatted full name and address for each practitioner | CONCAT, UPPER, ORDER BY |
| Q10 | Fifth oldest patient | ORDER BY, OFFSET/FETCH |
| Q11 | Appointments on Tuesdays after 10:00 AM | FORMAT, LIKE, datetime filtering |
| Q12 | Combined mailing list of patients and practitioners | UNION |

---

## 🔍 Assessment 3 – Advanced SQL (Medical_practice_database_.sql)

| # | Description | Concepts |
|---|-------------|----------|
| 1 | View: nurses and their working days | CREATE VIEW, DROP VIEW IF EXISTS |
| 2 | Query nurses working on Wednesday using the view | SELECT from VIEW |
| 3 | View: all NSW patients | CREATE VIEW with WHERE filter |
| 4 | Stored procedure: retrieve NSW patients by postcode | CREATE PROCEDURE, EXECUTE |
| 5 | Stored procedure: insert new NSW patient with parameters | INSERT via stored procedure |
| 6 | Stored procedure: update practitioner mobile number | UPDATE via stored procedure |
| 7 | Add encrypted driver's licence column to Practitioner | ALTER TABLE, HASHBYTES (SHA2_512) |
| 8 | Add LastContactDate column to Patient table | ALTER TABLE, DEFAULT |
| 9 | Trigger: auto-update LastContactDate on new appointment | CREATE TRIGGER, AFTER INSERT |
| 10 | Drop view vwNurseDays | DROP VIEW IF EXISTS |
| 11 | Drop stored procedure spSelect_vwNSWPatients | DROP PROCEDURE IF EXISTS |

---

## 🛠️ Technologies & Concepts

- **SQL Server (T-SQL)**
- `SELECT`, `WHERE`, `ORDER BY`, `GROUP BY`, `HAVING`
- `INNER JOIN`, `LEFT OUTER JOIN`
- Aggregations: `COUNT`, `MAX`, `DATEDIFF`
- String/date functions: `CONCAT`, `UPPER`, `FORMAT`, `YEAR`
- `UNION`, `OFFSET/FETCH`, Subqueries
- `CREATE VIEW`, `DROP VIEW IF EXISTS`
- `CREATE PROCEDURE`, `DROP PROCEDURE IF EXISTS`, `EXECUTE`
- `CREATE TRIGGER`, `AFTER INSERT`
- `ALTER TABLE`, `HASHBYTES` (SHA2_512 encryption)

---

## 🎓 Context

Completed as Assessments 2 and 3 of 3 for the database units of the **Certificate IV in Information Technology (Programming)** at **TAFE NSW**, Sydney, Australia (2024–2025).

---

*Julio Cesar da Silva Filho | [LinkedIn](https://www.linkedin.com/in/julio-cesar-filho-84241842/)*
