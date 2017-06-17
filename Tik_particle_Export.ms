t=$PF_Source_001

totalParticles=t.numParticles()

--z=t.getParticleID 1

--t.getParticleTMByID 6

--t.getParticlePositionByID 0
filePath= "M:\\Temp\\Talha\\particleASCII_Test\\hoyhoy"



	for x = 1 to 100 do --Frame Range

		(
		digit = formattedPrint (x) format:".3d"
			
		t.getParticlePositionByID 0

		tmpFile = filePath+digit+".cvs"

		stream = openFile tmpFile mode:"w+"	
			
		totalParticles=t.numParticles()
			
		sliderTime = x
		--digit = formattedPrint (x) format:".4d"
		
		for i = 1 to totalParticles do
			(
				z=t.getParticleID i
				--stringtoWrite=(t.getParticleTMbyID z) as string
				particlePositionVect=t.getParticlePositionByID z
				stringtoWrite=((particlePositionVect.x as string)+(",")+(particlePositionVect.y as string)+(",")+(particlePositionVect.z as string))
				format "%\n" (stringtoWrite) to:stream
				--print stringtoWrite
			
			)
			flush stream; close stream
		)