From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: link is slow to respond, please be patient
Date: Fri, 1 Jul 2011 11:01:56 +0200
Message-ID: <BANLkTikSFKEbDCh0L-A-zoYeB3perJzN3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52022 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755516Ab1GAJCS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Jul 2011 05:02:18 -0400
Received: by iyb12 with SMTP id 12so2623859iyb.19
        for <linux-ide@vger.kernel.org>; Fri, 01 Jul 2011 02:02:18 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi community,

during some boots I got some delays caused by problems with ahci.
Here are some important parts of dmesg

[    1.489748] ahci 0000:02:06.0: version 3.0
[    1.489806] ahci 0000:02:06.0: PCI INT D -> GSI 17 (level, low) -> IRQ 17
[    1.499888] ahci 0000:02:06.0: irq 40 for MSI/MSI-X
[    1.499970] ahci: SSS flag set, parallel bus scan disabled
[    1.509999] ahci 0000:02:06.0: AHCI 0001.0100 32 slots 2 ports 3
Gbps 0x3 impl SATA mode
[    1.530575] ahci 0000:02:06.0: flags: ncq sntf stag pm led clo only
pmp pio slum part ccc
[    1.553243] ahci 0000:02:06.0: setting latency timer to 64
[    1.555153] scsi0 : ahci
[    1.567174] scsi1 : ahci
[    1.578902] ata1: SATA max UDMA/133 abar m1024@0xd0150000 port
0xd0150100 irq 40
[    1.602065] ata2: SATA max UDMA/133 abar m1024@0xd0150000 port
0xd0150180 irq 40

..

[    6.966133] ata1.00: qc timeout (cmd 0xf8)
[    6.976514] ata1.00: failed to read native max address (err_mask=0x4)
[    6.986874] ata1.00: HPA support seems broken, skipping HPA handling
[   12.351097] ata1: link is slow to respond, please be patient (ready=0)
[   17.002126] ata1: COMRESET failed (errno=-16)
[   17.316160] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   17.326003] ata1.00: ATA-7: SFCA4096H1BR4SA-I-D0-216-STD, 20100106,
max UDMA/133
[   17.345593] ata1.00: 7876512 sectors, multi 0: LBA
[   17.356196] ata1.00: configured for UDMA/133
[   17.366705] scsi 0:0:0:0: Direct-Access     ATA
SFCA4096H1BR4SA- 2010 PQ: 0 ANSI: 5
[   17.388704] sd 0:0:0:0: [sda] 7876512 512-byte logical blocks:
(4.03 GB/3.75 GiB)
[   17.410993] sd 0:0:0:0: [sda] Write Protect is off
[   17.422086] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   17.422199] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   17.444823]  sda: sda1 sda2
[   17.456766] sd 0:0:0:0: [sda] Attached SCSI disk
[   17.725177] ata2: SATA link down (SStatus 0 SControl 300)


02:06.0 SATA controller [0106]: Intel Corporation Platform Controller
Hub EG20T SATA AHCI Controller [8086:880b] (rev 01) (prog-if 01 [AHCI
1.0])
	Flags: bus master, fast devsel, latency 0, IRQ 40
	I/O ports at e000 [size=32]
	Memory at d0150000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at d0100000 [disabled] [size=128K]
	Capabilities: [40] MSI: Enable+ Count=1/1 Maskable- 64bit-
	Capabilities: [50] Power Management version 2
	Capabilities: [60] SATA HBA v1.0
	Kernel driver in use: ahci

Any ideas?

--
Christian Gmeiner, MSc
