From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata_std_qc_defer not good enough for FIS-based switching ?
Date: Thu, 15 May 2008 16:12:13 +0900
Message-ID: <482BE24D.8020900@gmail.com>
References: <48163C5D.9050605@rtr.ca> <48164AE8.4070106@rtr.ca> <481659B5.7090703@gmail.com> <481660DD.80103@rtr.ca> <48167755.3000208@gmail.com> <4816873C.7090302@rtr.ca> <482AF322.2090605@gmail.com> <482AFB12.3040005@rtr.ca> <482AFCFA.40708@rtr.ca> <482B0A41.5030409@rtr.ca> <482B0C5D.5080207@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:64998 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765AbYEOHMk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 May 2008 03:12:40 -0400
Received: by wf-out-1314.google.com with SMTP id 27so267851wfd.4
        for <linux-ide@vger.kernel.org>; Thu, 15 May 2008 00:12:21 -0700 (PDT)
In-Reply-To: <482B0C5D.5080207@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@redhat.com>

Mark Lord wrote:
> Mark Lord wrote:
>> Mark Lord wrote:
>>> Mark Lord wrote:
>>>> ..
>>>> At the moment, I have the Sil PM plugged in, and it all behaves nicely.
>>>> The previous failure was with the Marvell PM, so I'll hook that up next
>>>> and retest with it.
>>> ..
>>>
>>> It went bonkers again.  This is with 2.6.25.
>>> I'll build 2.6.26-git and try again with that shortly.
>> ..
>>
>> Okay, I have today's 2.6.26-rc2-git installed now.
>> My PCIe notebook has an ExpressCard with this on it:
>>
>>  0d:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial 
>> ATA Raid II Controller (rev 01)
>>
>> That's the controller I use with sata_sil24 here.
>>
>> I have a Marvell 4140 port-multiplier (standalone card),
>> and have a Seagate 750GB drive (pmp=0) and a Hitachi 500GB drive (pmp=2).
>>
>> When I simply do "hdparm -t" simultaneously on both drives,
>> something gets very confused somewhere.  Neither drive has any media 
>> errors,
>> and this exact same test works fine with sata_mv in my other system.
>> The same test also works fine with both controllers
>> when using a Silicon Image PM instead of the Marvell.
>>
>> When I move the second drive to pmp=1 (instead of pmp=2),
>> then sata_sil24 no longer has problems.  Very peculiar.
>>
>> Here's the log from sata_sil24, ports 0,2, as it fails:
> ..
> 
> And here is the log from sata_sil24, ports 0,1, as it works:

Heh.. detection doesn't work too well either.  I have to tell you mv 
4140 is my favorite pmp.  It just behaved right.  Ironically, all later 
works were focused on simg 3726/4726's because they didn't behave.  I'll 
give well-deserved love to my 4140 and get back to you soon.

Thanks.

-- 
tejun
