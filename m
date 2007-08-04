From: Micael Beronius <micael.beronius@telia.com>
Subject: Marvell 6141 - Am I too early?
Date: Sat, 4 Aug 2007 10:11:48 +0000 (UTC)
Message-ID: <loom.20070804T113004-944@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:42813 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752361AbXHDKaI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 4 Aug 2007 06:30:08 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IHGtW-0006iV-3s
	for linux-ide@vger.kernel.org; Sat, 04 Aug 2007 12:30:02 +0200
Received: from 81-235-178-139-no54.tbcn.telia.com ([81.235.178.139])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sat, 04 Aug 2007 12:30:02 +0200
Received: from micael.beronius by 81-235-178-139-no54.tbcn.telia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sat, 04 Aug 2007 12:30:02 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


I have an Asus M2N32WS Pro motherboard (amd64), which has the Marvell 6141 
controller on board (1 eSata, 3 internal sata and one PATA).

Well, I have been trying to get this controller to work, as I have a raid set 
of 9 disks to get going. But reading everything I can on the Marvell 6141 does 
not make me more clever exactly.. ;-)

I have understood that the AHCI got some support for this in the spring, I also 
find some people that had to change the line { PCI_VDEVICE(MARVELL, 0x6145), 
board_ahci_mv }, into 0x6141 instead, to get the AHCI to see the chip. Well, so 
far so good, I also had to do this. I have looked at kernels 2.6.23-rc1, 
linux-2.6.23-rc1-mm2 and linux-2.6.22-gentoo-r2.

Also, I understand that there may be MSI and NCQ issues. AFAIK, I have both 
disabled, yet, it does not work reliable for me. And perhaps it should not work 
at all?

Working with one disk seams to be OK, i.e. if I only mount one (of three disks 
on this controller) and copy data to/from it. (Simple test by copying 2.7G 
(cp -r /usr/*)). But if I spawn three "cp -r /usr/* /mnt/disk1 
&", "cp -r /usr/* /mnt/disk2 &" and "cp -r /usr/* /mnt/disk3 &" OR tries to 
create a RAID5 set with any of these disks, I get into trouble within seconds. 
Dmesg fills with a lot of errors quickly.

There's no issues with the nvidia sata controller on the board, which houses 6 
disks, so I figure that the issues is either that I am trying to get something 
to work, which is simple not supposed to work at all, or this is a plain bug.


So here's some logs;
lspci
[...]
08:00.0 SATA controller: Marvell Technology Group Ltd. Unknown device 6141 (rev 
01)

dmesg;
[...]
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE-MCP55: IDE controller at PCI slot 0000:00:0c.0
NFORCE-MCP55: chipset revision 161
NFORCE-MCP55: not 100% native mode: will probe irqs later
NFORCE-MCP55: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE-MCP55: 0000:00:0c.0 (rev a1) UDMA133 controller
    ide0: BM-DMA at 0xf400-0xf407, BIOS settings: hda:DMA, hdb:DMA
Probing IDE interface ide0...
hda: ST3320620A, ATA DISK drive
hda: selected mode 0x45
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: max request size: 512KiB
hda: 625142448 sectors (320072 MB) w/16384KiB Cache, CHS=38913/255/63, 
UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3
ahci 0000:08:00.0: version 2.3
ACPI: PCI Interrupt 0000:08:00.0[A] -> Link [APC7] -> GSI 16 (level, low) -> 
IRQ 16
ahci 0000:08:00.0: controller can't do NCQ, turning off CAP_NCQ
ahci 0000:08:00.0: MV_AHCI HACK: port_map 0 -> 0
ahci 0000:08:00.0: nr_ports (5) and implemented port map (0xf) don't match
ahci 0000:08:00.0: AHCI 0001.0000 32 slots 5 ports 3 Gbps 0xf impl SATA mode
ahci 0000:08:00.0: flags: 64bit stag nz only pmp slum part
PCI: Setting latency timer of device 0000:08:00.0 to 64
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
ata1: SATA max UDMA/133 cmd 0xffffc20000026100 ctl 0x0000000000000000 bmdma 
0x0000000000000000 irq 16
ata2: SATA max UDMA/133 cmd 0xffffc20000026180 ctl 0x0000000000000000 bmdma 
0x0000000000000000 irq 16
ata3: SATA max UDMA/133 cmd 0xffffc20000026200 ctl 0x0000000000000000 bmdma 
0x0000000000000000 irq 16
ata4: SATA max UDMA/133 cmd 0xffffc20000026280 ctl 0x0000000000000000 bmdma 
0x0000000000000000 irq 16
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 123)
ata1.00: ATA-8: SAMSUNG HD501LJ, CR100-10, max UDMA7
ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata1.00: configured for UDMA/133
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 123)
ata2.00: ATA-8: SAMSUNG HD501LJ, CR100-10, max UDMA7
ata2.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata2.00: configured for UDMA/133
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 123)
ata3.00: ATA-8: SAMSUNG HD501LJ, CR100-10, max UDMA7
ata3.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata3.00: configured for UDMA/133
ata4: SATA link down (SStatus 0 SControl 0)
scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG HD501LJ  CR10 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support 
DPO or FUA
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support 
DPO or FUA
 sda: sda1
sd 0:0:0:0: [sda] Attached SCSI disk
scsi 1:0:0:0: Direct-Access     ATA      SAMSUNG HD501LJ  CR10 PQ: 0 ANSI: 5
sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support 
DPO or FUA
sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support 
DPO or FUA
 sdb: sdb1
sd 1:0:0:0: [sdb] Attached SCSI disk
scsi 2:0:0:0: Direct-Access     ATA      SAMSUNG HD501LJ  CR10 PQ: 0 ANSI: 5
sd 2:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support 
DPO or FUA
sd 2:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support 
DPO or FUA
 sdc: sdc1
sd 2:0:0:0: [sdc] Attached SCSI disk
sata_nv 0000:00:0d.0: version 3.4
ACPI: PCI Interrupt Link [APSI] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [APSI] -> GSI 21 (level, low) -> 
IRQ 21
PCI: Setting latency timer of device 0000:00:0d.0 to 64
scsi4 : sata_nv
[...]

And when I try to create a raid set, I get these errors;
(mdadm --create /dev/md1 --level=5 --raid-devices=3 /dev/sd[abc]1) 

md: bind<sda1>
md: bind<sdb1>
md: bind<sdc1>
raid5: device sdb1 operational as raid disk 1
raid5: device sda1 operational as raid disk 0
raid5: allocated 3224kB for md1
raid5: raid level 5 set md1 active with 2 out of 3 devices, algorithm 2
RAID5 conf printout:
 --- rd:3 wd:2
 disk 0, o:1, dev:sda1
 disk 1, o:1, dev:sdb1
RAID5 conf printout:
 --- rd:3 wd:2
 disk 0, o:1, dev:sda1
 disk 1, o:1, dev:sdb1
 disk 2, o:1, dev:sdc1
md: recovery of RAID array md1
md: minimum _guaranteed_  speed: 1000 KB/sec/disk.
md: using maximum available idle IO bandwidth (but not more than 200000 KB/sec) 
for recovery.
md: using 128k window, over a total of 488383936 blocks.
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3.00: cmd 35/00:00:3f:37:00/00:04:00:00:00/e0 tag 0 cdb 0x0 data 524288 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: cmd 25/00:00:3f:3b:00/00:02:00:00:00/e0 tag 0 cdb 0x0 data 262144 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3: soft resetting port
ata1: soft resetting port
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 123)
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 123)
ata3.00: qc timeout (cmd 0xec)
ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata3.00: revalidation failed (errno=-5)
ata3: failed to recover some devices, retrying in 5 secs
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1.00: revalidation failed (errno=-5)
ata1: failed to recover some devices, retrying in 5 secs
ata3: hard resetting port
ata1: hard resetting port
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 123)
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 123)




OK, if someone are still reading, :) how can I proceed?

Thanks,
 Micael


