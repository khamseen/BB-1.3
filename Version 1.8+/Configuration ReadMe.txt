ALL SETTINGS DISCUSSED HERE ARE LOCATED IN missionFolder\dayz_code\init\variables.sqf
This file just provides a more details explanation of what these variables do.

****BBSuperAdminAccess****
Any playerUIDs added to this array will have full access to all Base Building items.
Admins can access any built item even if they aren't registered to use it (if they are not registered, the options will be prefixed with ADMIN:)

Admins also have the ability to add/remove player UIDs from objects they do not own so they can offer assistance to players.
Be careful with whom you give this access to as it is a very powerful function and you don't want to give it to people you don't fully trust.

****BBTypeOfFlag****
Default Value: "FlagCarrierBIS_EP1"

This tells the server what flag type to use for base building.
If you change this after flags have already been built, then the existing flags will be updated at the next restart.
Available options for this variable are listed in BBAllFlagTypes.

****BBAllFlagTypes****
This is a full list of possible flags for Base Building to use. Only one may be used at a time and is set via the above variable.
If you want to add a flag which isn't already listed, then you will need to add it to this array, aswell as to BBTypeOfFlag. 
You will also need to add a picture for it in missionFolder\buildRecipeBook\images\buildable\
Plus, you will need to add the new flag type to the SafeObjects array and to your Database.

****BBMaxPlayerFlags****
Default Value: 3

This variable sets how many base building flags a player can be added to.
This includes flags they build themselves, and flags their friends have added them to.

****BBFlagRadius****
Default Value: 200

This sets the radius around a flag in which players can build.
It is advisable not to set this too high because other people cannot build within this radius unless they are added to the flag.
Also, keep in mind that with a radius of 200, the next nearest flag would have to be 400 meters away.

****BBAIGuards****
Default Value: 0

This setting enables AI base guards. (REQUIRES SARGE AI, only tested with v1.5.0, no support will be given for previous versions)
Guard numbers increase with the size of the base around the flag, minimum number of guards is 3, maximum is 6.
These numbers can be adjusted in missionFolder\Addons\SARGE\SAR_init_Base_guards.sqf

Default guard behaviour is to attack anybody in range who is not added to the flag.
Players can toggle this behaviour so the guards will only attack people who attack them, this means they could still have people visit their base for trading or what not.

****BBUseTowerLights****
Default Value: 1

Thanks to AxeMan's tower lighting script, we've added the ability for players to build light towers in their base. If they also build a generator they can then toggle the tower lighting on or off. 

If you already run AxeMan's Illuminant Tower Lighting script, it will interfere with this so you should set this value to 0.

****BBCustomDebug****
Default Value: "debugMonitor"
This is a 'special' variable.

If you run a custom debug monitor which has a toggle function, you need to replace debugMonitor with the variable used by your specific debug monitor.

To find the name of this value, open your custom debug monitor file
Now near the top there should be a line something like this

while {ImportantVariableNameHere} do

Simply copy that variable name to the BBCustomDebug

This allows Base Building to hide your custom debug monitor when it needs to display hint windows for building, adding/removing UIDs, etc. 

If you do not run a custom debug monitor, you don't need to edit this line.
If you run a custom debug monitor which does not have a toggle option, you will experience flashing hint windows when building, adding/removing UIDs, etc. 