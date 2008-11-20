From: Tejun Heo <tj@kernel.org>
Subject: Re: Port multiplier resets
Date: Thu, 20 Nov 2008 12:23:28 +0900
Message-ID: <4924D830.8010103@kernel.org>
References: <490DC300.40703@seiner.com> <49194B20.8000209@kernel.org> <49242D9E.4050500@seiner.com> <4924CB05.9060100@kernel.org> <4924D410.3030901@seiner.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56004 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751818AbYKTDXk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 Nov 2008 22:23:40 -0500
In-Reply-To: <4924D410.3030901@seiner.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yan Seiner <yan@seiner.com>
Cc: linux-ide@vger.kernel.org

Yan Seiner wrote:
> Tejun Heo wrote:
>> Yan Seiner wrote:
>>  
>>> Sorry for the delayed response.  I've installed another controller based
>>> on the SiI 3132 chipset.  The esata array is the same; I've simply moved
>>> the esata cables to the new controller.  My observations:
>>>
>>> 1.  The JMicron 20360/20363 AHCI Controller (rev 03) controller is far,
>>> far slower.  hdparm clocks it at 20 mb/sec and a raid check takes about
>>> 15 hours.
>>>     
>>
>> Hmm... That's probably due to lack of FIS based switching support.
>> The hardware (20360/3) can't do it and ahci doesn't support it yet
>> either.  So, only commands to one drive can be in flight at any given
>> moment which is usually pretty bad for RAID.
>>   
> So is there hope that FIS switching will make it into the driver or is
> this a hardware limitation?  I have some time (months if not a year or
> two) before I really start to populate my external disk pack.  (I have
> 20 slots with 4 - 5 port multipliers.)

20360/3 don't support them in hardware but there are controllers which
do and ahci driver will be updated to support them.

>> As said above, if you're running RAID on top of it, command based
>> switching will hurt bad.  And 110Mb/s is about the limit of sil3132.
>>   
> I'm OK with the speed of the sil controller.  I'm concerned about the
> slow speed of the jmicron controller - it's about 1/3 to 1/5 as fast.

Yeah, that's the difference coming from FIS and command based switching.

> OK, thanks.  I'll check the drive jumpers and see about setting the
> lower speed.

No, you don't have to do that.  You can just use libata.force parameter.
 ie. if the JMB one is ATA host 3, you can say libata.force=3:1.5Gbps.

-- 
tejun
