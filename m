From: Brad Campbell <brad@wasp.net.au>
Subject: Re: libata oops 2.6.11-rc4 yesterdays BK
Date: Fri, 18 Feb 2005 10:13:08 +0400
Message-ID: <42158774.9030406@wasp.net.au>
References: <4212CBD6.7020703@wasp.net.au> <42132803.2080701@wasp.net.au> <4213821D.1030203@pobox.com> <4213B2F8.2070800@wasp.net.au> <20050216154033.I10699@florence.linkmargin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from wasp.net.au ([203.190.192.17]:15591 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S261208AbVBRGNN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Feb 2005 01:13:13 -0500
In-Reply-To: <20050216154033.I10699@florence.linkmargin.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Warner <andyw@pobox.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Andy Warner wrote:
> Brad Campbell wrote:
> 
>>[...]
>>Actually, I'm not sure without the libata dev patch as that removes SMART support, and I'm not 
>>convinced that my smartd polling every 20 minutes does not have something to do with it. All I know 
>>is the older kernel seems to cope. We'll see. 320 minutes left on this rebuild. I expect it will be 
>>done in the morning if all goes according to plan. (With the 2.6.11 kernel it never survived past 
>>about 25% rebuilt)
> 
> 
> Can you find time to try it without smartd active ?
> You report running a uni-processor system, and I have only
> seen PIO problems with (fast) SMP systems in my testing,
> but I am forming the opinion that libata-PIO functions
> are in need of a minor overhaul.
> 
> I have seen issues where port activity monopolised
> data-paths/arbitration inside chipsets such that the
> PIO operations would appear to time out. Since you're
> doing a raid rebuild, perhaps the I/O load is causing
> something similar to occur.

I suspect that is exactly the problem I'm seeing. I can see the smart polling on the drive lights 
when it occurs. It slows the rebuild quite significantly for that period.

I hit the problem using 2.6.10-bk10 also. It's just much harder to hit with that kernel. I'm now 
trying 2.6.11-rc4 with all the libata patches (the kernel I was using before), but smartd disabled. 
I have a sneaking suspicion that SMART is the root cause here however I don't see it on the other 
machine because
A) I'm using RAID-5 and not 6, thus my CPU usage during a rebuild is a LOT lower
B) I have more cards/drives in this machine and a RAID-6 rebuild across 15 drives appears to be 
quite taxing on the hardware.

Anyway, rebuild started. We will see in 12 hours.

I did note when I get an ata timeout in 2.6.10 it handles it normally. In 2.6.11 it hardlocks the 
machine. No alt-srq or anything else.

Regards,
Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
