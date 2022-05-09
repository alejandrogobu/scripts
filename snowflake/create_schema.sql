begin;

  -- create variables database (needs to be uppercase for objects)
  set database_name = 'FIVETRAN_ACASTILLO';

  use role SYSADMIN;

  create or replace database identifier($database_name);

  use database identifier($database_name);

  create or replace schema GOOGLE_SHEETS;

  create or replace schema HEROKU_POSTGRES_EVENTS;

  create or replace schema POSTGRES_PUBLIC;

  create or replace TABLE GOOGLE_SHEETS.BUDGET (
      _ROW NUMBER(38,0) NOT NULL,
      QUANTITY NUMBER(38,0),
      MONTH DATE,
      PRODUCT_ID VARCHAR(256),
      _FIVETRAN_SYNCED TIMESTAMP_TZ(9),
      primary key (_ROW)
  );

  create or replace TABLE HEROKU_POSTGRES_EVENTS.EVENTS (
      EVENT_ID VARCHAR(1024) NOT NULL,
      PAGE_URL VARCHAR(1024),
      EVENT_TYPE VARCHAR(100),
      USER_ID VARCHAR(1024),
      PRODUCT_ID VARCHAR(1024),
      SESSION_ID VARCHAR(1024),
      CREATED_AT TIMESTAMP_NTZ(9),
      ORDER_ID VARCHAR(1024),
      _FIVETRAN_DELETED BOOLEAN,
      _FIVETRAN_SYNCED TIMESTAMP_TZ(9),
      primary key (EVENT_ID)
  );


  create or replace TABLE POSTGRES_PUBLIC.ADDRESSES (
      ADDRESS_ID VARCHAR(256) NOT NULL,
      ZIPCODE NUMBER(38,0),
      COUNTRY VARCHAR(256),
      ADDRESS VARCHAR(256),
      STATE VARCHAR(256),
      _FIVETRAN_DELETED BOOLEAN,
      _FIVETRAN_SYNCED TIMESTAMP_TZ(9),
      primary key (ADDRESS_ID)
  );

  create or replace TABLE POSTGRES_PUBLIC.ORDERS (
      ORDER_ID VARCHAR(256) NOT NULL,
      SHIPPING_SERVICE VARCHAR(256),
      SHIPPING_COST FLOAT,
      ADDRESS_ID VARCHAR(256),
      CREATED_AT TIMESTAMP_TZ(9),
      PROMO_ID VARCHAR(256),
      ESTIMATED_DELIVERY_AT TIMESTAMP_TZ(9),
      ORDER_COST FLOAT,
      USER_ID VARCHAR(256),
      ORDER_TOTAL FLOAT,
      DELIVERED_AT TIMESTAMP_TZ(9),
      TRACKING_ID VARCHAR(256),
      STATUS VARCHAR(256),
      _FIVETRAN_DELETED BOOLEAN,
      _FIVETRAN_SYNCED TIMESTAMP_TZ(9),
      primary key (ORDER_ID)
  );

  create or replace TABLE POSTGRES_PUBLIC.ORDER_ITEMS (
      ORDER_ID VARCHAR(256) NOT NULL,
      PRODUCT_ID VARCHAR(256) NOT NULL,
      QUANTITY NUMBER(38,0),
      _FIVETRAN_DELETED BOOLEAN,
      _FIVETRAN_SYNCED TIMESTAMP_TZ(9),
      primary key (ORDER_ID, PRODUCT_ID)
  );

  create or replace TABLE POSTGRES_PUBLIC.PRODUCTS (
      PRODUCT_ID VARCHAR(256) NOT NULL,
      PRICE FLOAT,
      NAME VARCHAR(256),
      INVENTORY NUMBER(38,0),
      _FIVETRAN_DELETED BOOLEAN,
      _FIVETRAN_SYNCED TIMESTAMP_TZ(9),
      primary key (PRODUCT_ID)
  );

  create or replace TABLE POSTGRES_PUBLIC.PROMOS (
      PROMO_ID VARCHAR(256) NOT NULL,
      DISCOUNT NUMBER(38,0),
      STATUS VARCHAR(256),
      _FIVETRAN_DELETED BOOLEAN,
      _FIVETRAN_SYNCED TIMESTAMP_TZ(9),
      primary key (PROMO_ID)
  );

  create or replace TABLE POSTGRES_PUBLIC.USERS (
      USER_ID VARCHAR(256) NOT NULL,
      UPDATED_AT TIMESTAMP_TZ(9),
      ADDRESS_ID VARCHAR(256),
      LAST_NAME VARCHAR(256),
      CREATED_AT TIMESTAMP_TZ(9),
      PHONE_NUMBER VARCHAR(256),
      TOTAL_ORDERS NUMBER(38,0),
      FIRST_NAME VARCHAR(256),
      EMAIL VARCHAR(256),
      _FIVETRAN_DELETED BOOLEAN,
      _FIVETRAN_SYNCED TIMESTAMP_TZ(9),
      primary key (USER_ID)
  );

 commit;
