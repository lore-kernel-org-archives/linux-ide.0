From: Alexander Sabourenkov <screwdriver@lxnt.info>
Subject: Re: Sata Sil3512 bug?;  Promise SATA300 TX4
Date: Fri, 19 Oct 2007 01:07:28 +0400
Message-ID: <4717CB10.3080509@lxnt.info>
References: <200710030726.l937QXuV026661@harpo.it.uu.se> <47035355.2040405@lxnt.info> <135469746.20071017143929@zonnet.nl> <47160601.80506@lxnt.info> <1785297944.20071017170444@zonnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.lxnt.info ([217.23.143.142]:54452 "EHLO mail.lxnt.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759889AbXJRVQ4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 Oct 2007 17:16:56 -0400
In-Reply-To: <1785297944.20071017170444@zonnet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: MisterE <MisterE2002@zonnet.nl>, Mikael Pettersson <mikpe@it.uu.se>, htejun@gmail.com, alan@lxorguk.ukuu.org.uk, benh@kernel.crashing.org, jgarzik@pobox.com, jeff@garzik.org

Hello.


I have done some quick tests with 2.6.23/amd64 and unfortunately, the
very same problem persists.

By the way, 8 in (port_status 0x20080000) stands for
        PDC_OVERRUN_ERR         = (1 << 19), /* S/G byte count larger
than HD requires */


Does by any chance 'S/G' here somehow relate to 'sg in the 'sg-chaining
work' there is so much talk about on the -kernel mailing list?



In a somewhat parallel development, write errors caused my (other) md
RAID-1 to lose one drive while copying data under 2.6.22
from TX4-attached drives to onboard-VIA-attached ones.

Device: VIA VT6420
00:0f.0 0104: 1106:3149 (rev 80)

Boot:

Oct 17 21:28:25 host sata_via 0000:00:0f.0: version 2.2
Oct 17 21:28:25 host ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20
(level, low) -> IRQ 17
Oct 17 21:28:25 host sata_via 0000:00:0f.0: routed to hard irq line 10
Oct 17 21:28:25 host scsi4 : sata_via
Oct 17 21:28:25 host scsi5 : sata_via

Oct 17 21:28:25 host ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Oct 17 21:28:25 host ata6.00: ATA-7: ST3200827AS, 3.AAH, max UDMA/133
Oct 17 21:28:25 host ata6.00: 390721968 sectors, multi 0: LBA48 NCQ
(depth 0/32)
Oct 17 21:28:25 host ata6.00: configured for UDMA/133

... the first two port resets:

Oct 17 23:10:50 host ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0
action 0x2
Oct 17 23:10:50 host ata6.00: (BMDMA stat 0x4)
Oct 17 23:10:50 host ata6.00: cmd ca/00:08:e7:30:00/00:00:00:00:00/e0
tag 0 cdb 0x0 data 4096 out
Oct 17 23:10:50 host res 51/84:08:e7:30:00/00:00:00:00:00/e0 Emask 0x10
(ATA bus error)
Oct 17 23:10:50 host ata6: soft resetting port
Oct 17 23:10:50 host ata6.00: configured for UDMA/133
Oct 17 23:10:50 host ata6: EH complete
Oct 17 23:10:50 host sd 5:0:0:0: [sdd] 390721968 512-byte hardware
sectors (200050 MB)
Oct 17 23:10:50 host sd 5:0:0:0: [sdd] Write Protect is off
Oct 17 23:10:50 host sd 5:0:0:0: [sdd] Mode Sense: 00 3a 00 00
Oct 17 23:10:50 host sd 5:0:0:0: [sdd] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
Oct 17 23:10:50 host ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0
action 0x2
Oct 17 23:10:50 host ata6.00: (BMDMA stat 0x5)
Oct 17 23:10:50 host ata6.00: cmd ca/00:f8:4f:31:00/00:00:00:00:00/e0
tag 0 cdb 0x0 data 126976 out
Oct 17 23:10:50 host res 51/84:f8:4f:31:00/00:00:00:00:00/e0 Emask 0x10
(ATA bus error)
Oct 17 23:10:50 host ata6: soft resetting port
Oct 17 23:10:50 host ata6.00: configured for UDMA/133
Oct 17 23:10:50 host ata6: EH complete
Oct 17 23:10:50 host sd 5:0:0:0: [sdd] 390721968 512-byte hardware
sectors (200050 MB)
Oct 17 23:10:50 host sd 5:0:0:0: [sdd] Write Protect is off
Oct 17 23:10:50 host sd 5:0:0:0: [sdd] Mode Sense: 00 3a 00 00
Oct 17 23:10:50 host sd 5:0:0:0: [sdd] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA

... and multiple unsuccessful port resets follow:

Oct 17 23:11:57 host ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0
action 0x2 frozen
Oct 17 23:11:57 host ata6.00: cmd 25/00:08:7f:bf:28/00:00:16:00:00/e0
tag 0 cdb 0x0 data 4096 in
Oct 17 23:11:57 host res 40/00:f8:4f:31:00/00:00:00:00:00/e0 Emask 0x4
(timeout)
Oct 17 23:12:02 host ata6: port is slow to respond, please be patient
(Status 0xd0)
Oct 17 23:12:07 host ata6: soft resetting port
Oct 17 23:12:37 host ata6.00: qc timeout (cmd 0xec)
Oct 17 23:12:37 host ata6.00: failed to IDENTIFY (I/O error, err_mask=0x4)
Oct 17 23:12:37 host ata6.00: revalidation failed (errno=-5)
Oct 17 23:12:37 host ata6: failed to recover some devices, retrying in 5
secs
Oct 17 23:12:47 host ata6: port is slow to respond, please be patient
(Status 0xd0)
Oct 17 23:12:52 host ata6: soft resetting port
Oct 17 23:13:22 host ata6.00: qc timeout (cmd 0xec)
Oct 17 23:13:22 host ata6.00: failed to IDENTIFY (I/O error, err_mask=0x4)
Oct 17 23:13:22 host ata6.00: revalidation failed (errno=-5)
Oct 17 23:13:22 host ata6.00: limiting speed to UDMA/133:PIO3
Oct 17 23:13:22 host ata6: failed to recover some devices, retrying in 5
secs
Oct 17 23:13:32 host ata6: port is slow to respond, please be patient
(Status 0xd0)
Oct 17 23:13:37 host ata6: soft resetting port
Oct 17 23:14:08 host ata6.00: qc timeout (cmd 0xec)
Oct 17 23:14:08 host ata6.00: failed to IDENTIFY (I/O error, err_mask=0x4)
Oct 17 23:14:08 host ata6.00: revalidation failed (errno=-5)
Oct 17 23:14:08 host ata6.00: disabled
Oct 17 23:14:08 host ata6: EH complete
Oct 17 23:14:08 host sd 5:0:0:0: [sdd] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
Oct 17 23:14:08 host end_request: I/O error, dev sdd, sector 371769215
Oct 17 23:14:08 host raid1: sdd1: rescheduling sector 371769152
Oct 17 23:14:08 host sd 5:0:0:0: [sdd] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
Oct 17 23:14:08 host end_request: I/O error, dev sdd, sector 390379327
Oct 17 23:14:08 host md: super_written gets error=-5, uptodate=0
Oct 17 23:14:08 host raid1: Disk failure on sdd1, disabling device.

I'm unable to reproduce this on 2.6.23, so this is of historic interest
only.

-- 

./lxnt
