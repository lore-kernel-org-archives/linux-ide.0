From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: Re: nonzero mismatch_cnt with no earlier error
Date: Mon, 05 Mar 2007 18:52:35 +1100
Message-ID: <45EBCC43.9010709@eyal.emu.id.au>
References: <45DF859B.2050108@eyal.emu.id.au>	<Pine.LNX.4.64.0702231929380.31611@p34.internal.lan>	<45DF8DE3.2050903@eyal.emu.id.au> <17890.25524.465403.130119@notabene.brown> <45E297E5.50303@eyal.emu.id.au> <45EB95EF.9030702@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ihug-mail.icp-qv1-irony16.iinet.net.au ([203.59.1.182]:16449
	"EHLO mail-ihug.icp-qv1-irony16.iinet.net.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932133AbXCEHwn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Mar 2007 02:52:43 -0500
In-Reply-To: <45EB95EF.9030702@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <teheo@suse.de>
Cc: list linux-ide <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Eyal Lebedinsky wrote:
> 
>>I CC'ed linux-ide to see if they think the reported error was really innocent:
>>
>>Question: does this error report suggest that a disk could be corrupted?
>>
>>This SATA disk is part of an md raid and no error was reported by md.
>>
>>[937567.332751] ata3.00: exception Emask 0x10 SAct 0x0 SErr 0x4190002 action 0x2
>>[937567.354094] ata3.00: cmd b0/d5:01:09:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data 512 in
>>[937567.354096]          res 51/04:83:45:00:00/00:00:00:00:00/a0 Emask 0x10 (ATA bus error)
> 
> 
> Command 0xb0 is SMART.  The device failed some subcommand of SMART, so,
> no, it isn't related to data integrity, but your link is reporting
> recovered data transmission error and PHY ready status changed and some
> other conditions making libata EH mark the failure as ATA bus error.
> Care to post full dmesg?

It is in the original thread on linux-raid, but here it is for this list.
This is the full dmesg. There were only MARKs in between.

I run a raid 'check' every Friday (cron). The last one reported some parity errors.

*** last week check start:
[927080.617744] md: data-check of RAID array md0
[927080.630783] md: minimum _guaranteed_  speed: 24000 KB/sec/disk.
[927080.648734] md: using maximum available idle IO bandwidth (but not more than 200000 KB/sec) for data-check.
[927080.678103] md: using 128k window, over a total of 312568576 blocks.
	*** last week error:
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
	*** last week check end:
[941696.843935] md: md0: data-check done.
[941697.246454] RAID5 conf printout:
[941697.256366]  --- rd:6 wd:6
[941697.264718]  disk 0, o:1, dev:sda1
[941697.275146]  disk 1, o:1, dev:sdb1
[941697.285575]  disk 2, o:1, dev:sdc1
[941697.296003]  disk 3, o:1, dev:sdd1
[941697.306432]  disk 4, o:1, dev:sde1
[941697.316862]  disk 5, o:1, dev:sdf1
	*** this week check start:
[1530647.746383] md: data-check of RAID array md0
[1530647.759677] md: minimum _guaranteed_  speed: 24000 KB/sec/disk.
[1530647.778041] md: using maximum available idle IO bandwidth (but not more than 200000 KB/sec) for data-check.
[1530647.807663] md: using 128k window, over a total of 312568576 blocks.
	*** this week check end:
[1545248.680745] md: md0: data-check done.
[1545249.266727] RAID5 conf printout:
[1545249.276930]  --- rd:6 wd:6
[1545249.285542]  disk 0, o:1, dev:sda1
[1545249.296228]  disk 1, o:1, dev:sdb1
[1545249.306923]  disk 2, o:1, dev:sdc1
[1545249.317613]  disk 3, o:1, dev:sdd1
[1545249.328292]  disk 4, o:1, dev:sde1
[1545249.338981]  disk 5, o:1, dev:sdf1

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	attach .zip as .dat
