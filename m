From: Stefan Skotte <sfs@enhance-it.dk>
Subject: Re: State of Port Multiplier Support in libata?
Date: Mon, 02 Jul 2007 23:03:32 +0200
Message-ID: <46896824.2030507@enhance-it.dk>
References: <4684D54A.8030307@enhance-it.dk> <4688A74B.7000604@gmail.com> <4688AB51.8080801@enhance-it.dk> <4688AE9D.7060008@gmail.com> <4688C3AF.2060100@enhance-it.dk> <4688C700.6070901@gmail.com> <4688FC96.7040604@enhance-it.dk> <4689149E.5030704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from csmtp.b-one.net ([195.47.247.21]:34247 "EHLO csmtp1.b-one.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754838AbXGBVDg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Jul 2007 17:03:36 -0400
In-Reply-To: <4689149E.5030704@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here's the full log from trying to reproduce error in powering array on/off:

=====================
******** modprobe sata_sil24 (array is already on)...
[27635.288848] sata_sil24 0000:01:00.0: version 1.0
[27635.288873] ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level,
low) -> IRQ 16
[27635.288904] PCI: Setting latency timer of device 0000:01:00.0 to 64
[27635.290003] scsi3 : sata_sil24
[27635.290018] PM: Adding info for No Bus:host3
[27635.290050] ata4: SATA max UDMA/100 cmd 0xf8e8c000 ctl 0x00000000
bmdma 0x00000000 irq 0
[27637.483686] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[27637.627430] ata4.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports,
feat 0x9/0x9
[27637.755223] ata4.00: hard resetting link
[27638.366203] ata4.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[27638.382178] ata4.01: hard resetting link
[27638.945235] ata4.01: SATA link down (SStatus 0 SControl 300)
[27638.961210] ata4.02: hard resetting link
[27639.524273] ata4.02: SATA link down (SStatus 0 SControl 300)
[27639.540487] ata4.03: hard resetting link
[27640.103302] ata4.03: SATA link down (SStatus 0 SControl 300)
[27640.119275] ata4.04: hard resetting link
[27640.714280] ata4.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[27640.714287] ata4.05: hard resetting link
[27641.277339] ata4.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[27641.323510] ata4.00: ATA-7: ST3750640AS, 3.AAE, max UDMA/133
[27641.323516] ata4.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[27641.381708] ata4.00: configured for UDMA/100
[27641.392371] ata4.04: ATA-7: WDC WD5000YS-01MPB1, 09.02E09, max UDMA/133
[27641.392377] ata4.04: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[27641.393434] ata4.04: configured for UDMA/100
[27641.409113] ata4: EH complete
[27641.409224] PM: Adding info for No Bus:target3:0:0
[27641.409593] scsi 3:0:0:0: Direct-Access     ATA      ST3750640AS
 3.AA PQ: 0 ANSI: 5
[27641.409696] PM: Adding info for scsi:3:0:0:0
[27641.409920] sd 3:0:0:0: [sda] 1465149168 512-byte hardware sectors
(750156 MB)
[27641.410095] sd 3:0:0:0: [sda] Write Protect is off
[27641.410097] sd 3:0:0:0: [sda] Mode Sense: 00 3a 00 00
[27641.410338] sd 3:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[27641.410543] sd 3:0:0:0: [sda] 1465149168 512-byte hardware sectors
(750156 MB)
[27641.410691] sd 3:0:0:0: [sda] Write Protect is off
[27641.410694] sd 3:0:0:0: [sda] Mode Sense: 00 3a 00 00
[27641.410931] sd 3:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[27641.410934]  sda: sda1
[27641.429747] sd 3:0:0:0: [sda] Attached SCSI disk
[27641.429932] sd 3:0:0:0: Attached scsi generic sg0 type 0
[27641.430054] PM: Adding info for No Bus:target3:0:4
[27641.430376] scsi 3:0:4:0: Direct-Access     ATA      WDC WD5000YS-01M
09.0 PQ: 0 ANSI: 5
[27641.430481] PM: Adding info for scsi:3:0:4:0
[27641.430699] sd 3:0:4:0: [sdb] 976773168 512-byte hardware sectors
(500108 MB)
[27641.430849] sd 3:0:4:0: [sdb] Write Protect is off
[27641.430852] sd 3:0:4:0: [sdb] Mode Sense: 00 3a 00 00
[27641.431097] sd 3:0:4:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[27641.431303] sd 3:0:4:0: [sdb] 976773168 512-byte hardware sectors
(500108 MB)
[27641.431453] sd 3:0:4:0: [sdb] Write Protect is off
[27641.431456] sd 3:0:4:0: [sdb] Mode Sense: 00 3a 00 00
[27641.431719] sd 3:0:4:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[27641.431722]  sdb: sdb1
[27641.440613] sd 3:0:4:0: [sdb] Attached SCSI disk
[27641.440707] sd 3:0:4:0: Attached scsi generic sg1 type 0
********* power off array......
[27684.956387] ata4.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action
0x6 frozen
[27684.956396] ata4.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action
0x6 frozen
[27684.956402] ata4.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action
0x6 frozen
[27684.956408] ata4.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action
0x6 frozen
[27684.956413] ata4.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action
0x6 frozen
[27684.956419] ata4.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action
0x6 frozen
[27685.211956] ata4.15: failed to read PMP product ID
[27685.211962] ata4.15: retrying hardreset
[27685.211969] ata4.15: hard resetting link
[27690.299444] ata4.15: SATA link down (SStatus 1 SControl 0)
[27690.555072] ata4.15: failed to read PMP GSCR[0] (errno=-5)
[27690.555077] ata4.15: PMP revalidation failed (errno=-5)
[27690.555084] ata4.15: limiting SATA link speed to 1.5 Gbps
[27690.555089] ata4.15: retrying hardreset in 5 secs
[27695.550667] ata4.15: hard resetting link
[27700.638173] ata4.15: SATA link down (SStatus 1 SControl 10)
[27700.893759] ata4.15: failed to read PMP GSCR[0] (errno=-5)
[27700.893765] ata4.15: PMP revalidation failed (errno=-5)
[27700.893771] ata4.15: retrying hardreset in 5 secs
[27705.889391] ata4.15: hard resetting link
[27710.976901] ata4.15: SATA link down (SStatus 1 SControl 10)
[27711.232487] ata4.15: failed to read PMP GSCR[0] (errno=-5)
[27711.232493] ata4.15: PMP revalidation failed (errno=-5)
[27711.232499] ata4.15: retrying hardreset in 5 secs
[27716.228121] ata4.15: hard resetting link
[27721.315629] ata4.15: SATA link down (SStatus 1 SControl 10)
[27721.571215] ata4.15: failed to read PMP GSCR[0] (errno=-5)
[27721.571221] ata4.15: PMP revalidation failed (errno=-5)
[27721.571226] ata4.15: failed to recover PMP after 3 tries, giving up
[27721.571230] ata4.15: Port Multiplier detaching
[27721.571257] ata4.00: disabled
[27721.571264] ata4.04: disabled
[27721.571268] ata4.00: disabled
[27721.571275] ata4: EH pending after completion, repeating EH (cnt=4)
[27721.571286] ata4: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x9
[27721.571291] ata4: irq_stat 0x01940090 <PHY RDY changed>
[27721.571298] ata4: hard resetting link
[27726.658706] ata4: SATA link down (SStatus 1 SControl 0)
[27726.658723] ata4: EH complete
[27726.658736] ata4.00: detaching (SCSI 3:0:0:0)
[27726.659003] sd 3:0:0:0: [sda] Synchronizing SCSI cache
[27726.661348] sd 3:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
[27726.661354] sd 3:0:0:0: [sda] Stopping disk
[27726.661555] sd 3:0:0:0: [sda] START_STOP FAILED
[27726.661557] sd 3:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
[27726.661565] PM: Removing info for scsi:3:0:0:0
[27726.661612] PM: Removing info for No Bus:target3:0:0
[27726.661621] ata4.04: detaching (SCSI 3:0:4:0)
[27726.661756] sd 3:0:4:0: [sdb] Synchronizing SCSI cache
[27726.663246] sd 3:0:4:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
[27726.663250] sd 3:0:4:0: [sdb] Stopping disk
[27726.663513] sd 3:0:4:0: [sdb] START_STOP FAILED
[27726.663515] sd 3:0:4:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
[27726.663520] PM: Removing info for scsi:3:0:4:0
[27726.663550] PM: Removing info for No Bus:target3:0:4
******' power on array....
[27778.077300] ata4: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xa
frozen
[27778.077308] ata4: irq_stat 0x00b40090 <PHY RDY changed>
[27778.077318] ata4: hard resetting link
[27780.273144] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[27780.416888] ata4.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports,
feat 0x9/0x9
[27780.544683] ata4.00: hard resetting link
[27781.027888] ata4.00: softreset failed (SRST command error)
[27781.027895] ata4.00: reset failed (errno=-5), retrying in 10 secs
[27790.527995] ata4.00: hard resetting link
[27791.138984] ata4.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[27791.154959] ata4.01: hard resetting link
[27791.718016] ata4.01: SATA link down (SStatus 0 SControl 300)
[27791.733992] ata4.02: hard resetting link
[27792.297049] ata4.02: SATA link down (SStatus 0 SControl 300)
[27792.313025] ata4.03: hard resetting link
[27792.876081] ata4.03: SATA link down (SStatus 0 SControl 300)
[27792.892056] ata4.04: hard resetting link
[27793.487061] ata4.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[27793.487068] ata4.05: hard resetting link
[27794.050120] ata4.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[27794.090537] ata4.00: ATA-7: ST3750640AS, 3.AAE, max UDMA/133
[27794.090543] ata4.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[27794.148733] ata4.00: configured for UDMA/100
[27794.160917] ata4.04: ATA-7: WDC WD5000YS-01MPB1, 09.02E09, max UDMA/133
[27794.160923] ata4.04: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[27794.161914] ata4.04: configured for UDMA/100
[27794.177913] ata4: EH complete
[27794.177944] PM: Adding info for No Bus:target3:0:0
[27794.178386] scsi 3:0:0:0: Direct-Access     ATA      ST3750640AS
 3.AA PQ: 0 ANSI: 5
[27794.178394] PM: Adding info for scsi:3:0:0:0
[27794.178703] sd 3:0:0:0: [sda] 1465149168 512-byte hardware sectors
(750156 MB)
[27794.178856] sd 3:0:0:0: [sda] Write Protect is off
[27794.178859] sd 3:0:0:0: [sda] Mode Sense: 00 3a 00 00
[27794.179113] sd 3:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[27794.179314] sd 3:0:0:0: [sda] 1465149168 512-byte hardware sectors
(750156 MB)
[27794.179461] sd 3:0:0:0: [sda] Write Protect is off
[27794.179464] sd 3:0:0:0: [sda] Mode Sense: 00 3a 00 00
[27794.179697] sd 3:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[27794.179700]  sda: sda1
[27794.196746] sd 3:0:0:0: [sda] Attached SCSI disk
[27794.196806] sd 3:0:0:0: Attached scsi generic sg0 type 0
[27794.196841] PM: Adding info for No Bus:target3:0:4
[27794.197370] scsi 3:0:4:0: Direct-Access     ATA      WDC WD5000YS-01M
09.0 PQ: 0 ANSI: 5
[27794.197378] PM: Adding info for scsi:3:0:4:0
[27794.197669] sd 3:0:4:0: [sdb] 976773168 512-byte hardware sectors
(500108 MB)
[27794.197816] sd 3:0:4:0: [sdb] Write Protect is off
[27794.197819] sd 3:0:4:0: [sdb] Mode Sense: 00 3a 00 00
[27794.198072] sd 3:0:4:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[27794.198271] sd 3:0:4:0: [sdb] 976773168 512-byte hardware sectors
(500108 MB)
[27794.198417] sd 3:0:4:0: [sdb] Write Protect is off
[27794.198420] sd 3:0:4:0: [sdb] Mode Sense: 00 3a 00 00
[27794.198651] sd 3:0:4:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[27794.198654]  sdb: sdb1
[27794.201222] sd 3:0:4:0: [sdb] Attached SCSI disk
[27794.201259] sd 3:0:4:0: Attached scsi generic sg1 type 0
=======================

Unfortunately there isn't any firmware available for the PMP on my PCIe
board, if thats what you mean (?), it doesn't even have RAID capability.



Tejun Heo wrote:
> Hello,
> 
> Stefan Skotte wrote:
>> ============================
>> Here's the full log after a reboot, and me powering up the array
>> manually afterwards:
>> ============================
>> [ 9995.743400] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xa
>> frozen
>> [ 9995.743409] ata1: irq_stat 0x00b40090 <PHY RDY changed>
>> [ 9995.743419] ata1: hard resetting link
>> [ 9997.936879] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
>> [ 9998.080620] ata1.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports,
>> feat 0x9/0x9
>> [ 9998.208414] ata1.00: hard resetting link
>> [ 9998.691615] ata1.00: softreset failed (SRST command error)
>> [ 9998.691623] ata1.00: reset failed (errno=-5), retrying in 10 secs
> 
> Hmmm... it seems we can do a bit better here with shorter retry
> interval.  The driver probably spins up in 5~7 secs.  The rest is wasted
> here.  10secs isn't too bad tho.
> 
>> =============================
>> Booting with array turned on:
>> (disks are spun up one at a time)
>> This also includes my slim dvdrw + seagate 500gb drive.
>> =============================
> 
> Everything looks good.
> 
>> =============================
>> Array turned of without rmmod'ing sata_sil24:
>> =============================
> [--snip--]
>> [  351.479090] ata1.15: failed to read PMP product ID
>> [  351.479096] ata1.15: retrying hardreset
>> [  351.479106] ata1.15: hard resetting link
>> [  356.566580] ata1.15: SATA link down (SStatus 1 SControl 0)
>> [  356.822165] ata1.15: failed to read PMP GSCR[0] (errno=-5)
>> [  356.822172] ata1.15: PMP revalidation failed (errno=-5)
>> [  356.822179] ata1.15: limiting SATA link speed to 1.5 Gbps
>> [  356.822184] ata1.15: retrying hardreset in 5 secs
>> [  361.817800] ata1.15: hard resetting link
>> [  366.905308] ata1.15: SATA link down (SStatus 1 SControl 10)
>> [  367.160893] ata1.15: failed to read PMP GSCR[0] (errno=-5)
>> [  367.160900] ata1.15: PMP revalidation failed (errno=-5)
>> [  367.160906] ata1.15: retrying hardreset in 5 secs
>> .. and continues to retry
> 
> The retry limit is 5 times.  Because losing PMP makes all downstream
> devices detached, I thought it's worth to try hard.  If you put another
> device including another PMP there, libata will give up the current one
> quickly (after only two tries).
> 
>> =============================
>> Array turned on again:
>> =============================
>> (continued from above)
>> [  372.156532] ata1.15: hard resetting link
>> [  377.244059] ata1.15: SATA link down (SStatus 1 SControl 10)
>> [  377.499621] ata1.15: failed to read PMP GSCR[0] (errno=-5)
>> [  377.499628] ata1.15: PMP revalidation failed (errno=-5)
>> [  377.499635] ata1.15: retrying hardreset in 5 secs
>> [  382.495257] ata1.15: hard resetting link
>> [  387.582767] ata1.15: SATA link down (SStatus 1 SControl 10)
>> [  387.838349] ata1.15: failed to read PMP GSCR[0] (errno=-5)
>> [  387.838356] ata1.15: PMP revalidation failed (errno=-5)
> 
> Ah... This is unfortunate.  Even though the array was turned back on, it
> failed to respond to the last two tries resulting in detachment.  I
> wonder why it failed to respond to two tries.  Is this behavior
> reproducible?  If so, does updating firmware of PMP help?
> 
>> [  387.838360] ata1.15: failed to recover PMP after 3 tries, giving up
> 
> Ummm.... This should have been five.
> 
>> [  387.838365] ata1.15: Port Multiplier detaching
>> [  387.838391] ata1.00: disabled
>> [  387.838398] ata1.04: disabled
>> [  387.838403] ata1.00: disabled
> 
> The rest looks fine.
> 
>> ==============================
>> Disk in bay 2 reinserted:
>> ==============================
>> [  600.263465] ata1.00: exception Emask 0x10 SAct 0x0 SErr 0x4050000
>> action 0xb
>> [  600.295411] ata1.00: hard resetting link
>> [  601.193925] ata1.00: softreset failed (SRST command error)
>> [  601.193933] ata1.00: reset failed (errno=-5), retrying in 10 secs
>> [  610.278721] ata1.00: hard resetting link
>> [  611.305018] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> [  611.350966] ata1.00: ATA-7: ST3750640AS, 3.AAE, max UDMA/133
>> [  611.350974] ata1.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
>> [  611.409167] ata1.00: configured for UDMA/100
>> [  611.424823] ata1: EH complete
> 
> Pretty, isn't it?  :-)
> 
> Thanks.
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGiWgk+vG8YFo3LPMRAoL1AJ4m56jlJhCg8vHkc3IfPawjQKDpaQCZAUvn
fqLn3FmJtLC0tk47ncuFVa0=
=ssXd
-----END PGP SIGNATURE-----
