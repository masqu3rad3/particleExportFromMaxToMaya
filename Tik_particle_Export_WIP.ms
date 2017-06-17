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

t=$PF_Source_001

--totalParticles=t.numParticles()





--t.getParticleSpeedByID 1

--t.getParticlePositionByID 0
filePath= "M:\\Temp\\Talha\\particleASCII_Test\\hodor"



	for x = 1 to 200 do --Frame Range

		(
		totalParticles=t.numParticles()
		digit = formattedPrint (x) format:".3d"
			
		t.getParticlePositionByID 0

		tmpFile = filePath+digit+".pda"

		stream = openFile tmpFile mode:"w+"	
		---HEADER---
		format "%\n" "ATTRIBUTES" to:stream
		format "%\n" " id position velocity customAttr" to:stream
		format "%\n" "TYPES" to:stream
		format "%\n" " I V V V" to:stream
		format "%\n" (("NUMBER_OF_PARTICLES: ")+(totalParticles as string)) to:stream
		format "%\n" "BEGIN DATA" to:stream		
			
		
			
		sliderTime = x
		--digit = formattedPrint (x) format:".4d"
		
		for i = 1 to totalParticles do
			(
				z=t.getParticleID i
				--stringtoWrite=(t.getParticleTMbyID z) as string
				particlePositionVect=t.getParticlePositionByID z
				particleVel=t.getParticleSpeedByID z
				particleRotRad=t.getParticleOrientationByID z
				particleRot=[(radToDeg particleRotRad.x),(radToDeg particleRotRad.y),(radToDeg particleRotRad.z)]
				stringtoWrite=(((z-1) as string)+" "+(particlePositionVect.x as string)+(" ")+(particlePositionVect.y as string)+(" ")+(particlePositionVect.z as string)+(" ")+(particleVel.x as string)+(" ")+(particleVel.y as string)+(" ")+(particleVel.z as string)+(" ")+(particleRot.x as string)+(" ")+(particleRot.y as string)+(" ")+(particleRot.z as string))
				format "%\n" (stringtoWrite) to:stream
				--print stringtoWrite
			
			)
			flush stream; close stream
		)