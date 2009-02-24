From: Mark Lord <liml@rtr.ca>
Subject: Re: strange hdparm results with serverworks and pata-serverworks
Date: Tue, 24 Feb 2009 17:39:27 -0500
Message-ID: <49A4771F.5060802@rtr.ca>
References: <49A30901.1@wpkg.org> <49A3F63A.2080805@rtr.ca> <49A43E73.6070705@wpkg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:35721 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761314AbZBXWja (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Feb 2009 17:39:30 -0500
In-Reply-To: <49A43E73.6070705@wpkg.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: linux-ide@vger.kernel.org

Tomasz Chmielewski wrote:
> Mark Lord schrieb:
>> Tomasz Chmielewski wrote:
>>> I have a ProLiant BL30p G1 machine running Debian Lenny (2.6.26 kernel).
>>>
>>> It also has two identical, 2.5 inch WDC WD2500BEVE-00WZT0 IDE drives 
>>> (new drives, no smart/badblock errors). Both drives are connected to 
>>> a single IDE channel this machine has.
>>>
>>> "hdparm -t" gives me different results for these drives: ~10 MB/s for 
>>> hda, and ~20 MB/s for hdb with "serverworks" driver on Debian's 
>>> 2.6.26 kernel.
>>> When using "pata-serverworks" with 2.6.28.7 kernel, hdparm shows the 
>>> same results (~10 MB/s for sda, ~20 MB/s for sdb).
>>>
>>>
>>> However, when I run "dd if=/dev/sda of=/dev/null bs=64k", I can see 
>>> with iostat that for the first 7-8 seconds, reads are with ~10 MB/s 
>>> speed. Then, reads from sda are with ~20 MB/s or more and are on par 
>>> with sdb.
>>>
>>> Similar dd test for sdb shows that it delivers with speed of ~20 MB/s 
>>> from the first second.
>>>
>>> Is there an explanation for that?
>> ..
>>
>> Well, as you have shown, both hdparm and dd give the same results
>> when doing (almost) the same test:  the first 3 seconds are slow.
> 
> But only for hda/sda. Not for hdb/sdb.
> 
> 
>> After that, I would assume that the kernel read-ahead algorithms
>> kick in better and improve things.
>>
>> But 10-20Mbytes/sec is slow for most modern drives,
>> even for 2.5" drives.  Older ones, sure, that's fine,
>> but the newest 2.5" drives should score between 40
>> and 100Mbytes/sec.
> 
> BTW, I didn't mention it - these machine have CSB5 IDE controllers.
> 
> drivers/ata/pata_serverworks.c say there are two revisions of these 
> controllers: one capable of UDMA 4, one capable of UDMA 5. I'm not sure 
> what revision it is:
> 
> 00:0f.1 IDE interface: Broadcom CSB5 IDE Controller (rev 93) (prog-if 8a 
> [Master SecP PriP]) Subsystem: Broadcom CSB5 IDE Controller Control: 
> I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- 
> SERR+ FastB2B- DisINTx- Status: Cap- 66MHz- UDF- FastB2B- ParErr- 
> DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- Latency: 64 
> Region 0: I/O ports at 01f0 [size=8] Region 1: I/O ports at 03f4 
> [size=1] Region 2: I/O ports at 0170 [size=8] Region 3: I/O ports at 
> 0374 [size=1] Region 4: I/O ports at 2000 [size=16] Kernel driver in 
> use: Serverworks_IDE Kernel modules: serverworks
> Either way, yes, it should be faster.
> 
> 
> (...)
> 
>> The difference could easily be in the chipset used to communicate
>> with the drive.
> 
> Controller's chipset? That it has some extra doubts before it decides to 
> read
> "faster" from the first drive (master), but doesn't have these doubts 
> when reading from the slave drive?
> 
> 
>> You said "serverworks" driver, and "pata-serverworks".
>> The kernel start up logs will have more information,
>> including the timing info chosen by libata.
> 
> Here is what 2.6.28.7 says:
> 
> [    1.799408] ata1.00: ATA-8: WDC WD2500BEVE-00WZT0, 01.01A01, max 
> UDMA/100
> [    1.799413] ata1.00: 488397168 sectors, multi 8: LBA48.
> [    2.100115] ata1.01: ATA-8: WDC WD2500BEVE-00WZT0, 01.01A01, max 
> UDMA/100
> [    2.100118] ata1.01: 488397168 sectors, multi 8: LBA48.
> [    2.109007] ata1.00: configured for UDMA/100
> [    2.124554] ata1.01: configured for UDMA/100
> [    2.291564] scsi 0:0:0:0: Direct-Access     ATA      WDC WD2500BEVE-0 
> 01.0 PQ: 0 ANSI: 5
> [    2.291761] scsi 0:0:1:0: Direct-Access     ATA      WDC WD2500BEVE-0 
> 01.0 PQ: 0 ANSI: 5
> [    2.303851] Uniform Multi-Platform E-IDE driver
> [    2.318650] Driver 'sd' needs updating - please use bus_type methods
> [    2.318771] sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors: 
> (250 GB/232 GiB)
> [    2.318790] sd 0:0:0:0: [sda] Write Protect is off
> [    2.318793] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [    2.318822] sd 0:0:0:0: [sda] Write cache: disabled, read cache: 
> enabled, doesn't support DPO or FUA
> [    2.318901] sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors: 
> (250 GB/232 GiB)
> [    2.318919] sd 0:0:0:0: [sda] Write Protect is off
> [    2.318922] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [    2.318951] sd 0:0:0:0: [sda] Write cache: disabled, read cache: 
> enabled, doesn't support DPO or FUA
> [    2.318955]  sda: sda1 sda2 sda3
> [    2.401158] sd 0:0:0:0: [sda] Attached SCSI disk
> [    2.401225] sd 0:0:1:0: [sdb] 488397168 512-byte hardware sectors: 
> (250 GB/232 GiB)
> [    2.401243] sd 0:0:1:0: [sdb] Write Protect is off
> [    2.401246] sd 0:0:1:0: [sdb] Mode Sense: 00 3a 00 00
> [    2.401274] sd 0:0:1:0: [sdb] Write cache: disabled, read cache: 
> enabled, doesn't support DPO or FUA
> [    2.401332] sd 0:0:1:0: [sdb] 488397168 512-byte hardware sectors: 
> (250 GB/232 GiB)
> [    2.401350] sd 0:0:1:0: [sdb] Write Protect is off
> [    2.401353] sd 0:0:1:0: [sdb] Mode Sense: 00 3a 00 00
> [    2.401382] sd 0:0:1:0: [sdb] Write cache: disabled, read cache: 
> enabled, doesn't support DPO or FUA
> [    2.401385]  sdb: sdb1 sdb2
> [    2.453608] sd 0:0:1:0: [sdb] Attached SCSI disk
..

Everything looks configured correctly, so the only explanations
for the slow (10/20MB/sec) speeds are the CPU/RAM, or other system activity.

As for the disparity in initial throughput between the master/slave drives,
you could try reversing the two drives (swap them on the cable if using
"cable select", otherwise rejumper the master/slave setup).  Then see if the
slow start follows the specific drive to its new position on the cable,
or if the master ("a") drive is always slower.

Cheers
