diag_log format ["############## %1 ############## - AIS init started", missionName];

if (isServer) then {
	ais_ace_shutDown = false;
	if (isClass (configFile >> "CfgPatches" >> "ace_medical")) then {
		ais_ace_shutDown = true;
		["AIS: AIS shutdown itself cause ACE medical system is also running. ACE medical and AIS cant work at the same time."] call BIS_fnc_logFormat;
	};
	publicVariable "ais_ace_shutDown";
};

if (!isNil "AIS_Core_3DEHId") then {
	removeMissionEventHandler ["Draw3D", AIS_Core_3DEHId];
};

if (!isNil "AIS_Core_eachFrameHandlerId") then {
	removeMissionEventHandler ["EachFrame", AIS_Core_eachFrameHandlerId];
};

// Array of FirstAidKit classnames
AIS_FAK_ITEMS = "true" configClasses (configFile >> "CfgWeapons") select {getNumber (_x >> "ItemInfo" >> "type") == 401} apply {
	configName _x
};
// Array of Medikit classnames
AIS_MEDIKIT_ITEMS = "true" configClasses (configFile >> "CfgWeapons") select {getNumber (_x >> "ItemInfo" >> "type") == 619} apply {
	configName _x
};

AIS_ALL_HEALING_ITEMS = AIS_FAK_ITEMS + AIS_MEDIKIT_ITEMS;


call AIS_Core_fnc_initEvents;
AIS_Core_Interaction_Actions = [];
