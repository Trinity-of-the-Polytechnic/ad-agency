
CREATE TABLE Employee
(
  last_name Text NOT NULL,
  name Text NOT NULL,
  patronymic Text,
  id_employee Bigint NOT NULL,
  birthday Date,
  id_post Bigint NOT NULL
)
WITH (
  autovacuum_enabled=true)
;

CREATE INDEX IX_Relationship2 ON Employee (id_post)
;

ALTER TABLE Employee ADD CONSTRAINT Unique_Identifier2 PRIMARY KEY (id_employee)
;

-- Table Client

CREATE TABLE Client
(
  last_name Text NOT NULL,
  name Text NOT NULL,
  patronymic Text,
  id_client Bigint NOT NULL,
  phone Text,
  email Text,
  id_company Bigint NOT NULL
)
WITH (
  autovacuum_enabled=true)
;

CREATE INDEX IX_Relationship3 ON Client (id_company)
;

ALTER TABLE Client ADD CONSTRAINT Unique_Identifier3 PRIMARY KEY (id_client)
;

-- Table post

CREATE TABLE post
(
  id_post Bigint NOT NULL,
  title Text NOT NULL
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE post ADD CONSTRAINT Unique_Identifier4 PRIMARY KEY (id_post)
;

-- Table Company

CREATE TABLE Company
(
  id_company Bigint NOT NULL,
  title_company Text NOT NULL,
  address Text,
  ogrn Text,
  inn Text,
  bank_details Text,
  telephone Text
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE Company ADD CONSTRAINT Unique_Identifier5 PRIMARY KEY (id_company)
;

-- Table document

CREATE TABLE document
(
  id_document Bigint NOT NULL,
  number Text NOT NULL,
  date_of_creation Text,
  id_type_of_doc Bigint NOT NULL,
  id_project Bigint,
  id_employee Bigint,
  id_order Bigint
)
WITH (
  autovacuum_enabled=true)
;

CREATE INDEX IX_Relationship7 ON document (id_type_of_doc)
;

CREATE INDEX IX_Relationship19 ON document (id_project)
;

CREATE INDEX IX_Relationship21 ON document (id_employee)
;

CREATE INDEX IX_Relationship29 ON document (id_order)
;

ALTER TABLE document ADD CONSTRAINT Unique_Identifier9 PRIMARY KEY (id_document)
;

-- Table order

CREATE TABLE order
(
  id_order Bigint NOT NULL,
  project_description Text NOT NULL,
  id_client Bigint NOT NULL,
  id_employee Bigint NOT NULL
)
WITH (
  autovacuum_enabled=true)
;

CREATE INDEX IX_Relationship5 ON order (id_client)
;

CREATE INDEX IX_Relationship26 ON order (id_employee)
;

ALTER TABLE order ADD CONSTRAINT Unique_Identifier12 PRIMARY KEY (id_order)
;

-- Table type_of_doc

CREATE TABLE type_of_doc
(
  id_type_of_doc Bigint NOT NULL,
  title_of_type Text NOT NULL
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE type_of_doc ADD CONSTRAINT Unique_Identifier13 PRIMARY KEY (id_type_of_doc)
;

-- Table project

CREATE TABLE project
(
  id_project Bigint NOT NULL,
  technical_specification Text,
  id_order Bigint NOT NULL,
  id_employee Bigint NOT NULL,
  id_employee Bigint NOT NULL
)
WITH (
  autovacuum_enabled=true)
;

CREATE INDEX IX_Relationship10 ON project (id_order)
;

CREATE INDEX IX_Relationship27 ON project (id_employee)
;

CREATE INDEX IX_Relationship28 ON project (id_employee)
;

ALTER TABLE project ADD CONSTRAINT Unique_Identifier14 PRIMARY KEY (id_project)
;

-- Table task

CREATE TABLE task
(
  id_task Bigint NOT NULL,
  description Text NOT NULL,
  deadline Text,
  id_priority Bigint NOT NULL,
  id_status Bigint NOT NULL,
  id_project Bigint NOT NULL
)
WITH (
  autovacuum_enabled=true)
;

CREATE INDEX IX_Relationship13 ON task (id_priority)
;

CREATE INDEX IX_Relationship14 ON task (id_status)
;

CREATE INDEX IX_Relationship18 ON task (id_project)
;

ALTER TABLE task ADD CONSTRAINT Unique_Identifier15 PRIMARY KEY (id_task)
;

-- Table priority

CREATE TABLE priority
(
  id_priority Bigint NOT NULL,
  level Text NOT NULL
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE priority ADD CONSTRAINT Unique_Identifier16 PRIMARY KEY (id_priority)
;

-- Table status

CREATE TABLE status
(
  id_status Bigint NOT NULL,
  title Text NOT NULL
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE status ADD CONSTRAINT Unique_Identifier17 PRIMARY KEY (id_status)
;

-- Table task_employee

CREATE TABLE task_employee
(
  id_task_employee Bigint NOT NULL,
  id_task Bigint NOT NULL,
  id_employee Bigint NOT NULL
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE task_employee ADD CONSTRAINT Unique_Identifier18 PRIMARY KEY (id_task_employee,id_task,id_employee)
;

-- Table task_document

CREATE TABLE task_document
(
  id_document Bigint NOT NULL,
  id_task Bigint NOT NULL
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE task_document ADD CONSTRAINT PK_task_document PRIMARY KEY (id_document,id_task)
;

-- Create foreign keys (relationships) section -------------------------------------------------

ALTER TABLE Employee
  ADD CONSTRAINT Relationship2
    FOREIGN KEY (id_post)
    REFERENCES post (id_post)
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE Client
  ADD CONSTRAINT Relationship3
    FOREIGN KEY (id_company)
    REFERENCES Company (id_company)
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE order
  ADD CONSTRAINT Relationship5
    FOREIGN KEY (id_client)
    REFERENCES Client (id_client)
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE document
  ADD CONSTRAINT Relationship7
    FOREIGN KEY (id_type_of_doc)
    REFERENCES type_of_doc (id_type_of_doc)
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE project
  ADD CONSTRAINT Relationship10
    FOREIGN KEY (id_order)
    REFERENCES order (id_order)
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE task
  ADD CONSTRAINT Relationship13
    FOREIGN KEY (id_priority)
    REFERENCES priority (id_priority)
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE task
  ADD CONSTRAINT Relationship14
    FOREIGN KEY (id_status)
    REFERENCES status (id_status)
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE task_employee
  ADD CONSTRAINT Relationship16
    FOREIGN KEY (id_task)
    REFERENCES task (id_task)
      ON DELETE CASCADE
      ON UPDATE RESTRICT
;

ALTER TABLE task_employee
  ADD CONSTRAINT Relationship17
    FOREIGN KEY (id_employee)
    REFERENCES Employee (id_employee)
      ON DELETE CASCADE
      ON UPDATE RESTRICT
;

ALTER TABLE task
  ADD CONSTRAINT Relationship18
    FOREIGN KEY (id_project)
    REFERENCES project (id_project)
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE document
  ADD CONSTRAINT Relationship19
    FOREIGN KEY (id_project)
    REFERENCES project (id_project)
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE document
  ADD CONSTRAINT Relationship21
    FOREIGN KEY (id_employee)
    REFERENCES Employee (id_employee)
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE order
  ADD CONSTRAINT Relationship26
    FOREIGN KEY (id_employee)
    REFERENCES Employee (id_employee)
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE project
  ADD CONSTRAINT Relationship27
    FOREIGN KEY (id_employee)
    REFERENCES Employee (id_employee)
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE project
  ADD CONSTRAINT Relationship28
    FOREIGN KEY (id_employee)
    REFERENCES Employee (id_employee)
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE document
  ADD CONSTRAINT Relationship29
    FOREIGN KEY (id_order)
    REFERENCES order (id_order)
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE task_document
  ADD CONSTRAINT Relationship31
    FOREIGN KEY (id_document)
    REFERENCES document (id_document)
      ON DELETE CASCADE
      ON UPDATE RESTRICT
;

ALTER TABLE task_document
  ADD CONSTRAINT Relationship32
    FOREIGN KEY (id_task)
    REFERENCES task (id_task)
      ON DELETE CASCADE
      ON UPDATE RESTRICT
;
