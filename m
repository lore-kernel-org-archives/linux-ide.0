From: Stefan Skotte <sfs@enhance-it.dk>
Subject: Re: State of Port Multiplier Support in libata?
Date: Sun, 08 Jul 2007 20:57:39 +0200
Message-ID: <469133A3.6080805@enhance-it.dk>
References: <4684D54A.8030307@enhance-it.dk> <4688A74B.7000604@gmail.com> <4688AB51.8080801@enhance-it.dk> <4688AE9D.7060008@gmail.com> <4688C3AF.2060100@enhance-it.dk> <4688C700.6070901@gmail.com> <4688FC96.7040604@enhance-it.dk> <4689149E.5030704@gmail.com> <46896824.2030507@enhance-it.dk> <4689BD18.6030202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from csmtp.b-one.net ([195.47.247.21]:37861 "EHLO csmtp1.b-one.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754592AbXGHS5m (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 8 Jul 2007 14:57:42 -0400
In-Reply-To: <4689BD18.6030202@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tejun,

On the 1.5Gbps vs. 3.0Gbps issue I had, the problem was just that I
hadn't paid attention to the factory default jumpers... They were set to
1.5Gbps ( I guess they do that for legacy purposes) :)

Do you want me to perform any other tests?

PS: Are you going to convert the patches for ipr.c & ipr.h so you can
apply the libata-tj patches without removing them ?

======================================================
dmesg output for reference (boot with array turned on:
======================================================
..
..
[   45.139206] sata_sil24 0000:01:00.0: version 1.0
[   45.139232] ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level,
low) -> IRQ 16
[   45.139276] PCI: Setting latency timer of device 0000:01:00.0 to 64
[   45.139334] scsi2 : sata_sil24
[   45.139340] PM: Adding info for No Bus:host2
[   45.139365] ata3: SATA max UDMA/100 cmd 0xf88bc000 ctl 0x00000000
bmdma 0x00000000 irq 0
[   45.885764] PM: Adding info for ieee1394:00031d000000b79d
[   45.885822] ieee1394: Host added: ID:BUS[0-00:1023]
GUID[00031d000000b79d]
[   47.335279] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   47.479001] ata3.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports,
feat 0x9/0x9
[   47.606797] ata3.00: hard resetting link
[   48.201813] ata3.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   48.217787] ata3.01: hard resetting link
[   48.828779] ata3.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   48.844751] ata3.02: hard resetting link
[   49.407820] ata3.02: SATA link down (SStatus 0 SControl 300)
[   49.423794] ata3.03: hard resetting link
[   49.986845] ata3.03: SATA link down (SStatus 0 SControl 300)
[   50.002837] ata3.04: hard resetting link
[   50.565906] ata3.04: SATA link down (SStatus 0 SControl 300)
[   50.565912] ata3.05: hard resetting link
[   51.128975] ata3.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   51.150824] ata3.00: ATA-7: WDC WD5000YS-01MPB1, 09.02E09, max UDMA/133
[   51.150829] ata3.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   51.151812] ata3.00: configured for UDMA/100
[   51.197390] ata3.01: ATA-7: ST3750640AS, 3.AAE, max UDMA/133
[   51.197395] ata3.01: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   51.255592] ata3.01: configured for UDMA/100
[   51.268746] ata3: EH complete
[   51.268783] PM: Adding info for No Bus:target2:0:0
[   51.268902] scsi 2:0:0:0: Direct-Access     ATA      WDC WD5000YS-01M
09.0 PQ: 0 ANSI: 5
[   51.268915] PM: Adding info for scsi:2:0:0:0
[   51.269009] sd 2:0:0:0: [sdb] 976773168 512-byte hardware sectors
(500108 MB)
[   51.269028] sd 2:0:0:0: [sdb] Write Protect is off
[   51.269033] sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   51.269059] sd 2:0:0:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   51.269137] sd 2:0:0:0: [sdb] 976773168 512-byte hardware sectors
(500108 MB)
[   51.269145] sd 2:0:0:0: [sdb] Write Protect is off
[   51.269147] sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   51.269158] sd 2:0:0:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   51.269162]  sdb: sdb1
[   51.274296] sd 2:0:0:0: [sdb] Attached SCSI disk
[   51.274358] sd 2:0:0:0: Attached scsi generic sg2 type 0
[   51.274389] PM: Adding info for No Bus:target2:0:1
[   51.274487] scsi 2:0:1:0: Direct-Access     ATA      ST3750640AS
 3.AA PQ: 0 ANSI: 5
[   51.274498] PM: Adding info for scsi:2:0:1:0
[   51.274571] sd 2:0:1:0: [sdc] 1465149168 512-byte hardware sectors
(750156 MB)
[   51.274578] sd 2:0:1:0: [sdc] Write Protect is off
[   51.274580] sd 2:0:1:0: [sdc] Mode Sense: 00 3a 00 00
[   51.274592] sd 2:0:1:0: [sdc] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   51.274621] sd 2:0:1:0: [sdc] 1465149168 512-byte hardware sectors
(750156 MB)
[   51.274629] sd 2:0:1:0: [sdc] Write Protect is off
[   51.274630] sd 2:0:1:0: [sdc] Mode Sense: 00 3a 00 00
[   51.274642] sd 2:0:1:0: [sdc] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   51.274647]  sdc: sdc1
[   51.295282] sd 2:0:1:0: [sdc] Attached SCSI disk
[   51.295332] sd 2:0:1:0: Attached scsi generic sg3 type 0
..
..
======================================================================

Kind regards,
Stefan Skotte

Tejun Heo wrote:
> Stefan Skotte wrote:
>> Here's the full log from trying to reproduce error in powering array on/off:
>>
>> =====================
>> ********* power off array......
>> [27685.211956] ata4.15: failed to read PMP product ID
>> [27685.211962] ata4.15: retrying hardreset
>> [27685.211969] ata4.15: hard resetting link
>> [27690.299444] ata4.15: SATA link down (SStatus 1 SControl 0)
>> [27690.555072] ata4.15: failed to read PMP GSCR[0] (errno=-5)
>> [27690.555077] ata4.15: PMP revalidation failed (errno=-5)
>> [27690.555084] ata4.15: limiting SATA link speed to 1.5 Gbps
>> [27690.555089] ata4.15: retrying hardreset in 5 secs
>> [27695.550667] ata4.15: hard resetting link
>> [27700.638173] ata4.15: SATA link down (SStatus 1 SControl 10)
>> [27700.893759] ata4.15: failed to read PMP GSCR[0] (errno=-5)
>> [27700.893765] ata4.15: PMP revalidation failed (errno=-5)
>> [27700.893771] ata4.15: retrying hardreset in 5 secs
>> [27705.889391] ata4.15: hard resetting link
>> [27710.976901] ata4.15: SATA link down (SStatus 1 SControl 10)
>> [27711.232487] ata4.15: failed to read PMP GSCR[0] (errno=-5)
>> [27711.232493] ata4.15: PMP revalidation failed (errno=-5)
>> [27711.232499] ata4.15: retrying hardreset in 5 secs
>> [27716.228121] ata4.15: hard resetting link
>> [27721.315629] ata4.15: SATA link down (SStatus 1 SControl 10)
>> [27721.571215] ata4.15: failed to read PMP GSCR[0] (errno=-5)
>> [27721.571221] ata4.15: PMP revalidation failed (errno=-5)
>> [27721.571226] ata4.15: failed to recover PMP after 3 tries, giving up
>> [27721.571230] ata4.15: Port Multiplier detaching
>> [27721.571257] ata4.00: disabled
>> [27721.571264] ata4.04: disabled
>> [27721.571268] ata4.00: disabled
> 
> This is okay.  PMP is detached after five tries.
> 
>> ******' power on array....
>> [27778.077300] ata4: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xa
>> frozen
>> [27778.077308] ata4: irq_stat 0x00b40090 <PHY RDY changed>
>> [27778.077318] ata4: hard resetting link
>> [27780.273144] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
>> [27780.416888] ata4.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports,
>> feat 0x9/0x9
>> [27780.544683] ata4.00: hard resetting link
>> [27781.027888] ata4.00: softreset failed (SRST command error)
>> [27781.027895] ata4.00: reset failed (errno=-5), retrying in 10 secs
>> [27790.527995] ata4.00: hard resetting link
>> [27791.138984] ata4.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> [27791.154959] ata4.01: hard resetting link
>> [27791.718016] ata4.01: SATA link down (SStatus 0 SControl 300)
>> [27791.733992] ata4.02: hard resetting link
>> [27792.297049] ata4.02: SATA link down (SStatus 0 SControl 300)
>> [27792.313025] ata4.03: hard resetting link
>> [27792.876081] ata4.03: SATA link down (SStatus 0 SControl 300)
>> [27792.892056] ata4.04: hard resetting link
>> [27793.487061] ata4.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> [27793.487068] ata4.05: hard resetting link
>> [27794.050120] ata4.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> [27794.090537] ata4.00: ATA-7: ST3750640AS, 3.AAE, max UDMA/133
>> [27794.090543] ata4.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
>> [27794.148733] ata4.00: configured for UDMA/100
>> [27794.160917] ata4.04: ATA-7: WDC WD5000YS-01MPB1, 09.02E09, max UDMA/133
>> [27794.160923] ata4.04: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
>> [27794.161914] ata4.04: configured for UDMA/100
> 
> And probed correctly when powered back on.  What I was worried about was
> when you power it off briefly and back on (or disconnect the cable
> briefly) while EH is still retrying.  libata is supposed to recover
> without detaching devices.
> 
>> =======================
>>
>> Unfortunately there isn't any firmware available for the PMP on my PCIe
>> board, if thats what you mean (?), it doesn't even have RAID capability.
> 
> http://www.siliconimage.com/support/supportsearchresults.aspx?pid=26&cid=23&ctid=2&osid=0&
> 
> This is what I meant but the latest one is dated 3/30/2006, so yours
> might as well have the latest one already.
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGkTOi+vG8YFo3LPMRAr4yAJ4483plhoGWGD4oQl96RsZg1qTekgCfS2me
N0PQN0qfifqZqBwlefyA1HU=
=pF1z
-----END PGP SIGNATURE-----
