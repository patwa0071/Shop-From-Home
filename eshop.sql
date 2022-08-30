-- Table: public.cart

-- DROP TABLE IF EXISTS public.cart;

CREATE TABLE IF NOT EXISTS public.cart
(
    user_id bigint NOT NULL,
    CONSTRAINT cart_pkey1 PRIMARY KEY (user_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.cart
    OWNER to postgres;
	
----------------------------------------------------

-- Table: public.discount

-- DROP TABLE IF EXISTS public.discount;

CREATE TABLE IF NOT EXISTS public.discount
(
    id character varying COLLATE pg_catalog."default" NOT NULL,
    status bigint,
    CONSTRAINT discount_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.discount
    OWNER to postgres;
	
------------------------------------------------------

-- Table: public.order_main

-- DROP TABLE IF EXISTS public.order_main;

CREATE TABLE IF NOT EXISTS public.order_main
(
    order_id bigint NOT NULL,
    buyer_address character varying(255) COLLATE pg_catalog."default",
    buyer_email character varying(255) COLLATE pg_catalog."default",
    buyer_name character varying(255) COLLATE pg_catalog."default",
    buyer_phone character varying(255) COLLATE pg_catalog."default",
    create_time timestamp without time zone,
    order_amount numeric(19,2) NOT NULL,
    order_status integer NOT NULL DEFAULT 0,
    update_time timestamp without time zone,
    CONSTRAINT order_main_pkey PRIMARY KEY (order_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.order_main
    OWNER to postgres;
	
------------------------------------------------------

-- Table: public.product_category

-- DROP TABLE IF EXISTS public.product_category;

CREATE TABLE IF NOT EXISTS public.product_category
(
    category_id integer NOT NULL,
    category_name character varying(255) COLLATE pg_catalog."default",
    category_type integer,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    CONSTRAINT product_category_pkey PRIMARY KEY (category_id),
    CONSTRAINT uk_6kq6iveuim6wd90cxo5bksumw UNIQUE (category_type)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_category
    OWNER to postgres;
	
--------------------------------------------------------

-- Table: public.product_in_order

-- DROP TABLE IF EXISTS public.product_in_order;

CREATE TABLE IF NOT EXISTS public.product_in_order
(
    id bigint NOT NULL,
    category_type integer NOT NULL,
    count integer,
    product_description character varying(255) COLLATE pg_catalog."default" NOT NULL,
    product_icon character varying(255) COLLATE pg_catalog."default",
    product_id character varying(255) COLLATE pg_catalog."default",
    product_name character varying(255) COLLATE pg_catalog."default",
    product_price numeric(19,2) NOT NULL,
    product_stock integer,
    cart_user_id bigint,
    order_id bigint,
    CONSTRAINT product_in_order_pkey PRIMARY KEY (id),
    CONSTRAINT fkt0sfj3ffasrift1c4lv3ra85e FOREIGN KEY (order_id)
        REFERENCES public.order_main (order_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT product_cart_fkey FOREIGN KEY (cart_user_id)
        REFERENCES public.cart (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT product_in_order_count_check CHECK (count >= 1),
    CONSTRAINT product_in_order_product_stock_check CHECK (product_stock >= 0)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_in_order
    OWNER to postgres;
	
------------------------------------------------------------

-- Table: public.product_info

-- DROP TABLE IF EXISTS public.product_info;

CREATE TABLE IF NOT EXISTS public.product_info
(
    product_id character varying(255) COLLATE pg_catalog."default" NOT NULL,
    category_type integer DEFAULT 0,
    create_time timestamp without time zone,
    product_description character varying(255) COLLATE pg_catalog."default",
    product_icon character varying(255) COLLATE pg_catalog."default",
    product_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    product_price numeric(19,2) NOT NULL,
    product_status integer DEFAULT 0,
    product_stock integer NOT NULL,
    update_time timestamp without time zone,
    CONSTRAINT product_info_pkey PRIMARY KEY (product_id),
    CONSTRAINT product_info_product_stock_check CHECK (product_stock >= 0)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_info
    OWNER to postgres;
	
-----------------------------------------------------------------

-- Table: public.tokens



ALTER TABLE IF EXISTS public.tokens
    OWNER to postgres;
	
--------------------------------------------------------------------------

-- Table: public.users

-- DROP TABLE IF EXISTS public.users;

CREATE TABLE IF NOT EXISTS public.users
(
    id bigint NOT NULL,
    active boolean NOT NULL,
    address character varying(255) COLLATE pg_catalog."default",
    email character varying(255) COLLATE pg_catalog."default",
    name character varying(255) COLLATE pg_catalog."default",
    password character varying(255) COLLATE pg_catalog."default",
    phone character varying(255) COLLATE pg_catalog."default",
    role character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT users_pkey PRIMARY KEY (id),
    CONSTRAINT uk_sx468g52bpetvlad2j9y0lptc UNIQUE (email)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.users
    OWNER to postgres;
	
---------------------------------------------------------------------------

-- Table: public.wishlist

-- DROP TABLE IF EXISTS public.wishlist;

CREATE TABLE IF NOT EXISTS public.wishlist
(
    id bigint NOT NULL,
    created_date timestamp without time zone,
    user_id bigint,
    product_id character varying COLLATE pg_catalog."default",
    CONSTRAINT wishlist_pkey PRIMARY KEY (id),
    CONSTRAINT product_wish_fkey FOREIGN KEY (product_id)
        REFERENCES public.product_info (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "user_wish_Fkey" FOREIGN KEY (user_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.wishlist
    OWNER to postgres;
	
---------------------------------------------------------------------------------------------------






--Product_Info


INSERT INTO "public"."product_category" VALUES (2147483641, 'Home', 0, '2022-07-07 23:03:26', '2022-07-07 23:03:26');
INSERT INTO "public"."product_category" VALUES (2147483642, 'Groceries', 1, '2022-07-07 23:03:26', '2022-07-07 23:03:26');
INSERT INTO "public"."product_category" VALUES (2147483643, 'Lightings', 2, '2022-07-07 23:03:26', '2022-07-07 23:03:26');
INSERT INTO "public"."product_category" VALUES (2147483644, 'Interiors', 3, '2022-07-07 23:03:26', '2022-07-07 23:03:26');


--Product


INSERT INTO "public"."product_info" VALUES ('IF001', 0, '2022-07-07 23:03:26', '', 'https://m.media-amazon.com/images/I/719t6YQh9WL._SX679_.jpg', 'Space Gingko Leaf', 50.00, 0, 22, '2022-07-07 23:03:26');
INSERT INTO "public"."product_info" VALUES ('IF002', 0, '2022-07-07 23:03:26', 'Feng Shui Items for Positive Energy', 'https://m.media-amazon.com/images/I/91qV1v1Vh5S._SX679_.jpg', 'Seven Chakra Crystal Tree', 65.00, 0, 60, '2022-07-07 23:03:26');
INSERT INTO "public"."product_info" VALUES ('IF003', 0, '2022-07-07 23:03:26', 'Statue Showpiece for Home Decor Diwali Decoration and Gifting', 'https://m.media-amazon.com/images/I/91FwdCVfcJL._SX679_.jpg', 'Polyresin Sitting Buddha Idol', 45.00, 0, 40, '2022-07-07 23:03:26');

INSERT INTO "public"."product_info" VALUES ('WS001', 1, '2022-07-07 23:03:26', 'Handmade Hand-Painted Wall Hanging', 'https://m.media-amazon.com/images/I/614huT-aHoL._UX679_.jpg', 'Hanging Fish for Room Decoration', 53.00, 0, 22, '2022-07-07 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS002', 1, '2022-07-07 23:03:26', 'Multi Color Wall Arts for Home', 'https://m.media-amazon.com/images/I/71VP2phVneL._SX679_.jpg', 'Metal Wall Decor Wall Hanging', 85.00, 0, 10, '2022-07-07 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS003', 1, '2022-07-07 23:03:26', 'Metal Lord Ganesha in Red Dhoti on Green Leaf Wall Hanging', 'https://m.media-amazon.com/images/I/71aXRJA2gEL._SX522_.jpg', 'Metal Lord Ganesha', 45.00, 0, 50, '2022-07-07 23:03:26');


INSERT INTO "public"."product_info" VALUES ('PA001', 2, '2022-07-07 23:03:26', '18 WATT ROUND LED SURFACE MOUNTED PANEL CEILING LIGHT - WARM WHITE', 'https://cdn.shopify.com/s/files/1/0536/0651/4852/products/fandom-lights-panel-light-18-watt-round-led-surface-mounted-panel-ceiling-light-warm-white-28117465890980_1024x1024@2x.jpg?v=1654296075', 'Led Surface Mounted Panel Ceiling Light 18W ', 199.00, 0, 45, '2022-07-07 23:03:26');
INSERT INTO "public"."product_info" VALUES ('PA002', 2, '2022-07-07 23:03:26', 'Light body material: iron, shade Material: glass
capacity: maximum 40W{not included}, voltage: 111-220V, irradiation area: 5 ㎡-10 ㎡.
high-quality iron materials, high temperature paint, multi-channel', 'https://cdn.shopify.com/s/files/1/0536/0651/4852/products/1_b86479e7-e0ae-499e-a3fa-3dbc1ed153ec_1024x1024@2x.jpg?v=1657631157', '500MM GOLD LONG WALL LIGHT METAL - GOLD WARM WHITE', 57.00, 0, 53, '2022-07-07 23:03:26');
INSERT INTO "public"."product_info" VALUES ('PA003', 2, '2022-07-07 23:03:26', 'Requires 2 E-14 Bulbs (Not Included) Design: Post-modern creative design wall-mounted fixture, gold metal tube & transparent crystal tube combination wall lamp, to meet the auxiliary lighting needs of your room.', 'https://cdn.shopify.com/s/files/1/0536/0651/4852/products/1_06c40a85-a442-4a7b-9dce-023ca19be8ab_1024x1024@2x.jpg?v=1657631038', '32W 500MM LED TUBE GLASS CRYSTAL GOLD METAL WALL LIGHT - WARM WHITE ', 95.00, 0, 70, '2022-07-07 23:03:26');


INSERT INTO "public"."product_info" VALUES ('AF001', 3, '2022-07-07 23:03:26', 'unique flower- Fresh Flowers Bouquet Arrangement Indoor Plant-orchid bouquet', 'https://images-eu.ssl-images-amazon.com/images/I/51pGF656WoL._SX300_SY300_QL70_FMwebp_.jpg', 'Fresh Flowers Bouquet  ', 90.00, 0, 39, '2022-07-07 23:03:26');
INSERT INTO "public"."product_info" VALUES ('AF002', 3, '2022-07-07 23:03:26', 'Blooming Floret Artificial Cherry Orchid Flower Bunch', 'https://m.media-amazon.com/images/I/81MCELCKR4L._SY879_.jpg', 'Artificial Cherry Orchid Flower', 76.00, 0, 75, '2022-07-07 23:03:26');
INSERT INTO "public"."product_info" VALUES ('AF003', 3, '2022-07-07 23:03:26', 'Diwali Wedding Party Garden Craft Wall Home Door Decoration Theme', 'https://m.media-amazon.com/images/I/715VQFzLwRL._SX679_.jpg', 'Artificial Marigold Flower ', 82.00, 0, 20, '2022-07-07 23:03:26');
INSERT INTO "public"."product_info" VALUES ('AF004', 3, '2022-07-07 23:03:26', 'Diwali Wedding Party Garden Craft Wall Home Door Decoration Theme', 'https://m.media-amazon.com/images/I/51AqdNJeGfL._SY879_.jpg', 'Luggage Bag ', 82.00, 0, 20, '2022-07-07 23:03:26');



------------------------------------------------------------------------------------------------------------------------

--Users

INSERT INTO "public"."users" VALUES (2147483645, true, 'Plot 2, Shivaji Nagar, Benagluru', 'admin@eshop.com', 'Admin', '$2a$10$LiBwO43TpKU0sZgCxNkWJueq2lqxoUBsX2Wclzk8JQ3Ejb9MWu2Xy', '1234567890', 'ROLE_MANAGER');
