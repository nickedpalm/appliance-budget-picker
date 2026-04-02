-- Add rooms table
CREATE TABLE IF NOT EXISTS rooms (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  sort_order INTEGER DEFAULT 0
);

-- Add room and search_query to categories
ALTER TABLE categories ADD COLUMN room_id TEXT REFERENCES rooms(id);
ALTER TABLE categories ADD COLUMN search_query TEXT DEFAULT '';

-- Seed default rooms
INSERT INTO rooms (id, name, sort_order) VALUES
  ('kitchen', 'Kitchen', 0),
  ('bathroom', 'Bathroom', 1),
  ('living', 'Living Areas', 2),
  ('general', 'General / Whole Apartment', 3);

-- Assign existing categories to rooms
UPDATE categories SET room_id = 'kitchen', search_query = '29-30" counter depth french door OR bottom freezer refrigerator stainless steel OR panel ready' WHERE name = 'Refrigerator';
UPDATE categories SET room_id = 'kitchen', search_query = '24" panel ready dishwasher' WHERE name = 'Dishwasher';
UPDATE categories SET room_id = 'kitchen', search_query = '30" slide-in double oven gas range electric oven' WHERE name = 'Stove';
UPDATE categories SET room_id = 'kitchen', search_query = 'built-in microwave trim kit 24"' WHERE name = 'Microwave';
UPDATE categories SET room_id = 'kitchen', search_query = 'kitchen undermount sink stainless steel' WHERE name = 'Sink';
UPDATE categories SET room_id = 'kitchen', search_query = 'kitchen faucet pull-down sprayer' WHERE name = 'Faucet';
UPDATE categories SET room_id = 'kitchen', search_query = '30" range hood stainless steel OR panel ready' WHERE name = 'Range Hood';
UPDATE categories SET room_id = 'kitchen', search_query = 'quartz countertop kitchen' WHERE name = 'Countertops';
UPDATE categories SET room_id = 'kitchen', search_query = 'kitchen cabinets shaker style' WHERE name = 'Cabinets';
UPDATE categories SET room_id = 'kitchen', search_query = 'kitchen backsplash tile subway' WHERE name = 'Backsplash';
UPDATE categories SET room_id = 'kitchen', search_query = 'cabinet pulls handles modern' WHERE name = 'Cabinet Hardware';

UPDATE categories SET room_id = 'bathroom', search_query = 'bathroom vanity with sink' WHERE name = 'Bathroom Vanity';
UPDATE categories SET room_id = 'bathroom', search_query = 'toilet elongated bowl' WHERE name = 'Toilet';
UPDATE categories SET room_id = 'bathroom', search_query = 'bathroom faucet single hole' WHERE name = 'Bathroom Faucet';
UPDATE categories SET room_id = 'bathroom', search_query = 'bathtub shower combo' WHERE name = 'Shower/Tub';
UPDATE categories SET room_id = 'bathroom', search_query = 'bathroom floor tile' WHERE name = 'Bathroom Tile';

UPDATE categories SET room_id = 'living', search_query = 'ceiling light fixture modern' WHERE name = 'Lighting';
UPDATE categories SET room_id = 'living', search_query = 'window blinds OR shades' WHERE name = 'Window Treatments';
UPDATE categories SET room_id = 'living', search_query = 'closet organizer system' WHERE name = 'Closet System';

UPDATE categories SET room_id = 'general', search_query = 'hardwood OR engineered wood flooring' WHERE name = 'Flooring';
UPDATE categories SET room_id = 'general', search_query = 'interior wall paint' WHERE name = 'Paint';
UPDATE categories SET room_id = 'general', search_query = 'interior door pre-hung' WHERE name = 'Interior Doors';
