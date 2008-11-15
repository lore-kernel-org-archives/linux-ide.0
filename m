From: Harri Olin <harri.olin@gmail.com>
Subject: Re: sata_mv, io stucks
Date: Sun, 16 Nov 2008 01:47:19 +0200
Message-ID: <491F5F87.8060200@gmail.com>
References: <48F88449.1000704@ngs.ru> <49003B9C.1010303@ngs.ru> <4900A12F.3030307@rtr.ca> <491EE84B.1010600@gmail.com> <491F4096.9090701@rtr.ca> <491F5E42.8010906@gmail.com> <alpine.DEB.1.10.0811151843520.27937@p34.internal.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw02.mail.saunalahti.fi ([195.197.172.116]:46372 "EHLO
	gw02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbYKOXr0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Nov 2008 18:47:26 -0500
In-Reply-To: <alpine.DEB.1.10.0811151843520.27937@p34.internal.lan>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

Justin Piszcz wrote:
>
>
> On Sun, 16 Nov 2008, Harri Olin wrote:
>
>> Mark Lord wrote:
>>> Harri Olin wrote:
>>>> Mark Lord wrote:
>>>>>>> Two marvell controllers, 16 disks, software raid10, IO stucks on 
>>>>>>> different disks, kernel 2.6.26.5.
>>>>>>> With default ubuntu's 8.04 2.6.24 kernel the problem can not be 
>>>>>>> repeated
>>>>>>>
>>>>>>>
>>>>>>> [  289.851609] ata11.00: exception Emask 0x0 SAct 0x1 SErr 0x0 
>>>>>>> action 0x6 frozen
>>>>>>> [  289.851695] ata11.00: cmd 61/08:00:60:1e:bf/00:00:01:00:00/40 
>>>>>>> tag 0 ncq 4096 out
>>>>>>> [  289.851697]          res 40/00:00:00:00:00/00:00:00:00:00/00 
>>>>>>> Emask 0x4 (timeout)
>>>>>>> [  289.851774] ata11.00: status: { DRDY }
>>>>>>> [  289.851834] ata11: hard resetting link
>>>>>>> [  290.649259] ata11: SATA link up 3.0 Gbps (SStatus 123 
>>>>>>> SControl 300)
>>>>>>> [  290.749239] ata11.00: max_sectors limited to 256 for NCQ
>>>>>>> [  290.809189] ata11.00: max_sectors limited to 256 for NCQ
>>>>>>> [  290.809194] ata11.00: configured for UDMA/133
>>>>>>> [  290.809200] ata11: EH complete
>>>>>>> [  290.809242] sd 10:0:0:0: [sdk] 1953525168 512-byte hardware 
>>>>>>> sectors (1000205 MB)
>>>>>>> [  290.809258] sd 10:0:0:0: [sdk] Write Protect is off
>>>>>>> [  290.809263] sd 10:0:0:0: [sdk] Mode Sense: 00 3a 00 00
>>>>>>> [  290.809286] sd 10:0:0:0: [sdk] Write cache: enabled, read 
>>>>>>> cache: enabled, doesn't support DPO or FUA
>>>>> ...
>>>>>
>>>>> I've just returned here from a month holiday in Italy,
>>>>> and I'll have a look at this and other sata_mv issues
>>>>> next week or so.
>>>>
>>>> I ran git-bisect on it and it returned 
>>>> a3718c1f230240361ed92d3e53342df0ff7efa8c as first bad commit. Also 
>>>> verified by hand that patching it on working tree breaks it.
>>> Looking at later kernels (after the commit in question), I see that
>>> the code was further fixed to remove some possible races and stuff,
>>> but that's still just 2.6.26.5, which you guys see failures on.
>>>
>>> So here's some instrumentation to help us figure it out.
>>> Please apply and report back once it triggers again.
>>> Thanks.
>>
>> I have to take back that bisect, as just couple of minutes ago it 
>> happened again, with last 'good' kernel from bisect. Just the 
>> frequency of stalls has dropped quite much. I also noticed that on 
>> current kernels are much better too.
>> pre-..0ff7efa8c: only once after 6 hours of testing
>> post-..0ff7efa8c: one hd stalled while filesystem was mounting. 
>> Before boot was complete, 3 stalls. Also at shutdown kernel hung at 
>> Synchronizing SCSI cache for a while.
>> 2.6.27: once in 5 minutes or so on heavy load
>>
>> When some hd/port stalls, other ports sill work fine.
>>
>> I applied your patch on 2.6.27.1, no results:
>>
>> ata14.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 frozen
>> ata14.00: cmd 61/08:00:3f:52:54/00:00:57:00:00/40 tag 0 ncq 4096 out
>>        res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
>> ata14.00: status: { DRDY }
>> ata14: hard resetting link
>> ata14: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> ata14.00: max_sectors limited to 256 for NCQ
>> ata14.00: max_sectors limited to 256 for NCQ
>> ata14.00: configured for UDMA/133
>> ata14: EH complete
>> sd 13:0:0:0: [sdh] 1465149168 512-byte hardware sectors (750156 MB)
>> sd 13:0:0:0: [sdh] Write Protect is off
>> sd 13:0:0:0: [sdh] Mode Sense: 00 3a 00 00
>> sd 13:0:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't 
>> support DPO or FUA
>>
>> Do I have to enable something somewhere else too?
>>
>> I also compiled and patched linux-2.6-stable tree from git but it 
>> just paniced after stall instead of recovering. I'm currently trying 
>> to reproduce that on second computer where I can capture the panic.
>
> What type of disks are you using?
>
> Justin.
I have seen this happening on on 3 different computers using WD5000ABYS, 
WD5000YS and WD7500AYYS hard disks. All have same Supermicro controller. 
Stalls happen only on controller ports 0-3, never on ports 4-7. Moving 
cables around doesn't help.

-- 
Harri.



