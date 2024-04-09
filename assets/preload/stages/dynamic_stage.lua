-- among us engine changing stage :DD

local cameras = { -- camera positions
	polus = {
		xx =  470,
		yy =  250,
		xx2 = 820,
		yy2 = 250,
		ofs = 20,
		followchars = true,
		defCamZoom1 = .75,
		defCamZoom2 = .75
	},
	toogus = {
		xx =  500,
		yy =  475,
		xx2 = 900,
		yy2 = 475,
		ofs = 20,
		followchars = true,
		defCamZoom1 = .9,
		defCamZoom2 = .9
	},
	defeat = {
        xx = 500,
        yy = 500,
        xx2 = 900,
        yy2 = 500,
		ofs = 20,
		followchars = true,
		defCamZoom1 = .6,
		defCamZoom2 = .6
	}
}
local positions = { -- chars positions
	polus = {
		boyfriend = {870, -150},
		gf = {300, -120},
		dad = {0, -150}
	},
	toogus = {
		boyfriend = {970, 50},
		gf = {400, 80},
		dad = {0, 50},
	},
	defeat = {
		boyfriend = {1000, 100},
		gf = {400, 100},
		dad = {210, 100}
	}
}
local luaCurStage = 'defeat' -- current stage, change here to change default stage
-- oh also all names will be in lower case and you cant do anything about that >:)
local spritestoremove = {} -- dont touch them they are shy
local spritestoadd = {}

-- new funcs!!!!!!!!
function onChangeStage(stage, luaCurStage, snapcampos, snapzoom)
	if stage == 'defeat' then
		setPropertyFromClass('GameOverSubstate', 'characterName', 'bf-defeat-dead')
		setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'defeat_kill_sfx')
	else
		setPropertyFromClass('GameOverSubstate', 'characterName', 'genericdeath')
		setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'fnf_loss_sfx')
	end
end
function onChangeStagePost(stage, luaCurStage, snapcampos, snapzoom)
	--meh
end
function onBeatHit() -- add here some stuff if you need
	if luaCurStage == 'defeat' then if curBeat%4 == 0 then objectPlayAnimation('defeatthing','bop', true) end end
end
-- if you need to add something in onUpdate then its in the bottom of the script, rn theres only camera module
-- btw use event named "change stage" and fill value1 with the stage name
-- alsooo dont leave functions that the game calls empty cuz this is old ass v0.2.7 psych so it crashes

function onStartCountdown() -- dw it’s essentially onCreatePost, the only catch is that "onCreatePost" doesn’t exist
	-- you can add your stages here
	-- basically, paste your lua stage code here
	-- after making your stage's code end it with spritestoadd.['stageName'] = {'list_of_your_sprites'}
	-- also if your sprite should be not visible then dont add it in list and hide/unhide it manually using onChangeStage/Post funcs if you need to
	
	-- polus
	local pf = '../../impostor/images/polus/'
	makeLuaSprite('sky', pf..'polus_custom_sky', -400, -400)
	setScrollFactor('sky', .5,.5)
	shitObject('sky', 1.4)
	addLuaSprite('sky')
	makeLuaSprite('rocks', pf..'polusrocks', -700, -300)
	setScrollFactor('rocks', .6,.6)
	addLuaSprite('rocks')
	makeLuaSprite('hills', pf..'polusHills', -1050, -180.55)
	setScrollFactor('hills', .9,.9)
	addLuaSprite('hills')
	makeLuaSprite('warehouse', pf..'polus_custom_lab', 50, -400)
	addLuaSprite('warehouse')
	makeLuaSprite('ground', pf..'polus_custom_floor', -1350, 80)
	addLuaSprite('ground')
	makeAnimatedLuaSprite('snow', pf..'snow', 0,-250)
	addAnimationByPrefix('snow', 'cum', 'cum', 24, true)
	objectPlayAnimation('snow', 'cum', true)
	shitObject('snow', 2)
	addLuaSprite('snow', true)
	spritestoadd.polus = {'sky', 'rocks', 'hills', 'warehouse', 'ground', 'snow'}

	-- toogus
	makeLuaSprite('bg', 'mirabg',-1600, 50)
	shitObject('bg', 1.06)
	addLuaSprite('bg')
	makeLuaSprite('fg', 'mirafg',-1600, 50)
	shitObject('fg', 1.06)
	addLuaSprite('fg')
	makeLuaSprite('tbl', 'table_bg', -1600, 50)
	shitObject('tbl', 1.06)
	addLuaSprite('tbl')
	spritestoadd.toogus = {'bg', 'fg', 'tbl'}
	
	-- defeat
	makeAnimatedLuaSprite('defeatthing', 'defeat', -400, -150)
	addAnimationByPrefix('defeatthing', 'bop', 'defeat', 24,false)
	objectPlayAnimation('defeatthing','bop', true)
	shitObject('defeatthing', 1.3)
	addLuaSprite('defeatthing')
	makeLuaSprite('bodies2', 'lol thing', -500, 150)
	shitObject('bodies2', 1.3)
	setScrollFactor('bodies2', .9,.9)
	addLuaSprite('bodies2')
	makeLuaSprite('bodies', 'deadBG', -2760, 0)
	shitObject('bodies', .4)
	setScrollFactor('bodies', .9,.9)
	addLuaSprite('bodies')
	makeLuaSprite('bodiesfront', 'deadFG', -2830, 0)
	shitObject('bodiesfront', .4)
	setScrollFactor('bodiesfront', .5,1)
	addLuaSprite('bodiesfront', true)
	makeLuaSprite('lightoverlay', 'iluminao omaga',-550, -100)
	setBlendMode('lightoverlay', 'ADD')
	addLuaSprite('lightoverlay', true)
	spritestoadd.defeat = {'defeatthing', 'bodies2', 'bodies', 'bodiesfront', 'lightoverlay'}

	-- dont touch anything below please

	lowerkeys(cameras)
	lowerkeys(positions)
	lowerkeys(spritestoadd)
	for s,e in pairs(spritestoadd) do
		for x = 1, #e do
			setProperty(e[x]..'.visible', false)
		end
	end
	luaCurStage = luaCurStage:lower()
	if quickCheck(luaCurStage) then changeStage(luaCurStage) else for i in pairs(spritestoadd) do if quickCheck(i) then changeStage(i); return end end
		debugPrint('...')
		debugPrint('what the fuck bro why dont you have ANY WORKING STAGE LIKE ACTUALLY WHAT THE FUCK ARE YOU THINKING ABOUT IS THAT SOME KIND OF JOKE FOR YOU OR WHAT YOU FUCKING ASIUKYLJRHGFRLFQWEJRRGFWQEF')
		debugPrint('...')
		debugPrint('closing the stage script...')
		close(false)
	end
end
function shitObject(obj,scale)
	setProperty(obj..'.scale.x', scale); setProperty(obj..'.scale.y', scale)
end
function lowerkeys(table)
	for i,e in pairs(table) do
		if type(i) == 'string' and i:lower() ~= i then
			table[i:lower()] = e
			table[i] = nil
		end
	end 
end
function quickCheck(stage)
	local fine = true
	if not cameras[stage] then
		debugPrint(stage .. " doesnt have camera data! (add "..stage.." and its camera data in 'cameras' table)")
		fine = false
	end
	if not positions[stage] then
		debugPrint(stage .. " doesnt have positions data! (add "..stage.." and its positions data in 'positions' table)")
		fine = false
	end
	if not spritestoadd[stage] then
		debugPrint(stage .. "'s sprites table doesnt have anything! (add spritestoadd.['"..stage.."'] = {'srites_list'} after "..stage.."'s code in onCreate)")
		fine = false
	end
	return fine
end
function changeStage(stage, snapcampos, snapzoom)
	stage = stage:lower()
	if not quickCheck(stage) then return end
	onChangeStage(stage, luaCurStage, snapcampos, snapzoom)
	snapzoom = snapzoom or true
	if snapzoom then setProperty('camGame.zoom', cameras[stage][mustHitSection and 'defCamZoom1' or 'defCamZoom2']) end
	snapcampos = snapcampos or true
	local camposshit = {}
	local g = mustHitSection and '2' or ''
	if snapcampos then camposshit = {cameras[luaCurStage]['xx'..g]-getProperty('camFollowPos.x'),cameras[luaCurStage]['yy'..g]-getProperty('camFollowPos.y')} end
	if spritestoremove then for i = 1, #spritestoremove do setProperty(spritestoremove[i]..'.visible', false) end end
	if camposshit then setProperty('camFollowPos.x', cameras[stage]['xx'..g]-camposshit[1]); setProperty('camFollowPos.y', cameras[stage]['yy'..g]-camposshit[2]) end
	for i, e in pairs(positions[stage]) do setProperty(i..'Group.x', e[1]); setProperty(i..'Group.y', e[2]) end
	for i,e in pairs(spritestoadd[stage]) do setProperty(e..'.visible', true)end
	spritestoremove = spritestoadd[stage]
	onChangeStagePost(stage, luaCurStage, snapcampos, snapzoom)
	luaCurStage = stage
end
function onEvent(n,v1,v2)
	if n == 'change stage' then
		changeStage(v1:lower())
	end
end
-- brand new sexy cam shit
function onUpdate(elapsed)
	camthings = {
		boyfriend = {
			singLEFT = {cameras[luaCurStage].xx2-cameras[luaCurStage].ofs,cameras[luaCurStage].yy2},
			singRIGHT = {cameras[luaCurStage].xx2+cameras[luaCurStage].ofs,cameras[luaCurStage].yy2},
			singUP = {cameras[luaCurStage].xx2,cameras[luaCurStage].yy2-cameras[luaCurStage].ofs},
			singDOWN = {cameras[luaCurStage].xx2,cameras[luaCurStage].yy2+cameras[luaCurStage].ofs},
			idle = {cameras[luaCurStage].xx2,cameras[luaCurStage].yy2}
		},
		dad = {
			singLEFT = {cameras[luaCurStage].xx-cameras[luaCurStage].ofs,cameras[luaCurStage].yy},
			singRIGHT = {cameras[luaCurStage].xx+cameras[luaCurStage].ofs,cameras[luaCurStage].yy},
			singUP = {cameras[luaCurStage].xx,cameras[luaCurStage].yy-cameras[luaCurStage].ofs},
			singDOWN = {cameras[luaCurStage].xx,cameras[luaCurStage].yy+cameras[luaCurStage].ofs},
			idle = {cameras[luaCurStage].xx,cameras[luaCurStage].yy}
		}
	}
	if cameras[luaCurStage].followchars == true then
		setProperty('defaultCamZoom',cameras[luaCurStage]['defCamZoom' .. (mustHitSection and '1' or '2')])
		local balls = mustHitSection and 'boyfriend' or 'dad'
		local dick = camthings[balls][getProperty(balls..'.animation.curAnim.name')] or camthings[balls].idle
		triggerEvent('Camera Follow Pos',dick[1], dick[2])
	else
		triggerEvent('Camera Follow Pos','','')
	end
end