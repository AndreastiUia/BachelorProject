extends Node

var prog_tooltips = ["Move one tile left.",
	"Move one tile right.",
	"Move one tile up.",
	"Move one tile down.",
	"Move to a specific position on the map, if the posistion is uncovered and not occupied by a resource or the base.",
	"Start of a while-loop, this will repeat the functions between the WHILE and WHILE_END until the conditions is no longer met, or the loop is broken with the WHILE_BREAK.",
	"Break out of the current while-loop.",
	"Use this to create an IF-statement, this will check if a selected statement is TRUE and only then run the program between the IF and next IF_END.",
	"Collect one resource of an adjacent resourse, if there is any. The bot will only collect one item for each time this command is ran.",
	"Deliver one resource if the bot is standing next to the base. The bot will only collect one item for each time this command is ran.",
	"Repair the bot. NOTE: The bot HAS to be next to the base to be repaired."
	]
