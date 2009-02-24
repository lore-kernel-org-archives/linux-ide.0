From: Tomasz Chmielewski <mangoo@wpkg.org>
Subject: Re: strange hdparm results with serverworks and pata-serverworks
Date: Tue, 24 Feb 2009 19:37:39 +0100
Message-ID: <49A43E73.6070705@wpkg.org>
References: <49A30901.1@wpkg.org> <49A3F63A.2080805@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx03.syneticon.net ([78.111.66.105]:57897 "EHLO
	mx03.syneticon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614AbZBXShX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Feb 2009 13:37:23 -0500
In-Reply-To: <49A3F63A.2080805@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org

Mark Lord schrieb:
> Tomasz Chmielewski wrote:
>> I have a ProLiant BL30p G1 machine running Debian Lenny (2.6.26 kernel).
>>
>> It also has two identical, 2.5 inch WDC WD2500BEVE-00WZT0 IDE drives 
>> (new drives, no smart/badblock errors). Both drives are connected to a 
>> single IDE channel this machine has.
>>
>> "hdparm -t" gives me different results for these drives: ~10 MB/s for 
>> hda, and ~20 MB/s for hdb with "serverworks" driver on Debian's 2.6.26 
>> kernel.
>> When using "pata-serverworks" with 2.6.28.7 kernel, hdparm shows the 
>> same results (~10 MB/s for sda, ~20 MB/s for sdb).
>>
>>
>> However, when I run "dd if=/dev/sda of=/dev/null bs=64k", I can see 
>> with iostat that for the first 7-8 seconds, reads are with ~10 MB/s 
>> speed. Then, reads from sda are with ~20 MB/s or more and are on par 
>> with sdb.
>>
>> Similar dd test for sdb shows that it delivers with speed of ~20 MB/s 
>> from the first second.
>>
>> Is there an explanation for that?
> ..
> 
> Well, as you have shown, both hdparm and dd give the same results
> when doing (almost) the same test:  the first 3 seconds are slow.

But only for hda/sda. Not for hdb/sdb.

 
> After that, I would assume that the kernel read-ahead algorithms
> kick in better and improve things.
> 
> But 10-20Mbytes/sec is slow for most modern drives,
> even for 2.5" drives.  Older ones, sure, that's fine,
> but the newest 2.5" drives should score between 40
> and 100Mbytes/sec.

BTW, I didn't mention it - these machine have CSB5 IDE controllers.

drivers/ata/pata_serverworks.c say there are two revisions of these controllers: 
one capable of UDMA 4, one capable of UDMA 5. I'm not sure what revision it is:

00:0f.1 IDE interface: Broadcom CSB5 IDE Controller (rev 93) (prog-if 8a [Master SecP PriP]) 
Subsystem: Broadcom CSB5 IDE Controller 
Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx- 
Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx- 
Latency: 64 
Region 0: I/O ports at 01f0 [size=8] 
Region 1: I/O ports at 03f4 [size=1] 
Region 2: I/O ports at 0170 [size=8] 
Region 3: I/O ports at 0374 [size=1] 
Region 4: I/O ports at 2000 [size=16] 
Kernel driver in use: Serverworks_IDE 
Kernel modules: serverworks 

Either way, yes, it should be faster.


(...)
 
> The difference could easily be in the chipset used to communicate
> with the drive.

Controller's chipset? That it has some extra doubts before it decides to read
"faster" from the first drive (master), but doesn't have these doubts when 
reading from the slave drive?


> You said "serverworks" driver, and "pata-serverworks".
> The kernel start up logs will have more information,
> including the timing info chosen by libata.

Here is what 2.6.28.7 says:

[    1.799408] ata1.00: ATA-8: WDC WD2500BEVE-00WZT0, 01.01A01, max UDMA/100
[    1.799413] ata1.00: 488397168 sectors, multi 8: LBA48.
[    2.100115] ata1.01: ATA-8: WDC WD2500BEVE-00WZT0, 01.01A01, max UDMA/100
[    2.100118] ata1.01: 488397168 sectors, multi 8: LBA48.
[    2.109007] ata1.00: configured for UDMA/100
[    2.124554] ata1.01: configured for UDMA/100
[    2.291564] scsi 0:0:0:0: Direct-Access     ATA      WDC WD2500BEVE-0 01.0 PQ: 0 ANSI: 5
[    2.291761] scsi 0:0:1:0: Direct-Access     ATA      WDC WD2500BEVE-0 01.0 PQ: 0 ANSI: 5
[    2.303851] Uniform Multi-Platform E-IDE driver
[    2.318650] Driver 'sd' needs updating - please use bus_type methods
[    2.318771] sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors: (250 GB/232 GiB)
[    2.318790] sd 0:0:0:0: [sda] Write Protect is off
[    2.318793] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.318822] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[    2.318901] sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors: (250 GB/232 GiB)
[    2.318919] sd 0:0:0:0: [sda] Write Protect is off
[    2.318922] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.318951] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[    2.318955]  sda: sda1 sda2 sda3
[    2.401158] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.401225] sd 0:0:1:0: [sdb] 488397168 512-byte hardware sectors: (250 GB/232 GiB)
[    2.401243] sd 0:0:1:0: [sdb] Write Protect is off
[    2.401246] sd 0:0:1:0: [sdb] Mode Sense: 00 3a 00 00
[    2.401274] sd 0:0:1:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[    2.401332] sd 0:0:1:0: [sdb] 488397168 512-byte hardware sectors: (250 GB/232 GiB)
[    2.401350] sd 0:0:1:0: [sdb] Write Protect is off
[    2.401353] sd 0:0:1:0: [sdb] Mode Sense: 00 3a 00 00
[    2.401382] sd 0:0:1:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[    2.401385]  sdb: sdb1 sdb2
[    2.453608] sd 0:0:1:0: [sdb] Attached SCSI disk


And here's what Debian's 2.6.26 says:

[    1.959553] Uniform Multi-Platform E-IDE driver
[    1.959553] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[    1.983556] SvrWks CSB5: IDE controller (0x1166:0x0212 rev 0x93) at  PCI slot 0000:00:0f.1
[    1.983556] SvrWks CSB5: not 100% native mode: will probe irqs later
[    1.983556]     ide0: BM-DMA at 0x2000-0x2007
[    1.983556]     ide1: BM-DMA at 0x2008-0x200f
[    1.983556] Probing IDE interface ide0...
[    2.270917] hda: WDC WD2500BEVE-00WZT0, ATA DISK drive
[    2.550916] hdb: WDC WD2500BEVE-00WZT0, ATA DISK drive
[    2.606710] hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[    2.606778] hda: UDMA/100 mode selected
[    2.606845] hdb: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[    2.606920] hdb: UDMA/100 mode selected
[    2.606983] Probing IDE interface ide1...
[    3.177157] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    3.177203] ide1 at 0x170-0x177,0x376 on irq 15
[    4.313346] hda: max request size: 512KiB
[    4.369345] hda: 488397168 sectors (250059 MB) w/8192KiB Cache, CHS=30401/255/63
[    4.369345] hda: cache flushes supported
[    4.369345]  hda: hda1 hda2 hda3
[    4.401458] hdb: max request size: 512KiB
[    4.693859] hdb: 488397168 sectors (250059 MB) w/8192KiB Cache, CHS=30401/255/63
[    4.693859] hdb: cache flushes supported
[    4.693859]  hdb: hdb1 hdb2



-- 
Tomasz Chmielewski
http://wpkg.org
