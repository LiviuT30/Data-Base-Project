/*cerinta 11*/

SELECT qd.questdrop_id, qd.gold, i.nume as nume_item, 
q.nume as nume_quest, npc.nume as nume_npc, oras.nume as nume_oras
FROM quest_drop as qd
JOIN item as i on qd.item_id = i.item_id
JOIN quest as q on qd.quest_id = q.quest_id
JOIN npc on q.npc_id = npc.npc_id
JOIN oras on npc.oras_id = oras.oras_id
ORDER BY nume_quest;


SELECT m.mob_id, m.nume as nume_mob,nr_dropuri, m.xp,
CASE 
	WHEN nr_dropuri > 1 THEN avg_gold
    ELSE md.gold
END as avg_gold
FROM mob_drop as md
JOIN mob as m on md.mob_id=m.mob_id
JOIN (SELECT AVG(md.gold) as avg_gold, m.mob_id
	FROM mob_drop as md
	JOIN mob as m on md.mob_id=m.mob_id
    GROUP BY m.nume ) xd on xd.mob_id=m.mob_id
JOIN (SELECT  COUNT(*) as nr_dropuri, m.mob_id
	FROM mob_drop as md
    JOIN mob as m on md.mob_id=m.mob_id
    GROUP BY m.nume ) xdd on xdd.mob_id=m.mob_id
GROUP BY m.nume;


SELECT UPPER(o.nume) as nume_oras, CONCAT(nume_item_rw,' ', gold_rw) as Rewards,
 ifnull(npc2.startdate, 'Not started') as startdate,
 ifnull(npc2.enddate, 'Not finished') as enddate
FROM oras as o
JOIN (SELECT npc.oras_id, i.nume as nume_item_rw, qd.gold 
	  as gold_rw , q.startdate, q.enddate, npc.nume
	  FROM npc
      JOIN quest as q ON npc.npc_id = q.npc_id
      JOIN quest_drop as qd ON qd.quest_id = q.quest_id
      JOIN item as i ON i.item_id = qd.item_id
      ) npc2 ON npc2.oras_id = o.oras_id;
      
      
      
SELECT mc.name, inve.nume_item, DATEDIFF(CURDATE(),DATE(mc.creation_date)) as days_old
FROM maincharacter as mc
JOIN (SELECT i.rarity, i.nume as nume_item, main_id
	  FROM inventar as inv
      JOIN inventar_continut as invc on invc.inventar_id = inv.inventar_id
      JOIN item as i on i.item_id = invc.item_id 
      WHERE i.rarity = 'legendary') inve on inve.main_id=mc.main_id;



WITH placeholder AS 
        (SELECT pet.pet_id, pet.name as nume_pet, main.name as Nume_proprietar
		FROM pet 
		JOIN ( SELECT mc.name, mc.main_id
				FROM maincharacter as mc ) main ON main.main_id = pet.main_id
		ORDER BY pet.pet_id
		)
SELECT *
FROM placeholder;

INSERT INTO placeholder(pet_id, nume_pet, Nume_proprietar)
VALUES (6, 'placeholder', 'placeholder');

/*cerinta 12*/

UPDATE inventar
SET inventar.max_capacity=10
WHERE main_id IN (SELECT main_id
				FROM maincharacter
                WHERE maincharacter.level > 10);
                
UPDATE npc
SET npc.quest_finished=1
WHERE npc_id IN (SELECT npc_id
				FROM quest
                WHERE quest.enddate!=NULL);

DELETE 
FROM quest
WHERE npc_id in (SELECT npc_id
				 FROM npc
                 WHERE npc.quest_finished=1);



/*cerinta 13*/

CREATE SEQUENCE X
START WITH 18
INCREMENT BY 1
MAXVALUE 20
NOCYCLE;

INSERT INTO proiectbd.item (item_id, nume, tip, stat_value, gold_value, rarity) 
VALUES ('X.nextval', 'placeholder', 'arma', '1', '1', 'common');
ALTER TABLE item
CHANGE COLUMN item_id item_id INT NOT NULL AUTO_INCREMENT;

/*cerinta 14*/

CREATE VIEW `DropuriRare` AS 
SELECT i.item_id as ID, i.nume as Nume, i.tip as tipul, i.stat_value as Stats, 
i.gold_value as GoldValue
FROM item as i 
JOIN mob_drop as md ON i.item_id = md.item_id
JOIN mob as m ON m.mob_id = md.mob_id
WHERE m.dmg > 100;

SELECT *
FROM DropuriRare;



CREATE OR REPLACE VIEW `DropuriRare` AS 
SELECT i.item_id as ID, i.nume as Nume, i.tip as tipul, 
i.stat_value as Stats, i.gold_value as GoldValue, m.nume as mob_name
FROM item as i 
JOIN mob_drop as md ON i.item_id = md.item_id
JOIN mob as m ON m.mob_id = md.mob_id
WHERE m.dmg > 100;

/*LMD nepermis*/
INSERT INTO DropuriRare(ID, Nume, tipul, Stats, GoldValue, mob_name)
 VALUES ('18','itemnou','arma','10000','10000', "EL"); 

/*LMD permis*/
INSERT INTO DropuriRare(ID, Nume, tipul, Stats, GoldValue) 
VALUES ('18','itemnou','arma','10000','10000'); 


/*   15    */

CREATE INDEX index_key on item(nume);

SELECT *
FROM item USE INDEX (index_key)
WHERE instr((nume),'boots') and gold_value < 50;
