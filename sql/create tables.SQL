-- Table Employee

CREATE TABLE Employee (
  id_employee Bigserial NOT NULL,
  last_name Text NOT NULL,
  name Text NOT NULL,
  patronymic Text,
  birthday Date,
  id_post Bigint NOT NULL
)
WITH (autovacuum_enabled=true);

CREATE INDEX IX_Post_to_Employee ON Employee (id_post);

ALTER TABLE Employee ADD CONSTRAINT Unique_Identifier2 PRIMARY KEY (id_employee);


-- Table Client

CREATE TABLE Client (
  id_client Bigserial NOT NULL,
  last_name Text NOT NULL,
  name Text NOT NULL,
  id_company Bigint NOT NULL,
  patronymic Text,
  phone Text,
  email Text
)
WITH (autovacuum_enabled=true);

CREATE INDEX IX_Company_to_Client ON Client (id_company);

ALTER TABLE Client ADD CONSTRAINT Unique_Identifier3 PRIMARY KEY (id_client);


-- TABLE Post

CREATE TABLE Post (
  id_post Bigserial NOT NULL,
  title Text NOT NULL UNIQUE
)
WITH (autovacuum_enabled=true);

ALTER TABLE Post ADD CONSTRAINT Unique_Identifier4 PRIMARY KEY (id_post);

-- Table Company

CREATE TABLE Company (
  id_company Bigserial NOT NULL,
  title_company Text NOT NULL,
  address Text,
  ogrn Text,
  inn Text,
  bank_details Text,
  telephone Text
)
WITH (autovacuum_enabled=true);

ALTER TABLE Company ADD CONSTRAINT Unique_Identifier5 PRIMARY KEY (id_company);


-- TABLE Document

CREATE TABLE Document (
  id_document Bigserial NOT NULL,
  number Text NOT NULL,
  creation_date Date,
  id_doc_type Bigint NOT NULL,
  id_project Bigint,
  id_employee Bigint,
  id_order Bigint
)
WITH (autovacuum_enabled=true);

CREATE INDEX IX_Doc_Type_to_Document ON document (id_doc_type);

CREATE INDEX IX_Project_to_Document ON document (id_project);

CREATE INDEX IX_Employee_to_Document ON document (id_employee);

CREATE INDEX IX_Order_to_Document ON document (id_order);

ALTER TABLE Document ADD CONSTRAINT Unique_Identifier9 PRIMARY KEY (id_document);


-- Table Customer_Order

CREATE TABLE Customer_Order (
  id_order Bigserial NOT NULL,
  project_description Text NOT NULL,
  id_client Bigint NOT NULL,
  id_account_manager Bigint NOT NULL
)
WITH (autovacuum_enabled=true);

CREATE INDEX IX_Employee_to_Customer_Order ON Customer_Order (id_client);

CREATE INDEX IX_Employee_as_Account_Manager_to_Customer_Order ON Customer_Order (id_account_manager);

ALTER TABLE Customer_Order ADD CONSTRAINT Unique_Identifier12 PRIMARY KEY (id_order);


-- Table Doc_Type

CREATE TABLE Doc_Type (
  id_doc_type Bigserial NOT NULL,
  type_title Text NOT NULL UNIQUE
)
WITH (autovacuum_enabled=true);

ALTER TABLE Doc_Type ADD CONSTRAINT Unique_Identifier13 PRIMARY KEY (id_doc_type);


-- Table Project

CREATE TABLE Project (
  id_project Bigserial NOT NULL,
  technical_specification Text,
  id_order Bigint NOT NULL,
  id_project_manager Bigint NOT NULL,
  id_creative_director Bigint NOT NULL
)
WITH (autovacuum_enabled=true);

CREATE INDEX IX_Customer_Order_to_Project ON Project (id_order);

CREATE INDEX IX_Project_Manager_to_Project ON Project (id_project_manager);

CREATE INDEX IX_Creative_Director_to_Project ON Project (id_creative_director);

ALTER TABLE Project ADD CONSTRAINT Unique_Identifier14 PRIMARY KEY (id_project);


-- Table Task

CREATE TABLE Task (
  id_task Bigserial NOT NULL,
  description Text NOT NULL,
  deadline Date,
  id_priority Bigint NOT NULL,
  id_status Bigint NOT NULL,
  id_project Bigint NOT NULL
)
WITH (autovacuum_enabled=true);

CREATE INDEX IX_Priority_to_Task ON Task (id_priority);

CREATE INDEX IX_Status_to_Task ON Task (id_status);

CREATE INDEX IX_Project_to_Task ON Task (id_project);

ALTER TABLE Task ADD CONSTRAINT Unique_Identifier15 PRIMARY KEY (id_task);


-- Table Priority

CREATE TABLE Priority (
  id_priority Bigserial NOT NULL,
  level Smallint NOT NULL UNIQUE,
  title Text NOT NULL
)
WITH (autovacuum_enabled=true);

ALTER TABLE Priority ADD CONSTRAINT Unique_Identifier16 PRIMARY KEY (id_priority);


-- Table Status

CREATE TABLE Status (
  id_status Bigserial NOT NULL,
  title Text NOT NULL UNIQUE
)
WITH (autovacuum_enabled=true);

ALTER TABLE Status ADD CONSTRAINT Unique_Identifier17 PRIMARY KEY (id_status);


-- Table Task_Employee

CREATE TABLE Task_Employee (
  id_task_employee Bigserial NOT NULL,
  id_task Bigint NOT NULL,
  id_employee Bigint NOT NULL
)
WITH (autovacuum_enabled=true);

ALTER TABLE Task_Employee ADD CONSTRAINT Unique_Identifier18 PRIMARY KEY (id_task_employee,id_task,id_employee);


-- Table Task_Document

CREATE TABLE Task_Document (
  id_document Bigserial NOT NULL,
  id_task Bigint NOT NULL
)
WITH (autovacuum_enabled=true);

ALTER TABLE Task_Document ADD CONSTRAINT PK_task_document PRIMARY KEY (id_document,id_task);


-- Create foreign keys (relationships) section -------------------------------------------------

ALTER TABLE Employee  ADD CONSTRAINT Post_to_Employee
    FOREIGN KEY (id_post)
    REFERENCES post (id_post)
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE Client  ADD CONSTRAINT Company_to_Client
    FOREIGN KEY (id_company)
    REFERENCES Company (id_company)
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE Customer_Order  ADD CONSTRAINT Employee_to_Customer_Order
    FOREIGN KEY (id_client)
    REFERENCES Client (id_client)
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE Document  ADD CONSTRAINT Doc_Type_to_Document
    FOREIGN KEY (id_doc_type)
    REFERENCES Doc_Type (id_doc_type)
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE Project  ADD CONSTRAINT Customer_Order_to_Project
    FOREIGN KEY (id_order)
    REFERENCES Customer_Order (id_order)
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE Task  ADD CONSTRAINT Priority_to_Task
    FOREIGN KEY (id_priority)
    REFERENCES Priority (id_priority)
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE Task  ADD CONSTRAINT Status_to_Task
    FOREIGN KEY (id_status)
    REFERENCES Status (id_status)
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE Task_Employee  ADD CONSTRAINT Relationship16
    FOREIGN KEY (id_task)
    REFERENCES Task (id_task)
      ON DELETE CASCADE
      ON UPDATE RESTRICT
;

ALTER TABLE Task_Employee  ADD CONSTRAINT Relationship17
    FOREIGN KEY (id_employee)
    REFERENCES Employee (id_employee)
      ON DELETE CASCADE
      ON UPDATE RESTRICT
;

ALTER TABLE Task  ADD CONSTRAINT Project_to_Task
    FOREIGN KEY (id_project)
    REFERENCES Project (id_project)
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE Document  ADD CONSTRAINT DocProject_Document
    FOREIGN KEY (id_project)
    REFERENCES Project (id_project)
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE Document  ADD CONSTRAINT Employee_to_Document
    FOREIGN KEY (id_employee)
    REFERENCES Employee (id_employee)
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE Customer_Order  ADD CONSTRAINT Employee_as_Account_Manager_to_Customer_Order
    FOREIGN KEY (id_account_manager)
    REFERENCES Employee (id_employee)
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE Project  ADD CONSTRAINT Project_Manager_to_Project
    FOREIGN KEY (id_project_manager)
    REFERENCES Employee (id_employee)
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE Project  ADD CONSTRAINT Creative_Director_to_Project
    FOREIGN KEY (id_creative_director)
    REFERENCES Employee (id_employee)
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE Document  ADD CONSTRAINT Order_to_Document
    FOREIGN KEY (id_order)
    REFERENCES Customer_Order (id_order)
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE Task_Document  ADD CONSTRAINT Company_to_Client1
    FOREIGN KEY (id_document)
    REFERENCES document (id_document)
      ON DELETE CASCADE
      ON UPDATE RESTRICT
;

ALTER TABLE Task_Document  ADD CONSTRAINT Company_to_Client2
    FOREIGN KEY (id_task)
    REFERENCES Task (id_task)
      ON DELETE CASCADE
      ON UPDATE RESTRICT
;
