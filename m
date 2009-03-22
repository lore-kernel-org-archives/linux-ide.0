From: =?KOI8-R?Q?=F7=CC=C1=C4=C9=CD=C9=D2_=E4=C1=DB=C5=D7=D3=CB=C9=CA?=
	<vladimir.dashevsky@gmail.com>
Subject: Re: hot plug on ICH9 with AHCI on
Date: Sun, 22 Mar 2009 15:51:35 +0300
Message-ID: <49C63457.8040203@gmail.com>
References: <49C171D7.1080706@gmail.com> <49C2F9B5.90000@kernel.org> <49C36816.306@gmail.com> <49C39933.4020501@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f165.google.com ([209.85.219.165]:55749 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbZCVMx2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Mar 2009 08:53:28 -0400
Received: by ewy9 with SMTP id 9so1268461ewy.37
        for <linux-ide@vger.kernel.org>; Sun, 22 Mar 2009 05:53:25 -0700 (PDT)
In-Reply-To: <49C39933.4020501@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Tejun!

Here are my comments on our previous conversation
>> Well, I partially agree. Surely, EMI problems should not break the link
>> forever but I do not agree with the algorithm. When the drive is being
>> removed it gets out during millisectonds. I mean the time between loss
>> of link and detection that port is not populated. So, I can imagine that
>> driver could be going to retry reset one but it had to abort this action
>> once it got the drive is removed at all. Not in 15 second and even not
>> in 5 seconds but in 0.01 second. So, 
> Heh... that will fail any EMI test.  There simply isn't anything to be
> earned by shortening the period.  The only thing that can go wrong
> with longer delay is if the user unplugs the drive, plugs it in
> another host modifies the content and replug it before the detach
> happens.  If the user does that, well, he/she deserves a corrupt
> filesystem.
>   
I think you are not right here. If we are talking about EMI problems I 
can say that the strategy of many retries is worse than one read of port 
present status. EMI noise occurs at the time while software tries to 
re-establish connection with empty link because there is no link 
terminatiion. It's just like a car engine that has lost its muffler. It 
produces lots of noise. It is better to turn the link off as soon as we 
know there is no device on the port. That's why retries should last only 
until that state is reported by hardware. And I think hardware reports 
that state much faster than in 15 or even 5 seconds. In ICH9 it reports 
this just immediately.
>>> That's SCSI sd driver shutting down.  As hot unplugging is
>>> surprise-removal, sd's shutdown sequence arrives after the device is
>>> actually gone and failed immediately.
>>>
>>>       
>> Ok. So, this is notmal. We just need to inform SCSI driver first, isn't it?
>>     
>
> If you hot unplug, how do you notify SCSI driver first?
>   
Well, there are some strange comments in FAQs that older ICH chips (5 to 
8) do not fully support hot plug, while the newer ones have better 
support for this. Then there is an explanation of what is proper hotplug 
support. That explanation says of surprise-removal support. However, I 
do not mind of notifying system before a actually remove the drive. Just 
because it may take a long time to shut down drive activity and it will 
be better to indicate this explicitly to user.
>>
>> Well, some drives store their firmware on disk, so they cannot work with
>> host until fully spinned up. I heard that drive started to spin up in
>> two or more seconds after being inserted. So, what is the indended
>> driver behavior? It simply performs soft resets until drive answer ot
>> this, isn't it? If the drive gets ready faster it will be fewer failed
>> soft resets in log, right?
>>     
>
> The goal is being robust.  With numerous hardware combinations, that's
> about the only way to keep things manageable.  Things don't always
> work as described in the spec.  Again, the only down side is one or
> more failed attempts and log about those.  Why do you care?
>   
It's just because one of my jobs is writing high performance embedded 
real-time software were logs are almost the only way to know what 
happens in hardware. After  several years of  such practice there is a 
habit of suspecting side effects of each stralge log line. That's whay I 
do care :-)
I just want to understand that this softreset failure is a normal 
behavior for that particular case.

> ahci doesn't use PCS to detect dummy ports.  It uses PORT_IMPL ahci
> register.  If PORT_IMPL changes according to which ports are occupied
> that's a BIOS bug.  Can you post the output of "dmidecode"?
>   
Yes, you were right, it was a BIOS bug. I have downloaded latest BIOS 
from the vendor's web site and now PI register allways reports all six 
ports implemented.

>>> echo 1 > /sys/block/sdX/device/delete
>>>  
>>>       
>> Can I be sure this will stop the drive sefely (without of cached data
>> loss)?
>>     
>
> Yes.
>   
Ok. So, one more question. How can I know exactly when device deletion 
has completed after sending this command? For example, consider that 
there some data in cache that needs 3 seconds to be sync-ed to disk. How 
can I know that I must wait for 3 seconds before a can actually remove 
the drive? Should I check the presence of some other filename in 
/sys/block/sdX/ or do something else?

Thank you!

With best regards, Vladimir Dashevsky

