/*
drop table tsqx2.main_outage_cause_dict;
drop table tsqx2.sub_outage_cause_dict;
drop table tsqx2.WIRELINE_DICT;
drop table tsqx2.WIRELINE_AFFECTED;
drop table tsqx2.UTILITY_CONTACT;
drop table tsqx2.SERVICE_TYPE_DICT;
drop table tsqx2.SERVICE_OUTAGE_RPT;
drop table tsqx2.SERVICE_OUTAGE_NOTES;
drop table tsqx2.SERVICE_OUTAGE_RPT_HIST;
drop table tsqx2.SERVICE_AFFECTED;
drop table tsqx2.RPT_COMMENT;
drop table tsqx2.REPORT_STATUS_DICT;
drop table tsqx2.REASON_REPORTED_DICT;
drop table tsqx2.E911_LOCATION_DICT;
drop table tsqx2.DIRECT_ROOT_CAUSE_DICT;
*/

CREATE TABLE tsqx2.main_outage_cause_dict
(
    main_outage_cause_key         NUMBER(12),
    main_cause_name               VARCHAR2(200)                      CONSTRAINT nn_mocd_main_cause_name NOT NULL,
    main_cause_desc               VARCHAR2(500),
    current_yn                    VARCHAR2(1)      DEFAULT 'Y'       CONSTRAINT nn_mocd_current_yn NOT NULL
);

COMMENT ON TABLE tsqx2.main_outage_cause_dict IS 'Contains the list of Direct, Root Cause and Contributing Factors to a service outage. This is main category. There are sub categories to each record which is located in sub_dirct_rt_cause_dict This data is taken directly from the FCC document. https://transition.fcc.gov/pshs/outage/nors_manual.pdf';
COMMENT ON COLUMN tsqx2.main_outage_cause_dict.main_outage_cause_key IS 'System generated primary key.';
COMMENT ON COLUMN tsqx2.main_outage_cause_dict.main_cause_name IS 'Name of the cause. Taken from FCC document.';
COMMENT ON COLUMN tsqx2.main_outage_cause_dict.main_cause_desc IS 'Description of the cause.';
COMMENT ON COLUMN tsqx2.main_outage_cause_dict.current_yn IS 'If the category is current or not.';

ALTER TABLE tsqx2.main_outage_cause_dict
ADD(
        CONSTRAINT pk_mocd_main_outage_cause_key
        PRIMARY KEY (main_outage_cause_key),
        --
        CONSTRAINT ck_mocd_current_yn
        CHECK (current_yn IN ('Y','N'))
);

Insert into tsqx2.main_outage_cause_dict  values (163632791336,'Cable Damage',null,'Y');
Insert into tsqx2.main_outage_cause_dict  values (163632791337,'Cable Damage/Malfunction',null,'Y');
Insert into tsqx2.main_outage_cause_dict  values (163632791338,'Design - Firmware',null,'Y');
Insert into tsqx2.main_outage_cause_dict  values (163632791339,'Design - Hardware',null,'Y');
Insert into tsqx2.main_outage_cause_dict  values (163632791340,'Enviroment - External','(for limited use when applicable root causes caused by a service provider or vender cannot be identified; it can also be listed as a contributing factor).','Y');
Insert into tsqx2.main_outage_cause_dict  values (163632791341,'Design - Software',null,'Y');
Insert into tsqx2.main_outage_cause_dict  values (163632791342,'Diversity Failure',null,'Y');
Insert into tsqx2.main_outage_cause_dict  values (163632791343,'Environment(Interal)',null,'Y');
Insert into tsqx2.main_outage_cause_dict  values (163632791344,'Hardware Failure',null,'Y');
Insert into tsqx2.main_outage_cause_dict  values (163632791345,'Insufficient Data',null,'Y');
Insert into tsqx2.main_outage_cause_dict  values (163632791346,'Other/Unknown','The cause of the outage cannot be determined, or the cause does not match any of the classifications above. Excludes cases where outage data were insufficient or missing, or where root cause is still under investigation. When root cause cannot be proven, it is usually still possible to determine the probable cause, which falls under the heading "Unknown." When classifications provided do not match the cause, the cause, the approximate match is preferred to be "Other."','Y');
Insert into tsqx2.main_outage_cause_dict  values (163632791347,'Planned Maintenance',null,'Y');
Insert into tsqx2.main_outage_cause_dict  values (163632791348,'Power Failure (commercial and/or Back-up)','(does not include failures of DC/DC converters or fuses embedded in switches and transmission equipment, which should be reported as a Hardware Failure, unless the problem was caused by the power plant.)','Y');
Insert into tsqx2.main_outage_cause_dict  values (163632791349,'Procedural - Other Vendor/Contractor',null,'Y');
Insert into tsqx2.main_outage_cause_dict  values (163632791350,'Procedural - Service Provider',null,'Y');
Insert into tsqx2.main_outage_cause_dict  values (163632791351,'Procedural - System Vendor',null,'Y');
Insert into tsqx2.main_outage_cause_dict  values (163632791352,'Simplex Condition',null,'Y');
Insert into tsqx2.main_outage_cause_dict  values (163632791353,'Spare',null,'Y');
Insert into tsqx2.main_outage_cause_dict  values (163632791354,'Traffic/System Overload',null,'Y');
COMMIT;

CREATE TABLE tsqx2.sub_outage_cause_dict
(
    sub_outage_cause_key            NUMBER(12),
    main_outage_cause_key           NUMBER(12)                CONSTRAINT nn_socd_main_outage_cause_key NOT NULL,
    sub_outage_cause_name           VARCHAR2(500)               CONSTRAINT nn_socd_sub_outage_cause_name NOT NULL,
    sub_outage_cause_desc           VARCHAR2(500),
    current_yn                      VARCHAR2(1)     DEFAULT 'Y' CONSTRAINT nn_soccd_current_yn NOT NULL
);

COMMENT ON TABLE tsqx2.sub_outage_cause_dict IS 'Contains the sub outage cause. This is pulled directly from the FCC website. https://transition.fcc.gov/pshs/outage/nors_manual.pdf';
COMMENT ON COLUMN tsqx2.sub_outage_cause_dict.sub_outage_cause_key IS 'System generated primary key.';
COMMENT ON COLUMN tsqx2.sub_outage_cause_dict.main_outage_cause_key IS 'Foreign key to the main outage.';
COMMENT ON COLUMN tsqx2.sub_outage_cause_dict.sub_outage_cause_name IS 'Name of the sub outage cause. This comes directly from the FCC.';
COMMENT ON COLUMN tsqx2.sub_outage_cause_dict.sub_outage_cause_desc IS 'Description of the cause.';
COMMENT ON COLUMN tsqx2.sub_outage_cause_dict.current_yn IS 'Determine if the record is current.';

ALTER TABLE tsqx2.sub_outage_cause_dict
ADD(
        CONSTRAINT pk_socd_sub_outage_cause_key
        PRIMARY KEY (sub_outage_cause_key),
        --
        CONSTRAINT fk_socd_main_outage_cause_key
        FOREIGN KEY (main_outage_cause_key)
        REFERENCES tsqx2.main_outage_cause_dict(main_outage_cause_key),
        --
        CONSTRAINT ck_socd_current_yn
        CHECK (current_yn IN ('Y','N'))
);

INSERT INTO tsqx2.sub_outage_cause_dict values (163652792226,163632791354,'Media-Stimulated Calling-Insufficient Notification',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792227,163632791354,'Other',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791355,163632791336,'Cable Unlocated','This is considered a procedural error. Prior notification of action was provided by the excavator, but the facility owner or location company failed to establish the presence of a cable, which was then eventually damaged.','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791358,163632791336,'Digging Error','Excavator error during digging(contractor provided accurate notification, route was accurately located and marked, and cable was buried at a proper depth with sufficient clearance from other sub-surface structures).','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791359,163632791336,'Inaccurate/Incomplete Cable Locate','This is considered a procedual error. The cable' || '''' || 's presence was determined, but its location was inaccurately and/or partially identified.','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791360,163632791336,'Inadequate/No Notification','Excavator failed to provide sufficient or any notification prior to digging, did not accurately describe the location of the digging work to be performed, or did not wait the required time for locate completion.','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791361,163632791336,'Other',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791362,163632791336,'Shallow Cable','The cable was at too shallow a depth(notification was adequate, locate was accurate, excavator followed standard procedures).','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791365,163632791338,'Insufficient Software Sate Indications','Failure to communicate or display out-of-service firmware states; failure to identify, communicate or display indolent or "sleepy" firmware states.','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791366,163632791338,'Other',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791367,163632791338,'Ineffective Fault Recovery or Re-Initialization Action','Failure to reset/restore following general/system restoral/initialization.','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791368,163632791337,'Aerial/Non-Buried','Aerial/non-buried cable was damaged or ceased to function(e.g., power transformer fire, tension on span, automobile collision, etc.).','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791369,163632791337,'Cable Malfunction','Cable ceased to function (e.g., loss of transmission due to aging, connector failure, etc.).','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791370,163632791339,'Other',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791371,163632791339,'Inadequate Grounding Strategy','Insufficient component grounding design; duplex components/systems sharing common power feeds/fusing.','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791372,163632791339,'Poor Backplane or Pin Arrangement','Non-standard/confusing pin arrangements or pin numbering schemes; insufficient room or clearance between pins; backplane/pin crowding.','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791373,163632791339,'Poor card/frame mechanisms(latches slots, jacks, etc.)','Mechanical/physical design problems.','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791376,163632791341,'Faulty Software Load - Office Data','Inaccurate/mismatched office configuration data used/applied; wrong/defective office load supplied.','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791377,163632791341,'Faulty Software Load - Program Data','Bad program code/instructions; logical errors/incompatibility between features/sets; software quality control failure; wrong/defective program load supplied; software vulnerability to virus infection.','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791378,163632791341,'Inadequate Defensive Checks','Changes to critical or protected memory were allowed without system challenge; contradictory or ambiguous system input commands were interpreted/responded to without system challenge. Failure of system to recognize or communicate query/warning in response to commands with obivious major system/network impact.','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791379,163632791341,'Ineffective Fault Recovery or Re-initialization Action','Simple, single-point failure resulting in total system outage; failure of system diagnostics resulting from the removal of a good unit with restoral of faulty mate; failure to switch/protect the switch to standby/spare/mate components(s)','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791380,163632791341,'Other',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791381,163632791342,'External','Failure to provide or maintain the diversity of links or circuits among external network components which results in a single-point-of failure configuration.','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791382,163632791342,'Internal(Other)','Failure to provide or maintain the diversity of equipment internal to a building. This is excluding power equipment and timing equipment.','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791383,163632791342,'Links','SS7 communication paths were not physically and logically diverse','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791384,163632791342,'Power','Failure to diversify links, circuits, or equipment among redundant power system components, including AC rectifiers/chargers, battery power plants, DC distribution facilities, etc.','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791385,163632791342,'Timing Equipment','Failure to diversify critical equipment across timing supplies (e.g., BITS locks).','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791388,163632791340,'Animal Damage','Component destruction associated with damaged caused by animals (e.g., squirrel/rodent chewing of cables, insect infestation, bird droppings, bird nests, etc.).','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791389,163632791340,'Earthquake','Component destruction or fault associated directly or indirectly with seismic shock. However, if damage was the result of inadequate earthquake bracing, consider the root cause to be Design – Hardware.','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791390,163632791340,'Fire','Components destruction or fault associated with a fire occurring/starting outside the service provider plant. This includes brush fires, pole fires, etc.','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791391,163632791340,'Flood',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791392,163632791340,'Ice/Storm',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791393,163632791340,'Lighting/Transient Voltage','Component destruction or fault associated with surges and over-voltages caused by (electrical) atmospheric disturbances.','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791394,163632791340,'Other',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791395,163632791340,'Storm - Water/Ice','Component destruction or fault associated with fog, rain, hail, sleet, snow, or the accumulation of water/ice(flooding, collapse under weight of snow, etc.).','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791396,163632791340,'Storm - Wind/Trees','Component destruction or fault associated with wind-borne debris or falling trees/limbs.','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791397,163632791340,'Vandalism/Theft','Component loss, destruction, or fault associated with larceny, mischief, or other malicious acts.','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791398,163632791340,'Vehicular Accident','Compnent destruction or fault assocaited with vehicle (car, truck, train, etc.) collision.','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791401,163632791343,'Cable Pressurization Failure','Component destruction or fault associated with cable damage resulting from cable pressurization failure.','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791402,163632791343,'Dirt, Dust Contamination','Component loss or fault associated wit hackable damage resulting from cable pressurization failure.','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791403,163632791343,'Enviromental System Failure (heate/humidity)','Component loss or fault associated with extreme temperature, rapid temperature changes, or high humidity due to loss/malfunction of environmental control(s). If the failure was the result of inadequate/lack of response to(alarmed/un-alarmed) environmental failures, or due to incorrect manual control of environmental systems, consider the root cause to be a procedural failure.','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791404,163632791343,'Fire Suppression','Component loss or fault associated with corrosion (electrolytic or other caused by fire suppression activates; this root cause assumes that no substantial failure was directly associated with the smoke/firer that triggered suppression.','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791405,163632791343,'Fire, Arcing, Smaoke Damage','Component loss or fault associated with damage directly related to center office or equipment fires (open flame or smoldering), corrosive smoke emissions, or electrical arcing (whether or not ignition of surrounding material occurs).','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791406,163632791343,'Manhole/Cable Vault Leak','Component destruction or fault assocaited with water entering manholes, cable vaults, CEVs, etc.','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791407,163632791343,'Other',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791408,163632791343,'Roof/Aire Conditioning Leak','Component destruction or fault associated with water damage (direct or electrolytic) caused by roof or environmental systems leaks into/in central office environment.','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791409,163632791344,'Circuit Pack/Card Failure-Other','Circuit pack or card, other than within a processor or memory unit, failed(e.g., component failure, pin edge connector failure, firmware failure, etc.).','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791410,163632791344,'Circuit Pack/Card Failure-Processor','Circuit pack or card within the processor failed (e.g. component failure, pin edge connector failure, firmware failure, etc.).','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791411,163632791344,'Memory Unit Failure',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791412,163632791344,'Other',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791413,163632791344,'Passive Devices','Equipment, hardware or devices that contain no electronics (e.g., demarcation points, cross connect panels, splitters, attenuators, etc.).','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791414,163632791344,'Peripheral Unit Failure',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791415,163632791344,'Self-contained Device Failure','Equipment or hardware that contains electronics, but does not contain replaceable components.','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791416,163632791344,'Processor Community Failure',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791417,163632791344,'Shelf/Slot Failure','Failure of entire equipment shelf/chassis, connectors, or backplane (e.g., physical damage, corrosion, contamination, wear, etc.).','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791418,163632791344,'Software Storage Media Failure','Hardware failure resulting in corruption of office data, program data, routing data, etc.','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791419,163632791345,'Insufficient Data (no additional modifier)','There is not enough information from the failure report ( and subsequent investigation, if any) to determine cause(s) of failure.','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791420,163632791345,'Cleared While Testing','There is not enough information from the failure report ( and subsequent investigation, if any) to determine cause(s) of failure.','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791421,163632791345,'Cleared While Testing','Services restored before the cause could be determined','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791422,163632791345,'Non-Service Provider Personnel','Failure is caused by non-service provider personnel (e.g., contractors, building maintenance personnel, tenant of telco hotel, etc.).','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791423,163632791345,'Outside Owned Network','Failure occured in another company' || '''' || 's network (e.g., leased transport capacity, contracted signaling service, etc.).','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791424,163632791345,'Under Investigation','Root cause analysis pending','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791427,163632791347,'To Upgrade the System','Outage occurred during scheduled maintenance to upgrade the system or network element. The system or network element upgrade was completed successfully within expected times; however, FCC outage repowering thresholds were met.','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791428,163632791347,'To Fix Known Problems','Outage occured during scheduled maintenece to fix fnown probelms. The known problems were resolved successfully; however, FCC outage reporting thresholds were met.','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791429,163632791347,'Failed','Unexpected condition caused the planned maintenance activity to fail and FCC outage reporting thresholds were met.','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791430,163632791347,'Went Longer or Was Worse than Expected','The planned maintenance activity was completed successfully; however, due to unexpected conditions, planned maintenance took longer or had a greater impact than expected.','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791431,163632791348,'Battery Failure','Batteries did not function as designed.','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791432,163632791348,'Breaker Tripped/Blown Fuses','Equipment failure associated with tripped breaker or blown fuse','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791433,163632791348,'Extended Commercial Power Failure','System failure due to commercial power failure that extends betond the design of back-up capabilities','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163632791434,163632791348,'Generator Failure','Generator did not function as designed or ran out of fuel.','Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792185,163632791348,'Inadequate Site-Specific Power Contingency Plans',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792186,163632791348,'Inadequate Back-up Power Equipment Located on Customer Premise',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792187,163632791348,'Inadequate/Missing Power Alarm',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792188,163632791348,'Insufficient Response to Power Alarm',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792189,163632791348,'Lack of Power Redundancy',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792190,163632791348,'Lack of Routine Maintenance/Testing',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792191,163632791348,'Lack of Routine Maintenance/Testing',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792192,163632791348,'Other',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792193,163632791348,'Overloaded/Undersized Power Equipment',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792194,163632791348,'Rectifier Failure',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792195,163632791348,'Scheduled Activity-Software Upgrade',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792196,163632791348,'Scheduled Maintenance-Hardware Replacement',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792197,163632791348,'Unidentified Power Surge',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792198,163632791349,'Ad hoc Activities, Outside Scope of MOP',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792199,163632791349,'Documentation/Procedures Out-of-Date, Unusable, Impractical',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792200,163632791349,'Documentation/Procedurees Unavailable, Incomplete',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792201,163632791349,'Insufficient Staffing/Support',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792202,163632791349,'Insufficient Supervision/Control or Employee Error',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792203,163632791349,'Insufficient Training',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792204,163632791349,'Other',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792205,163632791350,'Documentation/Procedures Out-of-Date, Unusable or Impractical',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792206,163632791350,'Documentation/Procedures Unavailable/Unclear/Incomplete',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792207,163632791350,'Inadequate Routine Maintenance/Memory Back-Up',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792208,163632791350,'Insufficient Staffing/Support',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792209,163632791350,'Insufficient Supervision/Control or Employee Error',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792210,163632791350,'Insufficient Training',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792211,163632791351,'Documentation/Procedures Out-of-Date, Unusable or Impractical',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792212,163632791351,'Ad hoc Activities, Outside Scope of MOP',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792213,163632791351,'Insufficient Staffing/Support',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792214,163632791351,'Insufficient Supervision/Control or Employee Error',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792215,163632791351,'Insufficient Training',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792216,163632791351,'Other',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792217,163632791352,'Non-service Affecting',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792218,163632791352,'Service Affecting',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792219,163632791353,'Spare Not Available',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792220,163632791353,'Spare On Hnad-Failed',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792221,163632791353,'Spare On Hand-Manufacturer Discontinued(MD)',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792222,163632791354,'Common Channel Signaling Network Overload',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792223,163632791354,'Inappropriate/Insufficient Network Management(NM)Control(s)',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792224,163632791354,'Ineffective Engineering/Engineering Tools',NULL,'Y');
INSERT INTO tsqx2.sub_outage_cause_dict values (163652792225,163632791354,'Mass Calling-Focused/Diffuse Network Overload',NULL,'Y');
COMMIT;

CREATE TABLE tsqx2.reason_reported_dict
(
    reason_reported_key      NUMBER(12)                  GENERATED BY DEFAULT ON NULL AS IDENTITY,
    reason_name              VARCHAR2(100)                 CONSTRAINT nn_rrd_reason_name NOT NULL,
    reason_desc              VARCHAR2(500)                 CONSTRAINT nn_rrd_reason_desc NOT NULL,         
    current_yn               VARCHAR2(1)       DEFAULT 'Y' CONSTRAINT nn_rrd_current_yn NOT NULL,
    order_by                 NUMBER
);

ALTER TABLE tsqx2.reason_reported_dict
ADD(
    (CONSTRAINT "PK_REASON_REPORTED_KEY"
    PRIMARY KEY (REASON_REPORTED_KEY)
);

INSERT INTO tsqx2.reason_reported_dict values (null,'Wireline - 900,000 User-Minutes','Wireline - 900,000 User-Minutes','Y',1);
INSERT INTO tsqx2.reason_reported_dict values (null,'Wireless - 900,000 User-Minutes','Wireless - 900,000 User-Minutes','Y',2);
INSERT INTO tsqx2.reason_reported_dict values (null,'Cable Telephony - 900,000 User-Minutes','Cable Telephony - 900,000 User-Minutes','Y',3);
INSERT INTO tsqx2.reason_reported_dict values (getpk,'MSC','MSC','Y',4);
INSERT INTO tsqx2.reason_reported_dict values (null,'E911','E911','Y',5);
INSERT INTO tsqx2.reason_reported_dict values (null,'Blocked Calls','Blocked Calls','Y',6);
INSERT INTO tsqx2.reason_reported_dict values (null,'1350 DS3 minutes','1350 DS3 minutes','Y',7);
INSERT INTO tsqx2.reason_reported_dict values (null,'667 OC3 minutes','667 OC3 minutes','Y',8);
INSERT INTO tsqx2.reason_reported_dict values (null,'DS3-Simplex Greater than 5 days','DS3-Simplex Greater than 5 days','Y',9);
INSERT INTO tsqx2.reason_reported_dict values (null,'OC3-Simplex Greater than 5 days','OC3-Simplex Greater than 5 days','Y',10);
INSERT INTO tsqx2.reason_reported_dict values (null,'SS7 - MTP Messages','SS7 - MTP Messages','Y',11);
INSERT INTO tsqx2.reason_reported_dict values (null,'Airport','Airport','Y',12);
INSERT INTO tsqx2.reason_reported_dict values (null,'Other Special Facilities (Military, nuclear, etc.)','Other Special Facilities (Military, nuclear, etc.)','Y',13);
INSERT INTO tsqx2.reason_reported_dict values (null,'Paging','Paging','Y',14);
INSERT INTO tsqx2.reason_reported_dict values (null,'Satellite','Satellite','Y',15);
INSERT INTO tsqx2.reason_reported_dict values (null,'VoIP - E911','VoIP - E911','Y',16);
INSERT INTO tsqx2.reason_reported_dict values (null,'VoIP - 900,000 user-minutes','VoIP - 900,000 user-minutes','Y',17);
INSERT INTO tsqx2.reason_reported_dict values (null,'Other','Other','Y',18);

COMMIT;

COMMENT ON TABLE tsqx2.reason_reported_dict IS 'Contains the reasons why an outage report was submitted.';
COMMENT ON COLUMN tsqx2.reason_reported_dict.reason_reported_key IS 'System generated primary key.';
COMMENT ON COLUMN tsqx2.reason_reported_dict.reason_name IS 'Name of the reason. Value used to reference the name.';
COMMENT ON COLUMN tsqx2.reason_reported_dict.reason_desc IS 'Description of te reason reported.';
COMMENT ON COLUMN tsqx2.reason_reported_dict.current_yn IS 'Determines if the reason reported is currenty or not.';
COMMENT ON COLUMN tsqx2.reason_reported_dict.order_by IS 'Ordering of how the value is being displayed.';

CREATE TABLE tsqx2.report_status_dict
(
    report_status_code       VARCHAR2(20),
    report_status_name       VARCHAR2(100)               CONSTRAINT nn_rsd_report_status_name NOT NULL,
    report_status_desc       VARCHAR2(500)               CONSTRAINT nn_rsd_report_status_desc NOT NULL,
    report_order             NUMBER,
    active_yn                VARCHAR2(1)     DEFAULT 'Y' CONSTRAINT nn_rsd_active_yn          NOT NULL
);

INSERT INTO tsqx2.report_status_dict VALUES ('NOTIF','Notification','Notification report that an outage has potentially occured.',1,'Y');
INSERT INTO tsqx2.report_status_dict VALUES ('INIT','Initial','Start of the outage report indicating that an outage did occur.',2,'Y');
INSERT INTO tsqx2.report_status_dict VALUES ('FIN','Final','Final report of the outage.',3,'Y');
INSERT INTO tsqx2.report_status_dict VALUES ('W/D','Withdrawn','Outage report was withdrawn.',NULL,'Y');
INSERT INTO tsqx2.report_status_dict VALUES ('REOP','Re-open','Outage report was reopened.',4,'N');
COMMIT;

COMMENT ON TABLE tsqx2.report_status_dict IS 'Dictionary table of all possible report statuses.';
COMMENT ON COLUMN tsqx2.report_status_dict.report_status_code IS 'Primary key to identify the status.';
COMMENT ON COLUMN tsqx2.report_status_dict.report_status_name IS 'Decode of the report_status_code.';
COMMENT ON COLUMN tsqx2.report_status_dict.report_status_desc IS 'Description of the report status.';
COMMENT ON COLUMN tsqx2.report_status_dict.report_order       IS 'Identifies the order of the report which is being submitted.';
COMMENT ON COLUMN tsqx2.report_status_dict.active_yn          IS 'Identifies whether the value of the record is active or not.';

ALTER TABLE tsqx2.report_status_dict
ADD(
        CONSTRAINT pk_rsd_report_status_code
        PRIMARY KEY (report_status_code),
        --
        CONSTRAINT uk_rsd_report_status_name
        UNIQUE (report_status_name),
        --
        CONSTRAINT uk_rsd_report_order
        UNIQUE (report_order),
        --
        CONSTRAINT ck_rsd_report_order
        CHECK (report_order > 0),
        --
        CONSTRAINT ck_rsd_active_yn
        CHECK (active_yn IN ('Y','N'))
);

----
----
----

CREATE TABLE tsqx2.service_type_dict
(
    service_type_key       NUMBER(12)       GENERATED BY DEFAULT ON NULL AS IDENTITY,
    service_type_name      VARCHAR2(200)      CONSTRAINT nn_std_service_type_name NOT NULL,
    service_type_desc      VARCHAR2(500)      CONSTRAINT nn_std_service_type_desc NOT NULL,
    active_yn              VARCHAR2(1)        CONSTRAINT nn_std_active_yn NOT NULL    
);

INSERT INTO tsqx2.service_type_dict VALUES (null,'Cable Telephony','Cable Telephony Issues','Y');
INSERT INTO tsqx2.service_type_dict VALUES (null,'E911','E911 Issues','Y');
INSERT INTO tsqx2.service_type_dict VALUES (null,'Wireline','Wireline Issues','Y');
INSERT INTO tsqx2.service_type_dict VALUES (null,'Wireless (non-paging)','Wireless (non-paging) Issues','Y');
INSERT INTO tsqx2.service_type_dict VALUES (null,'Signaling (SS7)','Signaling (SS7) Issues','Y');
INSERT INTO tsqx2.service_type_dict VALUES (null,'Satellite','Satellite Issues','Y');
INSERT INTO tsqx2.service_type_dict VALUES (null,'Paging','Paging Issues','Y');
INSERT INTO tsqx2.service_type_dict VALUES (null,'VoIP','VoIP Issues','Y');
INSERT INTO tsqx2.service_type_dict VALUES (null,'Transport - DS3','Transport - DS3 Issues','Y');
INSERT INTO tsqx2.service_type_dict VALUES (null,'Transport - OC3','Transport - OC3 Issues','Y');
INSERT INTO tsqx2.service_type_dict VALUES (null,'Specifal Facilities','Special Facilities (Airport,Gov., etc.) Issues','Y');
INSERT INTO tsqx2.service_type_dict VALUES (null,'Other','Other Issues','Y');
COMMIT;

COMMENT ON TABLE tsqx2.service_type_dict IS 'Dictionary table to indicate the type of services affected.';
COMMENT ON COLUMN tsqx2.service_type_dict.service_type_key IS 'System generated primary key.';
COMMENT ON COLUMN tsqx2.service_type_dict.service_type_name IS 'Name of the service type.';
COMMENT ON COLUMN tsqx2.service_type_dict.service_type_desc IS 'Description of the service affected.';
COMMENT ON COLUMN tsqx2.service_type_dict.active_yn IS 'Indicates if the current record is active.';

ALTER TABLE tsqx2.service_type_dict
ADD(
        CONSTRAINT pk_std_service_type_key
        PRIMARY KEY (service_type_key),
        --
        CONSTRAINT ck_std_active_yn
        CHECK (active_yn IN ('Y','N'))
);

----
----
----

CREATE TABLE tsqx2.e911_location_dict
(
     e911_location_key      NUMBER(12)     GENERATED BY DEFAULT ON NULL AS IDENTITY,
     e911_location_name     VARCHAR2(200)    CONSTRAINT nn_eld_e911_location_name NOT NULL,
     current_yn             VARCHAR2(1)      CONSTRAINT nn_eld_current_yn NOT NULL
);

INSERT INTO tsqx2.e911_location_dict VALUES (null,'ALI location only affected','Y');
INSERT INTO tsqx2.e911_location_dict VALUES (null,'Phase 2 only affected','Y');
INSERT INTO tsqx2.e911_location_dict VALUES (null,'Phase 1 and 2 only affected','Y');
INSERT INTO tsqx2.e911_location_dict VALUES (null,'More than location affected','Y');
INSERT INTO tsqx2.e911_location_dict VALUES (null,'911 Services not affected','Y');
COMMIT;

COMMENT ON TABLE tsqx2.e911_location_dict IS 'E911 location outage dictionary.';
COMMENT ON COLUMN tsqx2.e911_location_dict.e911_location_key IS 'System generated primary key';
COMMENT ON COLUMN tsqx2.e911_location_dict.e911_location_name IS 'Name of the location outage.';
COMMENT ON COLUMN tsqx2.e911_location_dict.current_yn IS 'Indicates if the record is current.';

ALTER TABLE tsqx2.e911_location_dict
ADD(
         CONSTRAINT pk_eld_e911_location_key
         PRIMARY KEY (e911_location_key),
         --
         CONSTRAINT ck_current_yn
         CHECK (current_yn IN ('Y','N'))
);

----
----
----

CREATE TABLE tsqx2.wireline_dict
(
    wireline_key      NUMBER(12)                  GENERATED BY DEFAULT ON NULL AS IDENTITY,
    wireline_type     VARCHAR2(100)                 CONSTRAINT nn_wd_wireline_type NOT NULL,
    description       VARCHAR2(500)                 CONSTRAINT nn_wd_description NOT NULL,
    current_yn        VARCHAR2(1)       DEFAULT 'Y' CONSTRAINT nn_wd_current_yn NOT NULL
);

INSERT INTO tsqx2.wireline_dict VALUES (null,'No Dial Tone','No Dial Tone','Y');
INSERT INTO tsqx2.wireline_dict VALUES (null,'Toll Isolation','Toll Isolation','Y');
INSERT INTO tsqx2.wireline_dict VALUES (null,'Loss of DSL','Loss of DSL','Y');
INSERT INTO tsqx2.wireline_dict VALUES (null,'Loss of 911','Loss of 911','Y');
INSERT INTO tsqx2.wireline_dict VALUES (null,'Other','Other','Y');
COMMIT;

COMMENT ON TABLE tsqx2.wireline_dict IS 'Dictionary table for all type of wirelines affected to be reported.';
COMMENT ON COLUMN tsqx2.wireline_dict.wireline_key IS 'System generated primary key.';
COMMENT ON COLUMN tsqx2.wireline_dict.wireline_type IS 'The type of wireline that is affected.';
COMMENT ON COLUMN tsqx2.wireline_dict.description IS 'Description of the wireline affected.';
COMMENT ON COLUMN tsqx2.wireline_dict.current_yn IS 'Indicates if the wireline type is current.';

ALTER TABLE tsqx2.wireline_dict
ADD(
        CONSTRAINT pk_wd_wireline_key
        PRIMARY KEY (wireline_key),
        --
        CONSTRAINT ck_wd_current_yn
        CHECK (current_yn IN ('Y','N'))
);

---
---
---

CREATE TABLE tsqx2.service_outage_rpt
(
    service_outage_rpt_key   NUMBER(12),
    fcc_report_number        NUMBER(25)    CONSTRAINT nn_sor_fcc_report_number NOT NULL,
    report_status_code       VARCHAR2(25)    CONSTRAINT nn_sor_report_status_code NOT NULL
);

COMMENT ON TABLE tsqx2.service_outage_rpt IS 'Parent table listing all reports reported by the carriers.';
COMMENT ON COLUMN tsqx2.service_outage_rpt.service_outage_rpt_key IS 'System generated primary key.';
COMMENT ON COLUMN tsqx2.service_outage_rpt.fcc_report_number IS 'This is the corresponding FCC report number that the carrier recieved after filing with the FCC.';
COMMENT ON COLUMN tsqx2.service_outage_rpt.report_status_code IS 'Indicates the current report status.';


--now adding the adjusted sv out rpt 2 and hist 2. 


  CREATE TABLE "TSQX2"."SERVICE_OUTAGE_RPT_2" 
   (    "FCC_REPORT_NUMBER" NUMBER(25,0) CONSTRAINT "NN_SOR2_FCC_NUM" NOT NULL ENABLE, 
    "REPORT_STATUS_CODE" VARCHAR2(25 BYTE) CONSTRAINT "NN_SOR2_RPRT_STATUS_CODE" NOT NULL ENABLE, 
    "E911_LOCATION_KEY" NUMBER(12,0), 
    "MEDIA_ATTN_YN" VARCHAR2(1 BYTE) DEFAULT 'N', 
    "OCN_NUMBER" VARCHAR2(50 BYTE), 
    "SERVICE_INTERRUPTION_DATE" DATE CONSTRAINT "NN_SOR2_SRVCE_INTER_DATE" NOT NULL ENABLE, 
    "SERVICE_RESTORATION_EST" DATE, 
    "SERVICE_RESTORATION_ACTUAL" DATE, 
    "EXPLANATION_OF_OUTAGE_DURATION" VARCHAR2(3999 BYTE), 
    "SOE_YN" VARCHAR2(10 BYTE) DEFAULT 'N', 
    "INSIDE_BUILDING_YN" VARCHAR2(10 BYTE) DEFAULT 'N', 
    "REASON_REPORTED_KEY" NUMBER(12,0), 
    "FAIL_DIFF_CMPNY_NTWRK_YN" VARCHAR2(10 BYTE) DEFAULT 'N', 
    "DIRECT_CAUSE_KEY" NUMBER(12,0), 
    "SUB_DIRECT_CAUSE_KEY" NUMBER(12,0), 
    "ROOT_CAUSE_KEY" NUMBER(12,0), 
    "SUB_ROOT_CAUSE_KEY" NUMBER(12,0), 
    "LOD_CAUSED_CONTRIBUTED_YN" VARCHAR2(1 BYTE) DEFAULT 'N', 
    "TSP_INVOLVED_YN" VARCHAR2(1 BYTE) DEFAULT 'N', 
    "MALICIOUS_ACTIVITY_YN" VARCHAR2(1 BYTE) DEFAULT 'N', 
    "CABLE_TELEPHONY" VARCHAR2(10 BYTE) DEFAULT '0' CONSTRAINT "NN_SOR2_CABLE_TELEPHONY" NOT NULL ENABLE, 
    "E911" VARCHAR2(10 BYTE) DEFAULT '0' CONSTRAINT "NN_SOR2_E911" NOT NULL ENABLE, 
    "WIRELINE" VARCHAR2(10 BYTE) DEFAULT '0' CONSTRAINT "NN_SOR2_WIRELINE" NOT NULL ENABLE, 
    "WIRELESS_NON_PAGING" VARCHAR2(10 BYTE) DEFAULT '0' CONSTRAINT "NN_SOR2_WIRELESS_NON_PAGING" NOT NULL ENABLE, 
    "SIGNALING_SS7" VARCHAR2(10 BYTE) DEFAULT '0' CONSTRAINT "NN_SOR2_SIGNALING_SS7NOT" NOT NULL ENABLE, 
    "END_USER_CKT_MINUTES" VARCHAR2(10 BYTE) DEFAULT '0' CONSTRAINT "NN_SOR2_END_USER_CKT_MINUTES" NOT NULL ENABLE, 
    "SATELLITE" VARCHAR2(10 BYTE) DEFAULT '0' CONSTRAINT "NN_SOR2_SATELLITE" NOT NULL ENABLE, 
    "PAGING" VARCHAR2(10 BYTE) DEFAULT '0' CONSTRAINT "NN_SOR2_PAGING" NOT NULL ENABLE, 
    "VOIP" VARCHAR2(10 BYTE) DEFAULT '0' CONSTRAINT "NN_SOR2_VOIP" NOT NULL ENABLE, 
    "TRANSPORT_DS3" VARCHAR2(10 BYTE) DEFAULT '0' CONSTRAINT "NN_SOR2_TRANSPORT_DS3" NOT NULL ENABLE, 
    "TRANSPORT_OC3" VARCHAR2(10 BYTE) DEFAULT '0' CONSTRAINT "NN_SOR2_TRANSPORT_OC3" NOT NULL ENABLE, 
    "BLOCKED_CALLS" VARCHAR2(10 BYTE) DEFAULT '0' CONSTRAINT "NN_SOR2_BLOCKED_CALLS" NOT NULL ENABLE, 
    "SPECIAL_FACILITIES" VARCHAR2(10 BYTE) DEFAULT '0' CONSTRAINT "NN_SOR2_SPECIFAL_FACILITIES" NOT NULL ENABLE, 
    "SERVICE_OTHER_DESC" VARCHAR2(500 BYTE), 
    "NO_DIAL_TONE_YN" VARCHAR2(1 BYTE) DEFAULT 'N', 
    "TOLL_ISOLATION_YN" VARCHAR2(1 BYTE) DEFAULT 'N', 
    "LOSS_OF_DSL_YN" VARCHAR2(1 BYTE) DEFAULT 'N', 
    "LOSS_OF_911_YN" VARCHAR2(1 BYTE) DEFAULT 'N', 
    "WIRELINE_OTHER_DESC" VARCHAR2(500 BYTE), 
    "INCIDENT_DESC" VARCHAR2(3999 BYTE), 
    "NAME_TYPE_EQ_FAILED" VARCHAR2(3999 BYTE), 
    "NETWORK_INVOLVED" VARCHAR2(3999 BYTE), 
    "DESC_CAUSES" VARCHAR2(3999 BYTE), 
    "RESTORE_METHODS" VARCHAR2(3999 BYTE), 
    "STEPS_PREVENT_REOCCUR" VARCHAR2(3999 BYTE), 
    "BEST_PRACTICE_PREVENTION" VARCHAR2(3999 BYTE), 
    "BEST_PRACTICE_MITIGATE" VARCHAR2(3999 BYTE), 
    "ANALYSIS_OF_BEST_PRACTICE" VARCHAR2(3999 BYTE), 
    "REMARKS_COMMENTS" VARCHAR2(3999 BYTE), 
    "UTILITY_CONTACT_NAME" VARCHAR2(200 BYTE), 
    "UTILITY_CONTACT_EMAIL" VARCHAR2(200 BYTE), 
    "UTILITY_CONTACT_PHONE_NUM" NUMBER(22,0), 
    "UTILITY_CONTACT_EXT" NUMBER(22,0), 
    "INITIAL_FILING_DATE" DATE DEFAULT SYSDATE, 
    "DATE_UPDATED" DATE DEFAULT SYSDATE, 
    "CITY_STR" VARCHAR2(3999 BYTE), 
    "ZIP_CODE_STR" VARCHAR2(3999 BYTE), 
    "COUNTY_STR" VARCHAR2(3999 BYTE), 
    "FACI_CITY_STR" VARCHAR2(3999 BYTE), 
    "FACI_COUNTY_STR" VARCHAR2(3999 BYTE), 
    "GEO_DESC" VARCHAR2(3999 BYTE), 
    "COMPANY_ID" NUMBER, 
     CONSTRAINT "CK_SOR2_MEDIA_ATTN_YN" CHECK (MEDIA_ATTN_YN IN ('Y', 'N')) ENABLE, 
     CONSTRAINT "CK_SOR2_SOE_YN" CHECK (SOE_YN IN ('Y', 'N')) ENABLE, 
     CONSTRAINT "CK_SOR2_INSIDE_BUILDING_YN" CHECK (INSIDE_BUILDING_YN IN ('Y', 'N')) ENABLE, 
     CONSTRAINT "CK_SOR2_FAIL_DIFF_NTWRK_YN" CHECK (FAIL_DIFF_CMPNY_NTWRK_YN IN ('Y', 'N')) ENABLE, 
     CONSTRAINT "CK_SOR2_NO_DIAL_TONE_YN" CHECK (NO_DIAL_TONE_YN IN ('Y', 'N')) ENABLE, 
     CONSTRAINT "CK_SOR2_TOLL_ISOLATION_YN" CHECK (TOLL_ISOLATION_YN IN ('Y', 'N')) ENABLE, 
     CONSTRAINT "CK_SOR2_LOSS_OF_DSL_YN" CHECK (LOSS_OF_DSL_YN IN ('Y', 'N')) ENABLE, 
     CONSTRAINT "CK_SOR2_LOSS_OF_911_YN" CHECK (LOSS_OF_911_YN IN ('Y', 'N')) ENABLE, 
     CONSTRAINT "CK_SOR2_LOD_CAUSED_CONTRI_YN" CHECK (LOD_CAUSED_CONTRIBUTED_YN IN ('Y', 'N')) ENABLE, 
     CONSTRAINT "CK_SOR2_TSP_INVOLVED_YN" CHECK (TSP_INVOLVED_YN IN ('Y', 'N')) ENABLE, 
     CONSTRAINT "CK_SOR2_MALICIOUS_ACTIVITY_YN" CHECK (MALICIOUS_ACTIVITY_YN IN ('Y', 'N')) ENABLE, 
     CONSTRAINT "OUTAGE_RPT_PK" PRIMARY KEY ("FCC_REPORT_NUMBER")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE, 
     CONSTRAINT "FK_SOR2_E911_LOCATION_KEY" FOREIGN KEY ("E911_LOCATION_KEY")
      REFERENCES "TSQX2"."E911_LOCATION_DICT" ("E911_LOCATION_KEY") ENABLE, 
     CONSTRAINT "FK_SOR2_REASON_REPORTED_KEY" FOREIGN KEY ("REASON_REPORTED_KEY")
      REFERENCES "TSQX2"."REASON_REPORTED_DICT" ("REASON_REPORTED_KEY") ENABLE, 
     CONSTRAINT "FK_SOR2_DIRECT_CAUSE_KEY" FOREIGN KEY ("DIRECT_CAUSE_KEY")
      REFERENCES "TSQX2"."MAIN_OUTAGE_CAUSE_DICT" ("MAIN_OUTAGE_CAUSE_KEY") ENABLE, 
     CONSTRAINT "FK_SOR2_ROOT_CAUSE_KEY" FOREIGN KEY ("ROOT_CAUSE_KEY")
      REFERENCES "TSQX2"."MAIN_OUTAGE_CAUSE_DICT" ("MAIN_OUTAGE_CAUSE_KEY") ENABLE, 
     CONSTRAINT "FK_SOR2_SUB_DIRECT_CAUSE_KEY" FOREIGN KEY ("SUB_DIRECT_CAUSE_KEY")
      REFERENCES "TSQX2"."SUB_OUTAGE_CAUSE_DICT" ("SUB_OUTAGE_CAUSE_KEY") ENABLE, 
     CONSTRAINT "FK_SOR2_SUB_ROOT_CAUSE_KEY" FOREIGN KEY ("SUB_ROOT_CAUSE_KEY")
      REFERENCES "TSQX2"."SUB_OUTAGE_CAUSE_DICT" ("SUB_OUTAGE_CAUSE_KEY") ENABLE, 
     CONSTRAINT "FK_SOR2_REPORT_STATUS_CODE" FOREIGN KEY ("REPORT_STATUS_CODE")
      REFERENCES "TSQX2"."REPORT_STATUS_DICT" ("REPORT_STATUS_CODE") ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;



  CREATE TABLE "TSQX2"."SERVICE_OUTAGE_RPT_HIST_2" 
   (    "SERVICE_OUTAGE_RPT_HIST_KEY" NUMBER(12,0), 
    "FCC_REPORT_NUMBER" NUMBER(25,0) CONSTRAINT "NN_SORH2_FCC_NUM" NOT NULL ENABLE, 
    "REPORT_STATUS_CODE" VARCHAR2(25 BYTE) CONSTRAINT "NN_SORH2_RPRT_STATUS_CODE" NOT NULL ENABLE, 
    "E911_LOCATION_KEY" NUMBER(12,0), 
    "MEDIA_ATTN_YN" VARCHAR2(1 BYTE), 
    "OCN_NUMBER" VARCHAR2(50 BYTE), 
    "SERVICE_INTERRUPTION_DATE" DATE CONSTRAINT "NN_SORH2_SRVCE_INTER_DATE" NOT NULL ENABLE, 
    "SERVICE_RESTORATION_EST" DATE, 
    "SERVICE_RESTORATION_ACTUAL" DATE, 
    "EXPLANATION_OF_OUTAGE_DURATION" VARCHAR2(3999 BYTE), 
    "SOE_YN" VARCHAR2(10 BYTE), 
    "INSIDE_BUILDING_YN" VARCHAR2(10 BYTE), 
    "REASON_REPORTED_KEY" NUMBER(12,0), 
    "FAIL_DIFF_CMPNY_NTWRK_YN" VARCHAR2(10 BYTE), 
    "DIRECT_CAUSE_KEY" NUMBER(12,0), 
    "SUB_DIRECT_CAUSE_KEY" NUMBER(12,0), 
    "ROOT_CAUSE_KEY" NUMBER(12,0), 
    "SUB_ROOT_CAUSE_KEY" NUMBER(12,0), 
    "LOD_CAUSED_CONTRIBUTED_YN" VARCHAR2(1 BYTE), 
    "TSP_INVOLVED_YN" VARCHAR2(1 BYTE), 
    "MALICIOUS_ACTIVITY_YN" VARCHAR2(1 BYTE), 
    "CABLE_TELEPHONY" VARCHAR2(10 BYTE) DEFAULT '0' CONSTRAINT "NN_SORH2_CABLE_TELEPHONY" NOT NULL ENABLE, 
    "E911" VARCHAR2(10 BYTE) DEFAULT '0' CONSTRAINT "NN_SORH2_E911" NOT NULL ENABLE, 
    "WIRELINE" VARCHAR2(10 BYTE) DEFAULT '0' CONSTRAINT "NN_SORH2_WIRELINE" NOT NULL ENABLE, 
    "WIRELESS_NON_PAGING" VARCHAR2(10 BYTE) DEFAULT '0' CONSTRAINT "NN_SORH2_WIRELESS_NON_PAGING" NOT NULL ENABLE, 
    "SIGNALING_SS7" VARCHAR2(10 BYTE) DEFAULT '0' CONSTRAINT "NN_SORH2_SIGNALING_SS7NOT" NOT NULL ENABLE, 
    "END_USER_CKT_MINUTES" VARCHAR2(10 BYTE) DEFAULT '0' CONSTRAINT "NN_SORH2_END_USER_CKT_MINUTES" NOT NULL ENABLE, 
    "SATELLITE" VARCHAR2(10 BYTE) DEFAULT '0' CONSTRAINT "NN_SORH2_SATELLITE" NOT NULL ENABLE, 
    "PAGING" VARCHAR2(10 BYTE) DEFAULT '0' CONSTRAINT "NN_SORH2_PAGING" NOT NULL ENABLE, 
    "VOIP" VARCHAR2(10 BYTE) DEFAULT '0' CONSTRAINT "NN_SORH2_VOIP" NOT NULL ENABLE, 
    "TRANSPORT_DS3" VARCHAR2(10 BYTE) DEFAULT '0' CONSTRAINT "NN_SORH2_TRANSPORT_DS3" NOT NULL ENABLE, 
    "TRANSPORT_OC3" VARCHAR2(10 BYTE) DEFAULT '0' CONSTRAINT "NN_SORH2_TRANSPORT_OC3" NOT NULL ENABLE, 
    "BLOCKED_CALLS" VARCHAR2(10 BYTE) DEFAULT '0' CONSTRAINT "NN_SORH2_BLOCKED_CALLS" NOT NULL ENABLE, 
    "SPECIAL_FACILITIES" VARCHAR2(10 BYTE) DEFAULT '0' CONSTRAINT "NN_SORH2_SPECIFAL_FACILITIES" NOT NULL ENABLE, 
    "SERVICE_OTHER_DESC" VARCHAR2(500 BYTE), 
    "NO_DIAL_TONE_YN" VARCHAR2(1 BYTE), 
    "TOLL_ISOLATION_YN" VARCHAR2(1 BYTE), 
    "LOSS_OF_DSL_YN" VARCHAR2(1 BYTE), 
    "LOSS_OF_911_YN" VARCHAR2(1 BYTE), 
    "WIRELINE_OTHER_DESC" VARCHAR2(500 BYTE), 
    "INCIDENT_DESC" VARCHAR2(3999 BYTE), 
    "NAME_TYPE_EQ_FAILED" VARCHAR2(3999 BYTE), 
    "NETWORK_INVOLVED" VARCHAR2(3999 BYTE), 
    "DESC_CAUSES" VARCHAR2(3999 BYTE), 
    "RESTORE_METHODS" VARCHAR2(3999 BYTE), 
    "STEPS_PREVENT_REOCCUR" VARCHAR2(3999 BYTE), 
    "BEST_PRACTICE_PREVENTION" VARCHAR2(3999 BYTE), 
    "BEST_PRACTICE_MITIGATE" VARCHAR2(3999 BYTE), 
    "ANALYSIS_OF_BEST_PRACTICE" VARCHAR2(3999 BYTE), 
    "REMARKS_COMMENTS" VARCHAR2(3999 BYTE), 
    "UTILITY_CONTACT_NAME" VARCHAR2(200 BYTE), 
    "UTILITY_CONTACT_EMAIL" VARCHAR2(200 BYTE), 
    "UTILITY_CONTACT_PHONE_NUM" NUMBER(22,0), 
    "UTILITY_CONTACT_EXT" NUMBER(22,0), 
    "INITIAL_FILING_DATE" DATE DEFAULT SYSDATE, 
    "DATE_UPDATED" DATE DEFAULT SYSDATE, 
    "CITY_STR" VARCHAR2(3999 BYTE), 
    "ZIP_CODE_STR" VARCHAR2(3999 BYTE), 
    "COUNTY_STR" VARCHAR2(3999 BYTE), 
    "FACI_CITY_STR" VARCHAR2(3999 BYTE), 
    "FACI_COUNTY_STR" VARCHAR2(3999 BYTE), 
    "GEO_DESC" VARCHAR2(3999 BYTE), 
    "COMPANY_ID" NUMBER, 
     CONSTRAINT "CK_SORH2_MEDIA_ATTN_YN" CHECK (MEDIA_ATTN_YN IN ('Y', 'N')) ENABLE, 
     CONSTRAINT "CK_SORH2_SOE_YN" CHECK (SOE_YN IN ('Y', 'N')) ENABLE, 
     CONSTRAINT "CK_SORH2_INSIDE_BUILDING_YN" CHECK (INSIDE_BUILDING_YN IN ('Y', 'N')) ENABLE, 
     CONSTRAINT "CK_SORH2_FAIL_DIFF_NTWRK_YN" CHECK (FAIL_DIFF_CMPNY_NTWRK_YN IN ('Y', 'N')) ENABLE, 
     CONSTRAINT "CK_SORH2_NO_DIAL_TONE_YN" CHECK (NO_DIAL_TONE_YN IN ('Y', 'N')) ENABLE, 
     CONSTRAINT "CK_SORH2_TOLL_ISOLATION_YN" CHECK (TOLL_ISOLATION_YN IN ('Y', 'N')) ENABLE, 
     CONSTRAINT "CK_SORH2_LOSS_OF_DSL_YN" CHECK (LOSS_OF_DSL_YN IN ('Y', 'N')) ENABLE, 
     CONSTRAINT "CK_SORH2_LOSS_OF_911_YN" CHECK (LOSS_OF_911_YN IN ('Y', 'N')) ENABLE, 
     CONSTRAINT "CK_SORH2_LOD_CAUSED_CONTRI_YN" CHECK (LOD_CAUSED_CONTRIBUTED_YN IN ('Y', 'N')) ENABLE, 
     CONSTRAINT "CK_SORH2_TSP_INVOLVED_YN" CHECK (TSP_INVOLVED_YN IN ('Y', 'N')) ENABLE, 
     CONSTRAINT "CK_SORH2_MALICS_ACTIVITY_YN" CHECK (MALICIOUS_ACTIVITY_YN IN ('Y', 'N')) ENABLE, 
     CONSTRAINT "PK_SORH2_SRV_OTGE_RPT_HIST_KEY" PRIMARY KEY ("SERVICE_OUTAGE_RPT_HIST_KEY")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE, 
     CONSTRAINT "FK_SORH2_E911_LOCATION_KEY" FOREIGN KEY ("E911_LOCATION_KEY")
      REFERENCES "TSQX2"."E911_LOCATION_DICT" ("E911_LOCATION_KEY") ENABLE, 
     CONSTRAINT "FK_SORH2_REASON_RPRTD_KEY" FOREIGN KEY ("REASON_REPORTED_KEY")
      REFERENCES "TSQX2"."REASON_REPORTED_DICT" ("REASON_REPORTED_KEY") ENABLE, 
     CONSTRAINT "FK_SORH2_DIRECT_CAUSE_KEY" FOREIGN KEY ("DIRECT_CAUSE_KEY")
      REFERENCES "TSQX2"."MAIN_OUTAGE_CAUSE_DICT" ("MAIN_OUTAGE_CAUSE_KEY") ENABLE, 
     CONSTRAINT "FK_SORH2_ROOT_CAUSE_KEY" FOREIGN KEY ("ROOT_CAUSE_KEY")
      REFERENCES "TSQX2"."MAIN_OUTAGE_CAUSE_DICT" ("MAIN_OUTAGE_CAUSE_KEY") ENABLE, 
     CONSTRAINT "FK_SORH2_SUB_DRCT_CAUSE_KEY" FOREIGN KEY ("SUB_DIRECT_CAUSE_KEY")
      REFERENCES "TSQX2"."SUB_OUTAGE_CAUSE_DICT" ("SUB_OUTAGE_CAUSE_KEY") ENABLE, 
     CONSTRAINT "FK_SORH2_SUB_RT_CAUSE_KEY" FOREIGN KEY ("SUB_ROOT_CAUSE_KEY")
      REFERENCES "TSQX2"."SUB_OUTAGE_CAUSE_DICT" ("SUB_OUTAGE_CAUSE_KEY") ENABLE, 
     CONSTRAINT "FK_SORH2_REPORT_STATUS_CODE" FOREIGN KEY ("REPORT_STATUS_CODE")
      REFERENCES "TSQX2"."REPORT_STATUS_DICT" ("REPORT_STATUS_CODE") ENABLE, 
     CONSTRAINT "OUTAGE_RPT_HIST_FK" FOREIGN KEY ("FCC_REPORT_NUMBER")
      REFERENCES "TSQX2"."SERVICE_OUTAGE_RPT_2" ("FCC_REPORT_NUMBER") ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;


-- now back to pulling from original scripts


CREATE TABLE tsqx2.service_affected
(
     service_affected_key         NUMBER(12),
     service_outage_rpt_hist_key  NUMBER(12)               CONSTRAINT nn_sa_srvce_outge_rpt_hist_key NOT NULL,
     service_type_key             NUMBER(25)               CONSTRAINT nn_sa_service_type_key         NOT NULL,
     other_desc                   VARCHAR2(500),
     num_users_affected           NUMBER         DEFAULT 0   CONSTRAINT nn_sa_num_users_affected       NOT NULL,
     affected_yn                  VARCHAR2(1)    DEFAULT 'N' CONSTRAINT nn_sa_affected_yn              NOT NULL
);  

COMMENT ON TABLE tsqx2.service_affected IS 'This is a 1 to many relationship. List of all types of services affected per outage report per report status.';
COMMENT ON COLUMN tsqx2.service_affected.service_affected_key IS 'System generated primary key.';
COMMENT ON COLUMN tsqx2.service_affected.service_outage_rpt_hist_key IS 'Foreign key to the service outage report to indicate the type of services that were down during the report status.';
COMMENT ON COLUMN tsqx2.service_affected.service_type_key IS 'Foreign key to the service_type_dict to indicate the type of service affected.';
COMMENT ON COLUMN tsqx2.service_affected.other_desc IS 'If service affected for other is Y, a description is required.';
COMMENT ON COLUMN tsqx2.service_affected.num_users_affected IS 'Indicates the number of users affected.';
COMMENT ON COLUMN tsqx2.service_affected.affected_yn IS 'Value representing Yes(Y)/No(N).';

ALTER TABLE tsqx2.service_affected
ADD(
        CONSTRAINT pk_sa_service_affected_key
        PRIMARY KEY (service_affected_key),
        --
        CONSTRAINT fk_sa_srvce_outge_rpt_hist_key
        FOREIGN KEY (service_outage_rpt_hist_key)
        REFERENCES tsqx2.service_outage_rpt_hist (service_outage_rpt_hist_key),
        --
        CONSTRAINT fk_sa_service_type_key
        FOREIGN KEY (service_type_key)
        REFERENCES tsqx2.service_type_dict (service_type_key),
        --
        CONSTRAINT ck_sa_num_users_affected
        CHECK (num_users_affected >= 0),
        --
        CONSTRAINT ck_sa_affected_yn
        CHECK (affected_yn IN ('Y','N'))
);

---
---
---

CREATE TABLE tsqx2.wireline_affected
(
    wireline_affected_key         NUMBER(12),
    service_outage_rpt_hist_key   NUMBER(12)                 CONSTRAINT nn_wia_srvce_otge_rpt_hist_key NOT NULL,
    wireline_key                  NUMBER(12)                 CONSTRAINT nn_wia_wireline_key NOT NULL,
    other_desc                    VARCHAR2(500),
    affected_yn                   VARCHAR2(1)      DEFAULT 'N' CONSTRAINT nn_wia_affected_yn NOT NULL
);

COMMENT ON TABLE tsqx2.wireline_affected IS 'This is a 1 to many relationship. For each outage histroy, there are wireline srvices affected. This table indicates which wireline service was affected for each report status.';
COMMENT ON COLUMN tsqx2.wireline_affected.wireline_key IS 'System generated primary key';
COMMENT ON COLUMN tsqx2.wireline_affected.service_outage_rpt_hist_key IS 'Indicates the report record that the wireline was affected.';
COMMENT ON COLUMN tsqx2.wireline_affected.wireline_key IS 'Foreign key back to the dictionary to determine the type of wireline that was affected.';
COMMENT ON COLUMN tsqx2.wireline_affected.other_desc IS 'If affected_yn is Y for other, then this field is required.';
COMMENT ON COLUMN tsqx2.wireline_affected.affected_yn IS 'Indicates if the services was affected or not.';

ALTER TABLE tsqx2.wireline_affected
ADD(
        CONSTRAINT pk_wia_wireline_affected_key
        PRIMARY KEY (wireline_affected_key),
        --
        CONSTRAINT fk_wia_srvce_otge_rpt_hist_key
        FOREIGN KEY (service_outage_rpt_hist_key)
        REFERENCES tsqx2.service_outage_rpt_hist (service_outage_rpt_hist_key),
        --
        CONSTRAINT fk_wia_wireline_key
        FOREIGN KEY (wireline_key)
        REFERENCES tsqx2.wireline_dict (wireline_key),
        --
        CONSTRAINT ck_wia_affected_yn
        CHECK (affected_yn IN ('Y','N'))
);

----
----
----

CREATE TABLE tsqx2.rpt_comment
(
     rpt_comment_key             NUMBER(12),
     service_outage_rpt_hist_key NUMBER(12)                    CONSTRAINT nn_rc_srvce_outge_rpt_key NOT NULL,
     comments                    VARCHAR2(500)                   CONSTRAINT nn_rc_comments NOT NULL,
     comment_date                DATE           DEFAULT SYSDATE  CONSTRAINT nn_rc_comment_date NOT NULL
);

COMMENT ON TABLE tsqx2.rpt_comment IS 'Comments on the report.';
COMMENT ON COLUMN tsqx2.rpt_comment.rpt_comment_key IS 'System generated primary key';
COMMENT ON COLUMN tsqx2.rpt_comment.service_outage_rpt_hist_key IS 'Foreign key to the history record.';
COMMENT ON COLUMN tsqx2.rpt_comment.comments IS 'Comments on the record.';
COMMENT ON COLUMN tsqx2.rpt_comment.comment_date IS 'Date of whent the comment was made.';

ALTER TABLE tsqx2.rpt_comment
ADD(
        CONSTRAINT pk_rc_rpt_comment_key
        PRIMARY KEY (rpt_comment_key),
        --
        CONSTRAINT fk_rc_srvce_out_rpt_hist_key
        FOREIGN KEY (service_outage_rpt_hist_key)
        REFERENCES tsqx2.service_outage_rpt_hist (service_outage_rpt_hist_key)
);

CREATE TABLE tsqx2.utility_contact
(
    utility_contact_key           NUMBER(12),
    service_outage_rpt_key        NUMBER(12)       CONSTRAINT nn_uc_service_outage_rpt_key NOT NULL,
    contact_name                  VARCHAR2(200)      CONSTRAINT nn_uc_contact_name           NOT NULL,
    phone_num                     NUMBER(10),
    ext                           NUMBER(5),
    email                         VARCHAR2(200)      CONSTRAINT nn_uc_email                  NOT NULL
);

COMMENT ON TABLE tsqx2.utility_contact IS 'Contains contact information for each outage report.';
COMMENT ON COLUMN tsqx2.utility_contact.service_outage_rpt_key IS 'Links the contact back to the service outage report.';
COMMENT ON COLUMN tsqx2.utility_contact.contact_name IS 'Name of the contact.';
COMMENT ON COLUMN tsqx2.utility_contact.phone_num IS 'Phone number to the contact.';
COMMENT ON COLUMN tsqx2.utility_contact.ext IS 'Extension to the phone number.';
COMMENT ON COLUMN tsqx2.utility_contact.email IS 'Email of the contact.';

ALTER TABLE tsqx2.utility_contact
ADD(
        CONSTRAINT pk_uc_utility_contact_key
        PRIMARY KEY (utility_contact_key),
        --
        CONSTRAINT fk_uc_service_out_rpt_key
        FOREIGN KEY (service_outage_rpt_key)
        REFERENCES tsqx2.service_outage_rpt (service_outage_rpt_key)
);

CREATE TABLE tsqx2.service_outage_notes
(
    service_outage_notes_key         NUMBER(12),  
    service_outage_rpt_hist_key      NUMBER(12),
    incident_desc                    VARCHAR2(3999),
    name_type_eq_failed              VARCHAR2(3999),
    network_involved                 VARCHAR2(3999),
    desc_causes                      VARCHAR2(3999),
    restore_methods                  VARCHAR2(3999),
    steps_prevent_reoccur            VARCHAR2(3999),
    best_practice_prevention         VARCHAR2(3999),
    best_practice_mitigate           VARCHAR2(3999),
    analysis_of_best_practice        VARCHAR2(3999),
    remarks_comments                 VARCHAR2(3999)
);

COMMENT ON TABLE tsqx2.service_outage_notes IS 'Contains all the notes of the outage.';
COMMENT ON COLUMN tsqx2.service_outage_notes.service_outage_notes_key IS 'System generated primary key.';
COMMENT ON COLUMN tsqx2.service_outage_notes.incident_desc IS 'Description of the incident.';
COMMENT ON COLUMN tsqx2.service_outage_notes.name_type_eq_failed IS 'Name and type of equipment that failed and caused the outage.';
COMMENT ON COLUMN tsqx2.service_outage_notes.network_involved IS 'Lists the specific parts of the network which failed.';
COMMENT ON COLUMN tsqx2.service_outage_notes.desc_causes IS 'Description of the caused outage. Why, how, when';
COMMENT ON COLUMN tsqx2.service_outage_notes.restore_methods IS 'Lists the methods used to restore service.';
COMMENT ON COLUMN tsqx2.service_outage_notes.steps_prevent_reoccur IS 'Lists the steps to prevent the same type of outage from happening again.';
COMMENT ON COLUMN tsqx2.service_outage_notes.best_practice_prevention IS 'Lists the best practices that could prevent the incident from happening.';
COMMENT ON COLUMN tsqx2.service_outage_notes.best_practice_mitigate IS 'Lists the best practices that could mitigate the effects of the outage.';
COMMENT ON COLUMN tsqx2.service_outage_notes.analysis_of_best_practice IS 'This is the complete analysis of the best practices.';
COMMENT ON COLUMN tsqx2.service_outage_notes.remarks_comments IS 'Any additional comments/remarks can be made here.';
COMMENT ON COLUMN tsqx2.service_outage_notes.service_outage_rpt_hist_key IS 'Foreign key to indicate the history record it is tied to.';

ALTER TABLE tsqx2.service_outage_notes
ADD(
        CONSTRAINT pk_son_service_out_notes_key
        PRIMARY KEY (service_outage_notes_key),
        --
        CONSTRAINT fk_son_srvce_out_rpt_hist_key
        FOREIGN KEY (service_outage_rpt_hist_key)
        REFERENCES tsqx2.service_outage_rpt_hist (service_outage_rpt_hist_key)
);

--#success
  CREATE TABLE "TSQX2"."SERVICE_OUTAGE_CITY" 
   (    "SERVICE_OUTAGE_CITY_KEY" NUMBER(12) GENERATED BY DEFAULT ON NULL AS IDENTITY, 
    "SERVICE_OUTAGE_RPT_HIST_KEY" NUMBER(12), 
    "CITY_NAME_KEY" VARCHAR2(12), 
     CONSTRAINT "PK_SOCI_SRVCE_OTGE_CITY_KEY" PRIMARY KEY ("SERVICE_OUTAGE_CITY_KEY"),
     CONSTRAINT "FK_SOCI_SRVCE_OTGE_RPT_HST_KEY" FOREIGN KEY ("SERVICE_OUTAGE_RPT_HIST_KEY")
      REFERENCES "TSQX2"."SERVICE_OUTAGE_RPT_HIST" ("SERVICE_OUTAGE_RPT_HIST_KEY")
   );

/

--#success

  CREATE TABLE "TSQX2"."SERVICE_OUTAGE_COUNTY" 
   (    "SRVCE_OTGE_COUNTY_KEY" NUMBER(12) GENERATED BY DEFAULT ON NULL AS IDENTITY, 
    "SERVICE_OUTAGE_RPT_HIST_KEY" NUMBER(12), 
    "ZIP_COUNTY_KEY" VARCHAR2(12), 
     CONSTRAINT "PK_SOCO_SRVE_OTGE_COUNTY_KY" PRIMARY KEY ("SRVCE_OTGE_COUNTY_KEY"),
     CONSTRAINT "FK_SOCO_SRVE_OTGE_RPT_HST_KY" FOREIGN KEY ("SERVICE_OUTAGE_RPT_HIST_KEY")
      REFERENCES "TSQX2"."SERVICE_OUTAGE_RPT_HIST_2" ("SERVICE_OUTAGE_RPT_HIST_KEY")
   );

/
--#success
  CREATE TABLE "TSQX2"."SERVICE_OUTAGE_FACILITY_CITY" 
   (    "SRVCE_OTGE_FACILITY_CTY_KEY" NUMBER(12) GENERATED BY DEFAULT ON NULL AS IDENTITY, 
    "SERVICE_OUTAGE_RPT_HIST_KEY" NUMBER(12), 
    "FACILITY_CITY_NAME_KEY" VARCHAR2(12), 
     CONSTRAINT "PK_SOFCI_SRVE_OTGE_FACL_CTY_KY" PRIMARY KEY ("SRVCE_OTGE_FACILITY_CTY_KEY"),
     CONSTRAINT "FK_SOFCI_SRVE_OTGE_RPT_HST_KY" FOREIGN KEY ("SERVICE_OUTAGE_RPT_HIST_KEY")
      REFERENCES "TSQX2"."SERVICE_OUTAGE_RPT_HIST_2" ("SERVICE_OUTAGE_RPT_HIST_KEY")
   );

/
--#success

  CREATE TABLE "TSQX2"."SERVICE_OUTAGE_FACILITY_COUNTY" 
   (    "SRVCE_OTGE_FACILITY_COUNTY_KEY" NUMBER(12) GENERATED BY DEFAULT ON NULL AS IDENTITY, 
    "SERVICE_OUTAGE_RPT_HIST_KEY" NUMBER(12), 
    "ZIP_COUNTY_KEY" VARCHAR2(12), 
     CONSTRAINT "PK_SOFC_SRVE_OTGE_FACI_CNTY_KY" PRIMARY KEY ("SRVCE_OTGE_FACILITY_COUNTY_KEY"),
     CONSTRAINT "FK_SOFC_SRVE_OTGE_RPT_HST_KY" FOREIGN KEY ("SERVICE_OUTAGE_RPT_HIST_KEY")
      REFERENCES "TSQX2"."SERVICE_OUTAGE_RPT_HIST_2" ("SERVICE_OUTAGE_RPT_HIST_KEY")
   );

/
--#success

  CREATE TABLE "TSQX2"."SERVICE_OUTAGE_ZIP_CODE" 
   (    "SERVICE_OUTAGE_ZIP_CODE_KEY" NUMBER(12) GENERATED BY DEFAULT ON NULL AS IDENTITY, 
    "SERVICE_OUTAGE_RPT_HIST_KEY" NUMBER(12), 
    "ZIP_CODE_KEY" NUMBER(12), 
     CONSTRAINT "PK_SOZC_SRVE_OTGE_FACI_CNTY_KY" PRIMARY KEY ("SERVICE_OUTAGE_ZIP_CODE_KEY"),
     CONSTRAINT "FK_SOZC_SRVE_OTGE_RPT_HST_KY" FOREIGN KEY ("SERVICE_OUTAGE_RPT_HIST_KEY")
      REFERENCES "TSQX2"."SERVICE_OUTAGE_RPT_HIST_2" ("SERVICE_OUTAGE_RPT_HIST_KEY")
   );




   create or replace function get_pk
    return number 
    is 
    a number; 
    begin
    select round(dbms_random.value(1,1000000)) rnum
    into a 
    from dual;
    return a;
    end;

CREATE OR REPLACE FUNCTION "TSQX2"."GET_PK"

RETURN number
AS
A number;
BEGIN
  select round(dbms_random.value(1,1000000)) rnum into A from dual;
  RETURN A;
END;
   
--sample function call    
select get_pk from dual;

