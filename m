From: Brad Campbell <brad@wasp.net.au>
Subject: Re: libata oops 2.6.11-rc4 yesterdays BK
Date: Thu, 17 Feb 2005 00:54:16 +0400
Message-ID: <4213B2F8.2070800@wasp.net.au>
References: <4212CBD6.7020703@wasp.net.au> <42132803.2080701@wasp.net.au> <4213821D.1030203@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from wasp.net.au ([203.190.192.17]:58075 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S261874AbVBPUy3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Feb 2005 15:54:29 -0500
In-Reply-To: <4213821D.1030203@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Brad Campbell wrote:
> 
>> Brad Campbell wrote:
>>
>>> Woke up to this, this morning.
>>> This is yesterdays 2.6.11-rc4 BK + libata BK + libata-dev BK
>>> It was in the middle of a RAID-6 rebuild (scheduled to take about 740 
>>> minutes)
>>>
>>
>> Oh well, it appears to be reproducible anyway!
> 
> 
> Reproducible without the libata-dev patch?
> 
> Reproducible with the current libata driver... on an older kernel?  Say 
> 2.6.11-rc4 libata with 2.6.10.

Both good questions. I'm running 2.6.10-bk10 with the libata and libata-dev trees of that time now 
and it has made it through 2 ata timeouts and is 50% rebuilt on a 750 minute rebuild. If that 
survives I'll try and dial in some of the other kernels. 11-12 hour test times make it a bit of a 
bear to debug!
Actually, I'm not sure without the libata dev patch as that removes SMART support, and I'm not 
convinced that my smartd polling every 20 minutes does not have something to do with it. All I know 
is the older kernel seems to cope. We'll see. 320 minutes left on this rebuild. I expect it will be 
done in the morning if all goes according to plan. (With the 2.6.11 kernel it never survived past 
about 25% rebuilt)

This 2.6.10-bk10 is the kernel I have been running on my server for a while now (Almost identical 
hardware, just 1 less controller and a couple less disks)

bklaptop:~>ssh srv
Linux srv 2.6.10 #2 Mon Jan 10 18:42:45 GST 2005 i686 GNU/Linux
No mail.

Last login: Wed Feb 16 15:03:13 2005 from bklaptop
brad@srv:~$ uptime
  00:50:16 up 37 days,  5:40,  5 users,  load average: 0.21, 0.27, 0.35


Lucky I have a ready source of failing drives! 29 Maxtors. 1 is dying after 5000 hours and the other 
has 119 reallocated blocks after the first 8 hours.. Looking good thus far! <Bletch>.

Regards,
Brad -- Certified (or is that certifiable) libata torture tester.
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
