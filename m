From: "KueiHuan Chen" <kueihuan.chen@gmail.com>
Subject: SATA port multiplier(Marvell 6121 with ahci) and Marvell 4140, simg 3726
Date: Thu, 31 Jul 2008 11:37:42 +0800
Message-ID: <788014650807302037vd942056r103205ac6f3b9c7a@mail.gmail.com>
Reply-To: khchen@synology.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.229]:46167 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755438AbYGaDhn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jul 2008 23:37:43 -0400
Received: by rv-out-0506.google.com with SMTP id k40so361531rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 30 Jul 2008 20:37:42 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux-ide@vger.kernel.org

Hello,

  This is the resent mail, because original one was deny by vger.kernel.org.

  We got some problem while evaluation port multipiler with libata, we
had tested with two sata chip, one is sil-3132, the another is Marvell
6121. And we also have two port multiplie: Marvell 4140 and Sil-3726.
Our kernel version is kernel-2.6.24 with Marvell 5281 platform.

  Testing result:

  Sil 3132 with 3726 and 4140: everything looks like fine.

  Marvell 6121 with 3726 and 4140(using ahci.c): both port multipiler
would got problem. It can't be detected whether hotplug or at boot
time. But the disk detection is fine without port multiplier.
  Because we can't upgrade kernel to latest version so quickly, is
there any hint or solution for us ?

Thanks a lot.

Here is the boot message:
The boot message of 6121 and 4140:
-----------------------------------------------
Driver 'sd' needs updating - please use bus_type methods
ahci 0000:00:01.0: controller can't do NCQ, turning off CAP_NCQ
ahci 0000:00:01.0: MV_AHCI HACK: port_map 7 -> 3
ahci 0000:00:01.0: nr_ports (3) and implemented port map (0x3) don't
match, using nr_ports
ahci 0000:00:01.0: forcing PORTS_IMPL to 0x7
ahci 0000:00:01.0: AHCI 0001.0000 32 slots 3 ports 3 Gbps 0x7 impl IDE mode
ahci 0000:00:01.0: flags: 64bit stag led pmp slum part
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
ata1: SATA max UDMA/133 abar m1024@0xe0000000 port 0xe0000100 irq 11
ata2: SATA max UDMA/133 abar m1024@0xe0000000 port 0xe0000180 irq 11
ata3: SATA max UDMA/133 abar m1024@0xe0000000 port 0xe0000200 irq 11
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-7: Hitachi HDT725050VLA360, V56OA7EA, max UDMA/133
ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata1.00: configured for UDMA/133
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.15: qc timeout (cmd 0xe4)
ata2.15: failed to read PMP GSCR[0] (Emask=0x4)
ata2: failed to recover some devices, retrying in 2 secs
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.15: qc timeout (cmd 0xe4)
ata2.15: failed to read PMP GSCR[0] (Emask=0x4)
ata2: failed to recover some devices, retrying in 2 secs
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.15: qc timeout (cmd 0xe4)
ata2.15: failed to read PMP GSCR[0] (Emask=0x4)
ata2: failed to recover some devices, retrying in 2 secs
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3: SATA link down (SStatus 0 SControl 0)
scsi 0:0:0:0: Direct-Access     ATA      Hitachi HDT72505 V56O PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sda: sda1 sda2 sda3
sd 0:0:0:0: [sda] Attached SCSI disk
physmap platform flash device: 00400000 at ffc00000
The boot message of 6121 and 3726:
-----------------------------------------------
Driver 'sd' needs updating - please use bus_type methods
ahci 0000:00:01.0: controller can't do NCQ, turning off CAP_NCQ
ahci 0000:00:01.0: MV_AHCI HACK: port_map 7 -> 3
ahci 0000:00:01.0: nr_ports (3) and implemented port map (0x3) don't
match, using nr_ports
ahci 0000:00:01.0: forcing PORTS_IMPL to 0x7
ahci 0000:00:01.0: AHCI 0001.0000 32 slots 3 ports 3 Gbps 0x7 impl IDE mode
ahci 0000:00:01.0: flags: 64bit stag led pmp slum part
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
ata1: SATA max UDMA/133 abar m1024@0xe0000000 port 0xe0000100 irq 11
ata2: SATA max UDMA/133 abar m1024@0xe0000000 port 0xe0000180 irq 11
ata3: SATA max UDMA/133 abar m1024@0xe0000000 port 0xe0000200 irq 11
Delay 10 seconds to wait for disk 1 ready.
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-7: Hitachi HDT725050VLA360, V56OA7EA, max UDMA/133
ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata1.00: configured for UDMA/133
Delay 10 seconds to wait for disk 2 ready.
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.15: qc time(cmd 0xe4)
ata2.15: failed to read PMP GSCR[0] (Emask=0x4)
ata2: failed to recover some devices, retrying in 2 secs
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.15: qc timeout (cmd 0xe4)
ata2.15: failed to read PMP GSCR[0] (Emask=0x4)
ata2: failed to recover some devices, retrying in 2 secs
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.15: qc timeout (cmd 0xe4)
ata2.15: failed to read PMP GSCR[0] (Emask=0x4)
ata2: failed to recover some devices, retrying in 2 secs
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3: SATA link down (SStatus 0 SControl 0)
scsi 0:0:0:0: Direct-Access     ATA      Hitachi HDT72505 V56O PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sda: sda1 sda2 sda3
sd 0:0:0:0: [sda] Attached SCSI disk
physmap platform flash device: 00400000 at ffc00000
---
Thanks,
KueiHuan-Chen
