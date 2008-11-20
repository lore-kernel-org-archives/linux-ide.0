From: Yan Seiner <yan@seiner.com>
Subject: Re: Port multiplier resets
Date: Wed, 19 Nov 2008 19:05:52 -0800
Message-ID: <4924D410.3030901@seiner.com>
References: <490DC300.40703@seiner.com> <49194B20.8000209@kernel.org> <49242D9E.4050500@seiner.com> <4924CB05.9060100@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from flatoutfitness.com ([66.178.130.209]:44999 "EHLO www.seiner.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752195AbYKTDFx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 Nov 2008 22:05:53 -0500
In-Reply-To: <4924CB05.9060100@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Yan Seiner wrote:
>   
>> Sorry for the delayed response.  I've installed another controller based
>> on the SiI 3132 chipset.  The esata array is the same; I've simply moved
>> the esata cables to the new controller.  My observations:
>>
>> 1.  The JMicron 20360/20363 AHCI Controller (rev 03) controller is far,
>> far slower.  hdparm clocks it at 20 mb/sec and a raid check takes about
>> 15 hours.
>>     
>
> Hmm... That's probably due to lack of FIS based switching support.
> The hardware (20360/3) can't do it and ahci doesn't support it yet
> either.  So, only commands to one drive can be in flight at any given
> moment which is usually pretty bad for RAID.
>   
So is there hope that FIS switching will make it into the driver or is 
this a hardware limitation?  I have some time (months if not a year or 
two) before I really start to populate my external disk pack.  (I have 
20 slots with 4 - 5 port multipliers.)

>   
>> 2. The JMicron controller experiences the above errors.
>>     
>
> Have you tried forcing the link speed?
>   
Not yet.  I spent the weekend building a remote switch and driver for 
the esata drive box.  (Long story; I need to be able to shut the 
external drive pack off via software.)

I need to check the drives as well make sure that the drives are not 
jumper-limited to 1.5 gb/sec.  (one of those DUH! moments...)


>   
>> 3.  The Sil 3132 controller is faster.  hdparm says 110 mb/sec and a
>> raid check takes about 5 hours.  This is confirmed by usage - I can
>> stream 2 videos, record 2 videos, and commercial flag a video in myth
>> with no visible stuttering.  The JMicron controller stutters even with a
>> single video streaming and recording.
>>     
>
> As said above, if you're running RAID on top of it, command based
> switching will hurt bad.  And 110Mb/s is about the limit of sil3132.
>   
I'm OK with the speed of the sil controller.  I'm concerned about the 
slow speed of the jmicron controller - it's about 1/3 to 1/5 as fast.



>   
>> 4.  The Sil 3132 controller doesn't have any errors even under high load.
>>
>> Google says the rev 3 version of the JMicron controller has these
>> issues, and to turn off NCQ on it.  It also indicates that these
>> problems should have been resolved in my kernel - version 2.6.27.4 - but
>> apparently not.  :-(
>>     
>
> Nah.. I'm not aware of any such problem and it will work fine w/o PMP.
> JMB ahci's are actually pretty good.  Lack of FIS switching support
> hurts when you use PMP tho.
>
>   
>> Is there a way to turn off NCQ on that controller without impacting the
>> Sil 3132 controller?  Any other things to try?
>>     
>
> You can do that with libata.force param but if you wanna put parallel
> high load to the drives connected through PMP, no matter what you do,
> the performance is gonna be bad if FIS switching is not supported.
>
>   
OK, thanks.  I'll check the drive jumpers and see about setting the 
lower speed.

The drives are used for storing and streaming videos.  The idea is to 
have 4 esata channels, eventually with 5 sets of raid-5 arrays.  Each 
raid-5 array consists of 4 drives, and each drive is on its own esata 
controller.  The likelihood of multiple raid arrays being used at the 
same time is small, so I hope I won't get hit too bad performance-wise. 
Even if they get hit, the bandwidth is small; each video stream is about 
8gb/hour.

I'm waiting on more hardware (the esata cables, of all things) before I 
can test this out fully.
