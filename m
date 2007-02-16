From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: Re: need help with ata error
Date: Sat, 17 Feb 2007 09:43:47 +1100
Message-ID: <45D633A3.6080204@eyal.emu.id.au>
References: <45CC414E.1080609@eyal.emu.id.au> <45CC4EE6.9010606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from webmail.icp-qv1-irony3.iinet.net.au ([203.59.1.108]:29850 "EHLO
	webmail.icp-qv1-irony3.iinet.net.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751526AbXBPWnx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Feb 2007 17:43:53 -0500
In-Reply-To: <45CC4EE6.9010606@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: list linux-ide <linux-ide@vger.kernel.org>, mikpe@it.uu.se

Today I got a similar error (I think) once during the overnight RAID "check".
This time it was sdc (was sdf in my original report). Both are on the Promise.
The check completed on time with zero mismatches.

Still 2.6.20 vanilla:
	Linux e7 2.6.20 #1 Mon Feb 5 22:08:32 EST 2007 i686 GNU/Linux

Also, the disks normally claim to be set to UDMA/133 but this time is says UDMA/100.

dmesg has a complete report, but /var/log/messages is missing some of the lines:

[927080.617744] md: data-check of RAID array md0
[927080.630783] md: minimum _guaranteed_  speed: 24000 KB/sec/disk.
[927080.648734] md: using maximum available idle IO bandwidth (but not more than 200000 KB/sec) for data-check.
[927080.678103] md: using 128k window, over a total of 312568576 blocks.

[937567.332751] ata3.00: exception Emask 0x10 SAct 0x0 SErr 0x4190002 action 0x2
[937567.354094] ata3.00: cmd b0/d5:01:09:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data 512 in
[937567.354096]          res 51/04:83:45:00:00/00:00:00:00:00/a0 Emask 0x10 (ATA bus error)
[937568.120783] ata3: soft resetting port
[937568.282450] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[937568.306693] ata3.00: configured for UDMA/100
[937568.319733] ata3: EH complete
[937568.361223] SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
[937568.397207] sdc: Write Protect is off
[937568.408620] sdc: Mode Sense: 00 3a 00 00
[937568.453522] SCSI device sdc: write cache: enabled, read cache: enabled, doesn't support DPO or FUA

[941696.843935] md: md0: data-check done.
[941697.246454] RAID5 conf printout:
[941697.256366]  --- rd:6 wd:6
[941697.264718]  disk 0, o:1, dev:sda1
[941697.275146]  disk 1, o:1, dev:sdb1
[941697.285575]  disk 2, o:1, dev:sdc1
[941697.296003]  disk 3, o:1, dev:sdd1
[941697.306432]  disk 4, o:1, dev:sde1
[941697.316862]  disk 5, o:1, dev:sdf1

Tejun Heo wrote:
> [cc'ing Mikael Pettersson, hi!]
> 
> Eyal Lebedinsky wrote:
> 
>> I recently added a 6th disk to a RAID5. All disks are WD 320GB SATA,
>> of different
>> Caviar models (SE, RE) and this new one is RE16.
>>
>> It worked well for about 5 days (completed a 20 hour grow OK). I now
>> see the following
>> messages logged (see at end). Can someone explain what it means? The
>> raid5 is still
>> up and it did not react to this. Being a mythtv repository it gets
>> used regularly.
>>
>> Is this a disk issue? A controller issue (the new disk is now the
>> fourth on a
>> Promise SATA-II-150-TX4)? A kernel problem (2.6.20 vanilla).
>>
>> ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
>> ata6.00: cmd 25/00:b8:3f:c4:b6/00:00:20:00:00/e0 tag 0 cdb 0x0 data
>> 94208 in
>>          res 50/00:00:f6:c4:b6/00:00:00:00:00/e0 Emask 0x1 (device error)
> 
> Device error w/o ATA_ERR set?  Mikael, this seems coming from
> PDC_ERR_MASK test in pdc_host_intr().  AC_ERR_DEV means 'the attached
> ATA/ATAPI device indicated error condition', so it isn't really
> appropriate there nor is pdc_reset_port() in IRQ handler.  I guess this
> is from the old EH days.
> 
> Unknown errors can use AC_ERR_OTHER which will be automatically cleared
> if error diagnosis results in any real error mask.  I think what should
> be done here is recording irq mask using ata_ehi_push_desc() and setting
> specific AC_ERR_* according to the IRQ mask as ahci and sata_sil24 do.
> 
> Eyal, if the error doesn't repeat, you can ignore it.  It probably is a
> transient transmission problem, power fluctuation or whatever.
> 
> Thanks.

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	attach .zip as .dat
