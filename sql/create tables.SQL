-- Table Staff_Employee

CREATE TABLE Staff_Employee (
  "id" Bigserial NOT NULL,
  "last_name" Text NOT NULL,
  "first_name" Text NOT NULL,
  "post_id" Bigint NOT NULL,
  "patronymic" Text,
  "birthdate" Date
)
WITH (autovacuum_enabled=true);

CREATE INDEX IX_Staff_Post_to_Staff_Employee ON Staff_Employee ("post_id");

ALTER TABLE Staff_Employee ADD CONSTRAINT Unique_Identifier2 PRIMARY KEY ("id");


-- Table Clients_Client

CREATE TABLE Clients_Client (
  "id" Bigserial NOT NULL,
  "last_name" Text NOT NULL,
  "first_name" Text NOT NULL,
  "company_id" Bigint NOT NULL,
  "patronymic" Text,
  "phone" Text,
  "email" Text
)
WITH (autovacuum_enabled=true);

CREATE INDEX IX_Clients_Company_to_Clients_Client ON Clients_Client ("company_id");

ALTER TABLE Clients_Client ADD CONSTRAINT Unique_Identifier3 PRIMARY KEY ("id");


-- TABLE Staff_Post

CREATE TABLE Staff_Post (
  "id" Bigserial NOT NULL,
  "name" Text NOT NULL UNIQUE
)
WITH (autovacuum_enabled=true);

ALTER TABLE Staff_Post ADD CONSTRAINT Unique_Identifier4 PRIMARY KEY ("id");

-- Table Clients_Company

CREATE TABLE Clients_Company (
  "id" Bigserial NOT NULL,
  "name" Text NOT NULL,
  "address" Text,
  "OGRN" Text,
  "INN" Text,
  "requisites" Text,
  "phone" Text
)
WITH (autovacuum_enabled=true);

ALTER TABLE Clients_Company ADD CONSTRAINT Unique_Identifier5 PRIMARY KEY ("id");


-- TABLE Documents_Document

CREATE TABLE Documents_Document (
  "id" Bigserial NOT NULL,
  "number" Text NOT NULL,
  "document_type_id" Bigint NOT NULL,
  "creation_date" Date,
  "project_id" Bigint,
  "client_order_id" Bigint,
  "responsible_id" Bigint
)
WITH (autovacuum_enabled=true);

CREATE INDEX IX_Documents_DocumentType_to_Documents_Document ON Documents_Document ("document_type_id");

CREATE INDEX IX_Projects_Project_to_Documents_Document ON Documents_Document ("project_id");

CREATE INDEX IX_Staff_Employee_to_Documents_Document ON Documents_Document ("responsible_id");

CREATE INDEX IX_Clients_Order_to_Documents_Document ON Documents_Document ("client_order_id");

ALTER TABLE Documents_Document ADD CONSTRAINT Unique_Identifier9 PRIMARY KEY ("id");


-- Table Clients_Order

CREATE TABLE Clients_Order (
  "id" Bigserial NOT NULL,
  "description" Text NOT NULL,
  "client_id" Bigint NOT NULL,
  "manager_id" Bigint NOT NULL
)
WITH (autovacuum_enabled=true);

CREATE INDEX IX_Clients_Client_to_Clients_Order ON Clients_Order ("client_id");

CREATE INDEX IX_Staff_Employee_as_Account_Manager_to_Clients_Order ON Clients_Order ("manager_id");

ALTER TABLE Clients_Order ADD CONSTRAINT Unique_Identifier12 PRIMARY KEY ("id");


-- Table Documents_DocumentType

CREATE TABLE Documents_DocumentType (
  "id" Bigserial NOT NULL,
  "type_name" Text NOT NULL UNIQUE
)
WITH (autovacuum_enabled=true);

ALTER TABLE Documents_DocumentType ADD CONSTRAINT Unique_Identifier13 PRIMARY KEY ("id");


-- Table Projects_Project

CREATE TABLE Projects_Project (
  "id" Bigserial NOT NULL,
  "client_order_id" Bigint NOT NULL,
  "project_manager_id" Bigint NOT NULL,
  "creative_director_id" Bigint NOT NULL,
  "technical_task" Text
)
WITH (autovacuum_enabled=true);

CREATE INDEX IX_Clients_Order_to_Projects_Project ON Projects_Project ("client_order_id");

CREATE INDEX IX_Staff_Employee_as_Project_Manager_to_Projects_Project ON Projects_Project ("project_manager_id");

CREATE INDEX IX_Staff_Employee_as_Creative_Director_to_Projects_Project ON Projects_Project ("creative_director_id");

ALTER TABLE Projects_Project ADD CONSTRAINT Unique_Identifier14 PRIMARY KEY ("id");


-- Table Tasks_Task

CREATE TABLE Tasks_Task (
  "id" Bigserial NOT NULL,
  "description" Text NOT NULL,
  "deadline" Date,
  "priority_id" Bigint NOT NULL,
  "status_id" Bigint NOT NULL,
  "project_id" Bigint NOT NULL
)
WITH (autovacuum_enabled=true);

CREATE INDEX IX_Tasks_Priority_to_Tasks_Task ON Tasks_Task ("priority_id");

CREATE INDEX IX_Tasks_Status_to_Tasks_Task ON Tasks_Task ("status_id");

CREATE INDEX IX_Projects_Project_to_Tasks_Task ON Tasks_Task ("project_id");

ALTER TABLE Tasks_Task ADD CONSTRAINT Unique_Identifier15 PRIMARY KEY ("id");


-- Table Tasks_Priority

CREATE TABLE Tasks_Priority (
  "id" Bigserial NOT NULL,
  "priority_level" Smallint NOT NULL UNIQUE,
  "priority_name" Text NOT NULL
)
WITH (autovacuum_enabled=true);

ALTER TABLE Tasks_Priority ADD CONSTRAINT Unique_Identifier16 PRIMARY KEY ("id");


-- Table Tasks_Status

CREATE TABLE Tasks_Status (
  "id" Bigserial NOT NULL,
  "name" Text NOT NULL UNIQUE
)
WITH (autovacuum_enabled=true);

ALTER TABLE Tasks_Status ADD CONSTRAINT Unique_Identifier17 PRIMARY KEY ("id");


-- Table Tasks_EmployeeTask

CREATE TABLE Tasks_EmployeeTask (
  "id" Bigserial NOT NULL,
  "task_id" Bigint NOT NULL,
  "employee_id" Bigint NOT NULL
)
WITH (autovacuum_enabled=true);

ALTER TABLE Tasks_EmployeeTask ADD CONSTRAINT Unique_Identifier18 PRIMARY KEY ("id","task_id","employee_id");


-- Table Tasks_ReportingTask

CREATE TABLE Tasks_ReportingTask (
  "id" Bigserial NOT NULL,
  "report_id" Bigserial NOT NULL,
  "task_id" Bigint NOT NULL
)
WITH (autovacuum_enabled=true);

ALTER TABLE Tasks_ReportingTask ADD CONSTRAINT PK_task_document PRIMARY KEY ("id","report_id","task_id");


-- Create foreign keys (relationships) section -------------------------------------------------

ALTER TABLE Staff_Employee  ADD CONSTRAINT Staff_Post_to_Staff_Employee
    FOREIGN KEY ("post_id")
    REFERENCES Staff_Post ("id")
        ON DELETE RESTRICT
        ON UPDATE RESTRICT
;

ALTER TABLE Clients_Client  ADD CONSTRAINT Clients_Company_to_Clients_Client
    FOREIGN KEY ("company_id")
    REFERENCES Clients_Company ("id")
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE Clients_Order  ADD CONSTRAINT Clients_Client_to_Clients_Order
    FOREIGN KEY ("client_id")
    REFERENCES Clients_Client ("id")
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE Documents_Document  ADD CONSTRAINT Documents_DocumentType_to_Documents_Document
    FOREIGN KEY ("document_type_id")
    REFERENCES Documents_DocumentType ("id")
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE Projects_Project  ADD CONSTRAINT Clients_Order_to_Projects_Project
    FOREIGN KEY ("client_order_id")
    REFERENCES Clients_Order ("id")
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE Tasks_Task  ADD CONSTRAINT Tasks_Priority_to_Tasks_Task
    FOREIGN KEY ("priority_id")
    REFERENCES Tasks_Priority ("id")
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE Tasks_Task  ADD CONSTRAINT Tasks_Status_to_Tasks_Task
    FOREIGN KEY ("status_id")
    REFERENCES Tasks_Status ("id")
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE Tasks_EmployeeTask  ADD CONSTRAINT Relationship16
    FOREIGN KEY ("task_id")
    REFERENCES Tasks_Task ("id")
      ON DELETE CASCADE
      ON UPDATE RESTRICT
;

ALTER TABLE Tasks_EmployeeTask  ADD CONSTRAINT Relationship17
    FOREIGN KEY ("employee_id")
    REFERENCES Staff_Employee ("id")
      ON DELETE CASCADE
      ON UPDATE RESTRICT
;

ALTER TABLE Tasks_Task  ADD CONSTRAINT Projects_Project_to_Tasks_Task
    FOREIGN KEY ("project_id")
    REFERENCES Projects_Project ("id")
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE Documents_Document  ADD CONSTRAINT DocProjects_Project_Documents_Document
    FOREIGN KEY ("project_id")
    REFERENCES Projects_Project ("id")
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE Documents_Document  ADD CONSTRAINT Staff_Employee_to_Documents_Document
    FOREIGN KEY ("responsible_id")
    REFERENCES Staff_Employee ("id")
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE Clients_Order  ADD CONSTRAINT Staff_Employee_as_Account_Manager_to_Clients_Order
    FOREIGN KEY ("manager_id")
    REFERENCES Staff_Employee ("id")
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE Projects_Project  ADD CONSTRAINT Staff_Employee_as_Project_Manager_to_Projects_Project
    FOREIGN KEY ("project_manager_id")
    REFERENCES Staff_Employee ("id")
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE Projects_Project  ADD CONSTRAINT Staff_Employee_as_Creative_Director_to_Projects_Project
    FOREIGN KEY ("creative_director_id")
    REFERENCES Staff_Employee ("id")
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE Documents_Document  ADD CONSTRAINT Clients_Order_to_Documents_Document
    FOREIGN KEY ("client_order_id")
    REFERENCES Clients_Order ("id")
      ON DELETE RESTRICT
      ON UPDATE RESTRICT
;

ALTER TABLE Tasks_ReportingTask  ADD CONSTRAINT Tasks_ReportingTask_to_Documents_Document_as_Report
    FOREIGN KEY ("report_id")
    REFERENCES Documents_Document ("id")
      ON DELETE CASCADE
      ON UPDATE RESTRICT
;

ALTER TABLE Tasks_ReportingTask  ADD CONSTRAINT Tasks_ReportingTask_to_Tasks_Task
    FOREIGN KEY ("task_id")
    REFERENCES Tasks_Task ("id")
      ON DELETE CASCADE
      ON UPDATE RESTRICT
;
