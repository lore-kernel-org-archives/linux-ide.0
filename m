From: Leon Woestenberg <leon.woestenberg@gmail.com>
Subject: sata_sil24 driver / Sil3132 controller fails on powerpc
Date: Fri, 1 Apr 2011 13:52:14 +0200
Message-ID: <AANLkTikuC3PxPhiH7xNEomaoF-MKx0+VVwgz6YMwyxvj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45150 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753549Ab1DALwQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Apr 2011 07:52:16 -0400
Received: by bwz15 with SMTP id 15so2454389bwz.19
        for <linux-ide@vger.kernel.org>; Fri, 01 Apr 2011 04:52:14 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I see the sata_sil24 / Sil 3132 fail on my system.

Linux 2.6.38
Silicon Image 3132 Mini-PCI Express card on the Freescale PowerPC
e500v2 based SoC on the P1020RDB board
Intel SSD attached.

MSI disabled already fails during IDENTIFY phase.
MSI enables does ok for small transfers, but fails on larger transfers.

Inspecting the driver source, I notice PCI flushing reads are missing
at points I would expect them.

static int sil24_exec_polled_cmd(struct ata_port *ap, int pmp,
				 const struct ata_taskfile *tf,
				 int is_cmd, u32 ctrl,
				 unsigned long timeout_msec)
{
        <...>
	writel(irq_mask, port + PORT_IRQ_STAT); /* clear IRQs */
        <...>
	/* restore IRQ enabled */
	writel(irq_enabled, port + PORT_IRQ_ENABLE_SET);   <----------------
PCI flushing read required ??!
	return rc;
}

modprobe sata_sil

[    8.834613] sata_sil24 0001:03:00.0: version 1.1
[    8.885581] scsi0 : sata_sil24
[    8.901420] scsi1 : sata_sil24
[    8.904642] ata1: SATA max UDMA/100 host m128@0xc0000000 port
0xc0004000 irq 16
[    8.911961] ata2: SATA max UDMA/100 host m128@0xc0000000 port
0xc0006000 irq 16
[   11.095127] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   14.906986] eth0: no IPv6 routers present
[   16.099016] ata1.00: qc timeout (cmd 0xec)
[   16.103128] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   18.299050] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   28.303026] ata1.00: qc timeout (cmd 0xec)
[   28.307139] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   28.313233] ata1: limiting SATA link speed to 1.5 Gbps
[   30.523059] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 10)


modprobe sata_sil msi=1

[   92.984120] sata_sil24 0001:03:00.0: version 1.1
[   92.988897] irq: irq 0 on host /soc@ffe00000/msi@41600 mapped to
virtual irq 41
[   92.996229] sata_sil24 0001:03:00.0: Using MSI
[   93.000675] sata_sil24 0001:03:00.0: enabling bus mastering
[   93.011628] scsi2 : sata_sil24
[   93.022463] scsi3 : sata_sil24
[   93.025695] ata3: SATA max UDMA/100 host m128@0xc0000000 port
0xc0004000 irq 41
[   93.033023] ata4: SATA max UDMA/100 host m128@0xc0000000 port
0xc0006000 irq 41
[   95.203029] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   95.209045] ata3: spurious interrupt (slot_stat 0x0 active_tag
-84148995 sactive 0x0)
[   95.217171] ata3.00: ATA-7: INTEL SSDSA2M080G2GN, 2CV102HD, max UDMA/133
[   95.223882] ata3.00: 156301488 sectors, multi 1: LBA48 NCQ (depth 31/32)
[   95.230905] ata3.00: configured for UDMA/100
[   95.235399] scsi 2:0:0:0: Direct-Access     ATA      INTEL
SSDSA2M080 2CV1 PQ: 0 ANSI: 5
[   95.244002] sd 2:0:0:0: Attached scsi generic sg0 type 0
[   95.252041] sd 2:0:0:0: [sda] 156301488 512-byte logical blocks:
(80.0 GB/74.5 GiB)
[   95.260219] sd 2:0:0:0: [sda] Write Protect is off
[   95.265063] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   95.270500] sd 2:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   95.283779]  sda: sda1 sda2 sda3 sda4
[   95.289482] sd 2:0:0:0: [sda] Attached SCSI disk
[   95.965897] EXT3-fs: barriers not enabled
[   95.977279] kjournald starting.  Commit interval 5 seconds
[   95.983296] EXT3-fs (sda2): using internal journal
[   95.988143] EXT3-fs (sda2): recovery complete
[   95.992504] EXT3-fs (sda2): mounted filesystem with writeback data mode
[   96.111587] NTFS volume version 3.1.
[   97.331005] ata4: SATA link down (SStatus 0 SControl 0)

root@p1020rdb:~# dd if=/dev/sda of=/dev/null bs=4k count=1000
1000+0 records in
1000+0 records out
4096000 bytes (4.1 MB) copied, 0.0315629 s, 130 MB/s
root@p1020rdb:~# dd if=/dev/sda of=/dev/null bs=4k count=10000
10000+0 records in
10000+0 records out
40960000 bytes (41 MB) copied, 0.471802 s, 86.8 MB/s

root@p1020rdb:~# dd if=/dev/sda of=/dev/null bs=4k count=100000

That stalls, I see the controller fail. See dmesg below:

^C^Cdd: reading `/dev/sda': Input/output error
51804+0 records in
51804+0 records out
212189184 bytes (212 MB) copied, 85.6537 s, 2.5 MB/s
dd: closing input file `/dev/sda': Bad file descriptor


[   92.984120] sata_sil24 0001:03:00.0: version 1.1
[   92.988897] irq: irq 0 on host /soc@ffe00000/msi@41600 mapped to
virtual irq 41
[   92.996229] sata_sil24 0001:03:00.0: Using MSI
[   93.000675] sata_sil24 0001:03:00.0: enabling bus mastering
[   93.011628] scsi2 : sata_sil24
[   93.022463] scsi3 : sata_sil24
[   93.025695] ata3: SATA max UDMA/100 host m128@0xc0000000 port
0xc0004000 irq 41
[   93.033023] ata4: SATA max UDMA/100 host m128@0xc0000000 port
0xc0006000 irq 41
[   95.203029] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   95.209045] ata3: spurious interrupt (slot_stat 0x0 active_tag
-84148995 sactive 0x0)
[   95.217171] ata3.00: ATA-7: INTEL SSDSA2M080G2GN, 2CV102HD, max UDMA/133
[   95.223882] ata3.00: 156301488 sectors, multi 1: LBA48 NCQ (depth 31/32)
[   95.230905] ata3.00: configured for UDMA/100
[   95.235399] scsi 2:0:0:0: Direct-Access     ATA      INTEL
SSDSA2M080 2CV1 PQ: 0 ANSI: 5
[   95.244002] sd 2:0:0:0: Attached scsi generic sg0 type 0
[   95.252041] sd 2:0:0:0: [sda] 156301488 512-byte logical blocks:
(80.0 GB/74.5 GiB)
[   95.260219] sd 2:0:0:0: [sda] Write Protect is off
[   95.265063] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   95.270500] sd 2:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   95.283779]  sda: sda1 sda2 sda3 sda4
[   95.289482] sd 2:0:0:0: [sda] Attached SCSI disk
[   95.965897] EXT3-fs: barriers not enabled
[   95.977279] kjournald starting.  Commit interval 5 seconds
[   95.983296] EXT3-fs (sda2): using internal journal
[   95.988143] EXT3-fs (sda2): recovery complete
[   95.992504] EXT3-fs (sda2): mounted filesystem with writeback data mode
[   96.111587] NTFS volume version 3.1.
[   97.331005] ata4: SATA link down (SStatus 0 SControl 0)
[  285.891036] ata3.00: exception Emask 0x0 SAct 0x3 SErr 0x0 action 0x6 frozen
[  285.898099] ata3.00: failed command: READ FPDMA QUEUED
[  285.903250] ata3.00: cmd 60/00:00:e0:53:06/01:00:00:00:00/40 tag 0
ncq 131072 in
[  285.903255]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)
[  285.918028] ata3.00: status: { DRDY }
[  285.921689] ata3.00: failed command: READ FPDMA QUEUED
[  285.926836] ata3.00: cmd 60/00:08:e0:52:06/01:00:00:00:00/40 tag 1
ncq 131072 in
[  285.926841]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)
[  285.941615] ata3.00: status: { DRDY }
[  285.945281] ata3: hard resetting link
[  288.055034] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  293.058999] ata3.00: qc timeout (cmd 0xec)
[  293.063106] ata3.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[  293.069198] ata3.00: revalidation failed (errno=-5)
[  293.074077] ata3: hard resetting link
[  295.259018] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 0)

What can I do next to investigate and help fix this issue?

Regards,
-- 
Leon
