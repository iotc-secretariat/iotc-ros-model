UPDATE refs_biological.measurements SET code_orig = trim(code_orig);
UPDATE refs_biological.sex SET code_orig = trim(code_orig);

-- Insertion of additional species into the ROS database
INSERT INTO refs_biological.species (code, name_en, name_fr, name_scientific, species_group_code, species_category_code, family, "ORDER", iucn_status_code, is_iotc, is_target, is_ssi, is_predator, is_bait, is_aggregate, is_asfis) VALUES
('CBG', 'Driftfish', 'Dérivant', 'Cubiceps gracilis', 'OTHERS', 'OTHERS', 'Nomeidae', 'Scombriformes (stromateoidei)', NULL, 0, 0, 0, 0, 0, 0, 1),
('CUP', '', '', 'Cubiceps spp', 'OTHERS', 'OTHERS', 'Nomeidae', 'Scombriformes (stromateoidei)', NULL, 0, 0, 0, 0, 0, 1, 1),
('GLO', 'Pilot whales NEI', '', 'Globicephala spp', 'OTHERS', 'CETACEANS', 'Delphinidae', 'Cetacea (odontoceti)', NULL, 0, 0, 1, 0, 0, 1, 1),
('OHH', 'White-spotted puffer', 'Compère à taches blanches', 'Arothron hispidus', 'OTHERS', 'OTHERS', 'Tetraodontidae', 'Tetraodontiformes', NULL, 0, 0, 0, 0, 0, 0, 1); ;

CREATE OR REPLACE FUNCTION unaccent_string(text)
RETURNS text
IMMUTABLE
STRICT
LANGUAGE SQL
AS $$
SELECT translate(
    $1,
    'ÇçâãäåāăąÁÂÃÄÅĀĂĄèééêëēĕėęěĒĔĖĘĚìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮ',
    'ccaaaaaaaaaaaaaaaeeeeeeeeeeeeeeeiiiiiiiiiiiiiiiiooooooooooooooouuuuuuuuuuuuuuuu'
);
$$;
