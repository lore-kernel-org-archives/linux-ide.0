From: Stan Hoeppner <stan@hardwarefreak.com>
Subject: Re: kernel 2.6.31.1 + Sil 3512 + WDC WD5000AAKS-00V1A0 = no NCQ and
   UDMA5 instead of UDMA6
Date: Thu, 17 Dec 2009 22:34:10 -0600
Message-ID: <4B2B0642.3010501@hardwarefreak.com>
References: <4B2A3D25.9030209@hardwarefreak.com> <4B2A720B.2040809@pobox.com> <4B2AE779.9060109@hardwarefreak.com> <4B2AF2C2.9010708@pobox.com> <4B2AFBDD.30601@hardwarefreak.com> <4B2AFF7B.4000007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo-65-41-216-221.sta.embarqhsd.net ([65.41.216.221]:55316 "EHLO
	greer.hardwarefreak.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363AbZLREeL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Dec 2009 23:34:11 -0500
In-Reply-To: <4B2AFF7B.4000007@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Robert Hancock put forth on 12/17/2009 10:05 PM:
> On 12/17/2009 09:49 PM, Stan Hoeppner wrote:
>> Jeff Garzik put forth on 12/17/2009 9:10 PM:
>>
>>> Nope.  You are pretty much maxing out the drive, of whatever drive you
>>> plug in.  The sata bus -- at its hardware spec'd maximum -- is far
>>> faster than just about any drive, and the PCI bus is far faster than the
>>> sata bus.
>>
>> I'm on the old 32bit/33MHz PCI bus of 133MB/s.  SATA1 at 150MB/s is
>> slightly faster, no?  No argument here that both are far faster than
>> almost all drives on the market.  I was just wondering if bumping up
>> from the default UDMA/100 to UDMA/133 would allow quicker PCI bus
>> bursting and thus a slight improvement in overall performance.
> 
> The UDMA speed doesn't make any difference at all with SATA, it's just
> an arbitrary number in almost all cases. Only the link speed really
> matters (which with these controllers will always be 1.5 Gbps).

Hi Robert.  Thanks for your informed reply.

So, how does this "phantom" UDMA setting affect either libata or
sata_sil?  If it effects nothing, why is it hanging around?  Is this a
backward compatibility thing for the kernel's benefit?  I'm not a kernel
hacker or programmer (yet), so please forgive my ignorant questions.

>> I think I only gave $15 for this Koutech Sil3512 PCI (32/33) controller
>> at Newegg.  You being you with the knowledge you have, would buying one
>> of the cards whose chipset supports NCQ, such as the sata_sil24 cards,
>> be anything close to worth the additional investment in dollars and time
>> spent swapping hardware and drivers?  Is NCQ the performance panacea
>> that some purport it to be?  How much difference does it really make?
> 
> It's really hard to say, it depends on the drive and the workload, in
> most cases..

On this particular machine, the greatest disk loading will be running
hdparm and other benchmarks.  Its real world workloads are modest, disk
and otherwise (though that may change).  If NCQ's greatest benefit comes
into play with multithreaded or multiuser workloads, then it would
probably not benefit this machine's real world performance much.  Unless
NCQ pumps up benchy numbers, which gives the machine owner a
psychological boost, if nothing else. ;)  (feels guilt)

Thanks for continuing to educate me folks.  It's so difficult to find
"under the hood" linux sata information of this type via Google.  All I
find are benchy results and accounts of personal experience, but not any
"this is why this works this way" info.

Please continue my education a bit more.  I'm trying not to be a pest,
but this stuff is fascinating to me, and more knowledge is always a good
thing, no?

--
Stan
