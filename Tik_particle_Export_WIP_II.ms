/*
TODO LIST

- Chcekbox valuelari icin stringi yazan bir function.

- Attribute isimleri
   position
   velocity
   rotation
   rgb --> rgbPP
   lifespan --> lifespanPP
   age
   scale
   
MENU Yapilacak
   - Checkbox kontrolu = Data yoksa checkbox uyarisi versin.
   - rgpPP
   - Progressbar

*/

(

--Variables
local positionIsOn = True
local velocityIsOn = True
local rotationIsOn = True
local ageIsOn = False
local scaleIsOn = False

local HeaderStringA=""
local HeaderStringB=""
local LineValue=""
local particleSystem
local AllParticles=0
local sources

local particlePositionVect=[0,0,0]
local particleVel=[0,0,0]
local particleRot=[0,0,0]
local particleAgeX=0
local particleSca=[0,0,0]
	
local R1=animationRange.start.frame as integer
local R2=animationRange.end.frame as integer
local SavePath = GetDir #scene
local Filename
if selection.count == 1 then
(Filename=$.name)
else
(Filename = maxFileName)



--Function to write the header
fn HeadValuer TotalParticles=
(
	HeaderStringA = "id"
	HeaderStringB = "I"
	
	--HEADER CORRECTION
	if positionIsOn == True then --Position
	(
		HeaderStringA=HeaderStringA+" position"
		HeaderStringB=HeaderStringB+" V"
	)

	if velocityIsOn == True then --Velocity
	(
		HeaderStringA=HeaderStringA+" velocity"
		HeaderStringB=HeaderStringB+" V"
	)
	
	if rotationIsOn == True then --Rotation
	(
		HeaderStringA=HeaderStringA+" rotation"
		HeaderStringB=HeaderStringB+" V"
	)
	
	if ageIsOn == True then --Age
	(
		HeaderStringA=HeaderStringA+" age"
		HeaderStringB=HeaderStringB+" R"
	)
	
	if scaleIsOn == True then --Scale
	(
		HeaderStringA=HeaderStringA+" scalePP"
		HeaderStringB=HeaderStringB+" V"
	)
	--return HeaderStringA
	
		HeaderFormat="ATTRIBUTES\n"+HeaderStringA+"\n"+"TYPES\n"+HeaderStringB+"\n"+"NUMBER_OF_PARTICLES: "+(TotalParticles as string)+"\n"+"BEGIN DATA"
	return HeaderFormat
	
)

----------------------------------------------------------------------------------------------------------------------------------------------
-- Function to write the data
fn lineValuer currentID =
(
	--Get the particle
	lineValue=((currentID-1) as string)
	
	if positionIsOn == True then --Position
	(
	particlePositionVect=particleSystem.getParticlePositionByID currentID
	lineValue=lineValue+" "+(particlePositionVect.x as string)+(" ")+(particlePositionVect.y as string)+(" ")+(particlePositionVect.z as string)
	)

	if velocityIsOn == True then --Velocity
	(
	particleVel=particleSystem.getParticleSpeedByID currentID
	lineValue=lineValue+" "+(particleVel.x as string)+(" ")+(particleVel.y as string)+(" ")+(particleVel.z as string)
	)
	
	if rotationIsOn == True then --Rotation
	(
	particleRot=particleSystem.getParticleOrientationByID currentID
	lineValue=lineValue+" "+((radToDeg particleRot.x) as string)+(" ")+((radToDeg particleRot.y) as string)+(" ")+((radToDeg particleRot.z) as string)
	)
	
	if ageIsOn == True then --Age
	(
	particleAgeX=((particleSystem.getParticleAgeByID currentID as float)/TicksPerFrame)
	lineValue=lineValue+" "+(particleAgeX as string)
	)
	
	if scaleIsOn == True then --Scale
	(
	particleSca=particleSystem.getParticleScaleXYZByID currentID
	lineValue=lineValue+" "+(particleSca.x as string)+(" ")+(particleSca.y as string)+(" ")+(particleSca.z as string)
	)
	

	return lineValue
	
)


		
global PDA_Exporter
try(destroyDialog PDA_Exporter)catch()
rollout PDA_Exporter "PDA Exporter"
(
dropDownList ddlPflowSource "" width:140
label l1 "Export Path" align:#left
edittext path_text ""  readonly:true  width:220 across:2
button browse "Browse" enabled:true offset:[45,0] height:18
edittext filename_text "File Name" enabled:true	

Spinner R1sp "Range Start" type:#integer range:[-99999999,99999999,R1] align:#center fieldwidth:45 --across:2
Spinner R2sp "Range End" type:#integer range:[-99999999,99999999,R2] align:#center fieldwidth:45
--label l2 "Exports selection as sequence in selected time range"

groupBox attributeGrp "Attributes to Export" width:275 height:67
	
Checkbox posCB "Position" pos:[20,150] checked:True
Checkbox velCB "Velocity" pos:[110,150] checked:True
Checkbox rotCB "Rotation" pos:[200,150] checked: True
Checkbox ageCB "AGE" pos:[20,170]
Checkbox scaCB "Scale" pos:[110,170]
	
button exportButton "Export" width:200 height:50 pos:[55,210]
	
progressBar pb1 "ProgressBar" width:275 height:20
progressBar pb2 "ProgressBar2" width:275 height:20



on PDA_Exporter open do
	(

		
		
		sources = for o in objects where isKindOf o PF_Source collect o
		ddlPflowSource.items = for o in sources collect o.name
		particleSystem = sources[1]
		Filename=particleSystem.name+"_Exp"
		
		path_text.text=SavePath
		filename_text.text=Filename
	)
	
on ddlPflowSource selected state do
(
	particleSystem = sources[state]
	Filename=particleSystem.name+"_Exp"
	filename_text.text=Filename
)

on filename_text entered txt do
(Filename=filename_text.text)

on browse pressed do
(
	SavePath = getSavePath caption:"PDA Sequence Export Path"
	if SavePath != undefined then
	(path_text.text=SavePath)
)
on posCB changed state do
(positionIsOn = state)

on velCB changed state do
(velocityIsOn = state)

on rotCB changed state do
(rotationIsOn = state)

on ageCB changed state do
(ageIsOn = state)

on scaCB changed state do
(scaleIsOn = state)




on R1sp changed value do
	(R1=R1sp.value)

on R2sp changed value do
	(R2=R2sp.value)

on exportButton pressed do
	(
	
	
		for x = R1 to R2 do --Frame Range

		(
		
		sliderTime = x
		AllParticles=particleSystem.numParticles()
		digit = formattedPrint (x) format:".3d"
		--t.getParticlePositionByID 0
		FileLocation=SavePath+"/"+FileName+"_"+digit+".pda"
		stream = openFile FileLocation mode:"wb"	
		---HEADER---
		format "%\n" (HeadValuer AllParticles) to:stream
			
		

		for i = 1 to AllParticles do
			(
			format "%\n" (lineValuer i) to:stream
			pb2.value = 100.*i/AllParticles -- Update the lower ProgressPar
			)
			flush stream; close stream --Sifonu cek
		pb1.value = 100.*x/R2 -- Update the Upper progressBar
		)
		pb1.value = 0
		pb2.value = 0

	)
	
)
createdialog PDA_Exporter width:300
		
		
		
		
		
)		