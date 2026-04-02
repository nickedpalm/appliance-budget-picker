-- Migration: Add stable UUID IDs to categories, update products + selections to reference by ID

-- Step 1: Create new categories table with UUID id as PK
CREATE TABLE categories_new (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  room_id TEXT REFERENCES rooms(id),
  search_query TEXT DEFAULT '',
  sort_order INTEGER DEFAULT 0
);

-- Step 2: Copy existing data, generating UUIDs via randomblob
INSERT INTO categories_new (id, name, room_id, search_query, sort_order)
  SELECT lower(hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-4' || substr(hex(randomblob(2)),2) || '-' || substr('89ab', abs(random()) % 4 + 1, 1) || substr(hex(randomblob(2)),2) || '-' || hex(randomblob(6))),
         name, room_id, search_query, sort_order
  FROM categories;

-- Step 3: Add category_id column to products
ALTER TABLE products ADD COLUMN category_id TEXT;

-- Step 4: Backfill products.category_id from the new categories table
UPDATE products SET category_id = (
  SELECT cn.id FROM categories_new cn WHERE cn.name = products.category
);

-- Step 5: Add category_id column to selections
ALTER TABLE selections ADD COLUMN category_id TEXT;

-- Step 6: Backfill selections.category_id
UPDATE selections SET category_id = (
  SELECT cn.id FROM categories_new cn WHERE cn.name = selections.category
);

-- Step 7: Swap categories table
DROP TABLE categories;
ALTER TABLE categories_new RENAME TO categories;

-- Step 8: Rebuild selections with category_id as PK
CREATE TABLE selections_new (
  category_id TEXT PRIMARY KEY,
  product_id TEXT,
  updated_at TEXT DEFAULT (datetime('now'))
);
INSERT INTO selections_new (category_id, product_id, updated_at)
  SELECT category_id, product_id, updated_at FROM selections WHERE category_id IS NOT NULL;
DROP TABLE selections;
ALTER TABLE selections_new RENAME TO selections;
