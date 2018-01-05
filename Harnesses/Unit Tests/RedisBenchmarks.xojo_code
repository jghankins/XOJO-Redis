#tag Class
Protected Class RedisBenchmarks
Inherits TestGroup
	#tag Method, Flags = &h0
		Sub SetTest()
		  dim r as new Redis_MTC
		  
		  dim key as string = "key:__rand_int__"
		  dim data as string = "xxx"
		  
		  dim sw as new Stopwatch_MTC
		  
		  for i as integer = 1 to kReps
		    sw.Start
		    call r.Set( key, data )
		    sw.Stop
		  next
		  
		  r.Delete key
		  
		  dim avg as double = kReps / sw.ElapsedSeconds
		  Assert.Pass format( kReps, "#,0" ).ToText + " keys took " + format( sw.ElapsedSeconds, "#,0.0##" ).ToText + "s, avg " + _
		  format( avg, "#,0.0##" ).ToText + "/s"
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetWithPipelineTest()
		  const kPipelines as integer = 10
		  
		  Assert.Message "With " + kPipelines.ToText + " pipelines"
		  
		  dim r as new Redis_MTC
		  r.StartPipeline
		  
		  dim key as string = "key:__rand_int__"
		  dim data as string = "xxx"
		  
		  dim sw as new Stopwatch_MTC
		  dim swFlush as new Stopwatch_MTC
		  
		  dim pipecount as integer
		  for i as integer = 1 to kReps
		    sw.Start
		    call r.Set( key, data )
		    sw.Stop
		    
		    pipecount = pipecount + 1
		    if pipecount = kPipelines then
		      sw.Start
		      swFlush.Start
		      call r.FlushPipeline( false )
		      sw.Stop
		      swFlush.Stop
		      pipecount = 0
		    end if
		  next i
		  
		  r.Delete key
		  
		  dim avg as double = kReps / sw.ElapsedSeconds
		  Assert.Pass format( kReps, "#,0" ).ToText + " keys took " + _
		  format( sw.ElapsedSeconds, "#,0.0##" ).ToText + "s, avg " + _
		  format( avg, "#,0.0##" ).ToText + "/s"
		  Assert.Pass "Flush took " + format( swFlush.ElapsedSeconds, "#,0.0##" ).ToText + "s"
		End Sub
	#tag EndMethod


	#tag Constant, Name = kReps, Type = Double, Dynamic = False, Default = \"100000", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Duration"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="FailedTestCount"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IncludeGroup"
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsRunning"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="NotImplementedCount"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="PassedTestCount"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="RunTestCount"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SkippedTestCount"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="StopTestOnFail"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TestCount"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
