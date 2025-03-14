/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * [L4D(2)] AFK and Join Team Commands (1.1)                                     *
 * MODIFED BY QUETZAL FOR Q! SERVERS                                                                            *
 * V 1.1 - Easy Editing and Changelog.                                           *
 * Added a changelog on this topic and in the .SP file.                          *
 * Added a editing guide for adding/removing commands in the .SP file.           *
 *                                                                               *
 * V 1.0 - Initial Release :                                                     *
 * Changelog starts here on the .SP file and on the site.                        *
 *                                                                               *
 * V Beta - Tested on my server:                                                 *
 * Creating/Testing the plugin on my server and in PawnStudio.                   *
 *                                                                               *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * EDITING THE COMMANDS:                                                         *
 * Scroll down a bit, and you'll see for example a line like this:               *
 *                                                                               *
 * "RegConsoleCmd("sm_afk", AFKTurnClientToSpectate);"                           *
 *                                                                               *
 * Broken apart:                                                                 *
 * "RegConsoleCmd" The command to make a command.                                *
 * "("sm_afk"...                                                                 *
 * "sm_afk" is the command, anything which you type in chat with a '!' or        *
 * "/" before it MUST start with "sm_", after "sm_" you put the word.            *
 * Example: "sm_imgoingtospectate", if you wanna use that command,               *
 * you have to type "!imgoingtospectate" in the console.                         *
 *                                                                               *
 * Yet, after "("sm_afk"" there's something else...                              *
 * "("sm_afk", AFKTurnClientToSpectate);                                         *
 * If you look deeper into the code, you see:                                    *
 * public Action:AFKTurnClientToSpectate(client, argCount)                       *
 * What's between the '(' and ')' doesn't matter for you.                        *
 * Basicly, "AFKTurnClientToSpectate" if a name to forward to.                   *
 * You have:                                                                     *
 *                                                                               *
 * -AFKTurnClientToSpectate : Moves the client to spectator team.                *
 * -AFKTurnClientToSurvivors : Moves the client to infected team.                *
 * -AFKTurnClientToInfected : Moves the client to survivors team.                *
 *                                                                               *
 * So, you want for example, when you type "!imgoingafk" in chat,                *
 * you want to go spectate...                                                    *
 *                                                                               *
 * RegConsoleCmd ("sm_imgoingafk", AFKTurnClientToSpectate);                     *
 * Remember to place the ';' behind it!                                          *
 *                                                                               *
 * Now you want, when you type "!iwannaplayinfected" in chat,                    *
 * you want to go infected...                                                    *
 *                                                                               *
 * RegConsoleCmd ("sm_iwannaplayinfected", AFKTurnClientToInfected);             *
 * Again, make sure to place the ';' behind it.                                  *
 *                                                                               *
 * So, that's how to custimize it! Have fun with this, and                       *
 * when you like it, please leave behind a message on the forum topic.           *
 *                                                                               *
 * Remember, editing it correctly is safe, check if your line is like the others *
 * and you'll be fine, after editing, go to:                                     *
 * "MODDIR/addons/sourcemod/scripting" and paste the .SP file in there.          *
 * Then drag the .SP file into "compile.exe" and let it compile.                 *
 * Then go to the "compiled" folder and voilla, your edited plugin is there!     *
 *                                                                               *
 * NOTE: if you edit the plugin wrong, it won't compile or with errors...        *
 * * * * * *                                                           * * * * * *
 * NOTE: This is CASE-SENSITIVE!                                                 *
 * so: "!ImGoingToSpectate" isn't the same as "!imgoingtospectate"...            *
 * And doing so won't make it work...                                            *
 * Since people like to type everything in Lower-Case, i'd advise you to do too. *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * End of Commentry, editing behind these few lines may lead to a non working,   *
 * unstable plugin causing crashes or  bugs, editing at own risk.                *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#define PLUGIN_VERSION    "1.1"
#define PLUGIN_NAME       "[L4D(2)] AFK and Join Team Commands"

#include <sourcemod>

public Plugin:myinfo =
{
	name = PLUGIN_NAME,
	author = "MasterMe",
	version = PLUGIN_VERSION,
	url = "http://forums.alliedmods.net/showthread.php?t=122476"
};

public OnPluginStart()
{
	CreateConVar("afk_spectate_commands_version", PLUGIN_VERSION, "Lasersight plugin version", FCVAR_PLUGIN|FCVAR_SPONLY|FCVAR_NOTIFY|FCVAR_DONTRECORD);

	RegConsoleCmd("spectate", AFKTurnClientToSpectate); //SPECTATE COMMAND
	RegConsoleCmd("survivors", AFKTurnClientToSurvivors); //JOIN SURVIVORS COMMAND
	RegConsoleCmd("infected", AFKTurnClientToInfected); // JOIN INFECTED COMMAND
	RegConsoleCmd("afk", AFKTurnClientToSpectate); //SPETATE CMD
}

public Action:AFKTurnClientToSpectate(client, argCount)
{
	ChangeClientTeam(client, 1)
	PrintToChat(client, "You can change back to your team with '!infected' or '!survivors'");
	return Plugin_Handled;
}


public Action:AFKTurnClientToSurvivors(client, args)
{
	ClientCommand(client, "jointeam 2");
	PrintToChat(client, "You have joined the survivor team succesfully.")
	return Plugin_Handled;

}
public Action:AFKTurnClientToInfected(client, args)
{
	ClientCommand(client, "jointeam 3");
	PrintToChat(client, "You have joined the infected team succesfully.")
	return Plugin_Handled;
}
