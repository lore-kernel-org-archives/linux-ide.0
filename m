From: Yan Seiner <yan@seiner.com>
Subject: Re: Backplane mystery
Date: Fri, 27 Feb 2009 07:39:38 -0800
Message-ID: <49A8093A.1030401@seiner.com>
References: <49A6B441.8010605@seiner.com> <49A6B683.9060806@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from flatoutfitness.com ([66.178.130.209]:33616 "EHLO www.seiner.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755532AbZB0Pjl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 Feb 2009 10:39:41 -0500
Received: from www.seiner.com ([192.168.128.6] ident=yan)
	by www.seiner.com with esmtp (Exim 4.69)
	(envelope-from <yan@seiner.com>)
	id 1Ld4oM-0004Nn-TH
	for linux-ide@vger.kernel.org; Fri, 27 Feb 2009 07:39:38 -0800
In-Reply-To: <49A6B683.9060806@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Mark Lord wrote:
> Yan Seiner wrote:
>> I have an external enclosure with an SATA backplane with 20 drive 
>> slots.  I am using 4 port multipliers to drive all 20 slots.
>>
>> One set of 5 slots connected to a single port multiplier always fails 
>> with
>> .....
<snippage>
>>
>>
>> 02:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial 
>> ATA Raid II Controller (rev 01)
>>
>> The system sees 3 port multipliers; not 4 as it should:
>>
>> [   82.488354] ata4.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 
>> ports, feat 0x1/0x9
>> [   82.488507] ata3.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 
>> ports, feat 0x1/0x9
>> [   82.796408] ata1.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 
>> ports, feat 0x1/0x9
>>
>> I suspect it's cabling length as the 5 "dead" slots are the farthest 
>> down the backplane but swapping cables randomly just doesn't seem 
>> like a good approach.
>>
>> What's my next step?
> ..
>
> Perhaps try a different chipset controller card,
> in hope that it will have stronger drive capability?
OK, did that.  No joy.

[   82.533526] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   82.533606] ata3: link online but device misclassified, retrying
[   82.533686] ata3: reset failed (errno=-11), retrying in 9 secs

Is there some way to be more forceful with the reset?  I suspect one of 
the port multiplier boards is bad at this point.  Is there some way to 
force a hard reset from user space?  What can I from userspace short of 
hitting the thing with a hammer?

--Yan


-- 
  o__
  ,>/'_          o__
  (_)\(_)        ,>/'_        o__
Yan Seiner      (_)\(_)       ,>/'_     o__
       Personal Trainer      (_)\(_)    ,>/'_        o__
             Professional Engineer     (_)\(_)       ,>/'_
Who says engineers have to be pencil necked geeks?  (_)\(_)

I like paying taxes. With them I buy civilization.


