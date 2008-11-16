From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv, io stucks
Date: Sat, 15 Nov 2008 23:43:04 -0500
Message-ID: <491FA4D8.1010708@rtr.ca>
References: <48F88449.1000704@ngs.ru> <49003B9C.1010303@ngs.ru> <4900A12F.3030307@rtr.ca> <491EE84B.1010600@gmail.com> <491F4096.9090701@rtr.ca> <491F5E42.8010906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:35640 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751652AbYKPEmP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 Nov 2008 23:42:15 -0500
In-Reply-To: <491F5E42.8010906@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harri Olin <harri.olin@gmail.com>
Cc: linux-ide@vger.kernel.org, Artem Bokhan <aptem@ngs.ru>

Harri Olin wrote:
..
>>>>>> Two marvell controllers, 16 disks, software raid10, IO stucks on 
>>>>>> different disks, kernel 2.6.26.5.
>>>>>> With default ubuntu's 8.04 2.6.24 kernel the problem can not be 
>>>>>> repeated
>>>>>>
>>>>>>
>>>>>> [  289.851609] ata11.00: exception Emask 0x0 SAct 0x1 SErr 0x0 
>>>>>> action 0x6 frozen
>>>>>> [  289.851695] ata11.00: cmd 61/08:00:60:1e:bf/00:00:01:00:00/40 
>>>>>> tag 0 ncq 4096 out
>>>>>> [  289.851697]          res 40/00:00:00:00:00/00:00:00:00:00/00 
>>>>>> Emask 0x4 (timeout)
>>>>>> [  289.851774] ata11.00: status: { DRDY }
>>>>>> [  289.851834] ata11: hard resetting link
>>>>>> [  290.649259] ata11: SATA link up 3.0 Gbps (SStatus 123 SControl 
>>>>>> 300)
>>>>>> [  290.749239] ata11.00: max_sectors limited to 256 for NCQ
>>>>>> [  290.809189] ata11.00: max_sectors limited to 256 for NCQ
>>>>>> [  290.809194] ata11.00: configured for UDMA/133
>>>>>> [  290.809200] ata11: EH complete
>>>>>> [  290.809242] sd 10:0:0:0: [sdk] 1953525168 512-byte hardware 
>>>>>> sectors (1000205 MB)
>>>>>> [  290.809258] sd 10:0:0:0: [sdk] Write Protect is off
>>>>>> [  290.809263] sd 10:0:0:0: [sdk] Mode Sense: 00 3a 00 00
>>>>>> [  290.809286] sd 10:0:0:0: [sdk] Write cache: enabled, read 
>>>>>> cache: enabled, doesn't support DPO or FUA
..
> I have to take back that bisect, as just couple of minutes ago it 
> happened again, with last 'good' kernel from bisect. Just the frequency 
> of stalls has dropped quite much. I also noticed that on current kernels 
> are much better too.
> pre-..0ff7efa8c: only once after 6 hours of testing
> post-..0ff7efa8c: one hd stalled while filesystem was mounting. Before 
> boot was complete, 3 stalls. Also at shutdown kernel hung at 
> Synchronizing SCSI cache for a while.
> 2.6.27: once in 5 minutes or so on heavy load
> 
> When some hd/port stalls, other ports sill work fine.
> 
> I applied your patch on 2.6.27.1, no results:
> 
> ata14.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 frozen
> ata14.00: cmd 61/08:00:3f:52:54/00:00:57:00:00/40 tag 0 ncq 4096 out
>         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
..

Yeah, I see what I was missing earlier:   "(timeout)".
So it's "none of" the driver paths.

This could very well be due to one/several of the as-yet un-addressed
chipset errata for the 6081.  Someday we'll have software workarounds
for those, but I'm (still) waiting on Marvell for stuff.

I will look and see if this makes sense based on the errata info
that I have already though (under NDA).

Harri / Artem:  what type/speed of slots are your 6081 controllers in?
PCI, or PCI-X?   Bus speed?

Thanks

